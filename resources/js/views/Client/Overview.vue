<template>
  <div class="p-6">
    <h2 class="text-2xl font-bold mb-6">Overview</h2>

    <!-- Earnings Section -->
    <div class="bg-white rounded-lg shadow p-6 mb-6">
      <h3 class="text-xl font-semibold mb-4">My Earnings</h3>
      
      <div v-if="loading.earnings" class="text-center py-4">
        <span class="text-gray-600">Loading earnings...</span>
      </div>
      
      <div v-else class="mb-4">
        <p class="text-lg">Available Balance: ${{ totalEarnings.toFixed(2) }}</p>
        <p class="text-sm text-gray-600">These are your bonuses from successful meetings</p>
      </div>
      
      <div v-if="totalEarnings > 0">
        <div class="mb-4">
          <label class="block text-sm font-medium text-gray-700">PayPal Email</label>
          <input 
            v-model="withdrawalEmail" 
            type="email" 
            class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500"
            placeholder="Enter your PayPal email"
          />
        </div>
        <button 
          @click="requestWithdrawal" 
          class="px-4 py-2 bg-blue-500 text-white rounded-lg hover:bg-blue-600 disabled:bg-gray-400"
          :disabled="!withdrawalEmail || withdrawalEmail.trim() === '' || loading.action"
        >
          {{ loading.action ? 'Processing...' : 'Request Withdrawal' }}
        </button>
      </div>
    </div>

    <!-- Recent Meetings Section -->
    <div class="bg-white rounded-lg shadow p-6">
      <h3 class="text-xl font-semibold mb-4">Recent Meetings</h3>
      
      <div v-if="loading.meetings" class="text-center py-4">
        <span class="text-gray-600">Loading meetings...</span>
      </div>
      
      <div v-else class="space-y-4">
        <div v-for="meeting in recentMeetings" :key="meeting.id" class="border rounded-lg p-4">
          <div class="flex justify-between items-start mb-3">
            <div>
              <h4 class="font-semibold">Meeting with {{ meeting.matchmaker.name }}</h4>
              <p class="text-sm text-gray-600">{{ formatDate(meeting.start_time) }}</p>
            </div>
            <div class="text-right">
              <span 
                :class="[
                  'px-3 py-1 text-sm rounded-full',
                  getStatusClass(meeting.status)
                ]"
              >
                {{ meeting.status }}
              </span>
            </div>
          </div>

          <!-- Review Actions -->
          <div v-if="canReview(meeting)" class="mt-4 border-t pt-4">
            <p class="text-sm text-gray-700 mb-3">
              How was your meeting? Please provide feedback within 24 hours.
            </p>
            <div class="flex gap-3">
              <button 
                @click="markMeetingSuccessful(meeting.id)"
                class="px-4 py-2 bg-green-500 text-white rounded-lg hover:bg-green-600"
                :disabled="loading.action"
              >
                {{ loading.action ? 'Processing...' : 'Meeting Went Well' }}
              </button>
              <button 
                @click="showComplaintForm(meeting.id)"
                class="px-4 py-2 bg-red-500 text-white rounded-lg hover:bg-red-600"
                :disabled="loading.action"
              >
                File Complaint
              </button>
            </div>
          </div>

          <!-- Complaint Form -->
          <div v-if="selectedMeetingId === meeting.id" class="mt-4 border-t pt-4">
            <textarea
              v-model="complaintText"
              class="w-full p-2 border rounded-lg"
              rows="3"
              placeholder="Please describe your issue..."
            ></textarea>
            <div class="mt-2 flex gap-2">
              <button 
                @click="submitComplaint(meeting.id)"
                class="px-4 py-2 bg-red-500 text-white rounded-lg hover:bg-red-600"
                :disabled="loading.action || !complaintText.trim()"
              >
                {{ loading.action ? 'Submitting...' : 'Submit Complaint' }}
              </button>
              <button 
                @click="cancelComplaint"
                class="px-4 py-2 bg-gray-500 text-white rounded-lg hover:bg-gray-600"
                :disabled="loading.action"
              >
                Cancel
              </button>
            </div>
          </div>
        </div>

        <div v-if="recentMeetings.length === 0" class="text-center text-gray-500 py-8">
          No recent meetings
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { format } from 'date-fns';
import axios from 'axios';

export default {
  name: 'ClientOverview',
  data() {
    return {
      recentMeetings: [],
      totalEarnings: 0,
      withdrawalEmail: '',
      selectedMeetingId: null,
      complaintText: '',
      loading: {
        meetings: false,
        earnings: false,
        action: false
      }
    };
  },
  methods: {
    formatDate(date) {
      return format(new Date(date), 'MMM d, yyyy h:mm a');
    },
    getStatusClass(status) {
      const classes = {
        pending: 'bg-yellow-100 text-yellow-800',
        completed: 'bg-green-100 text-green-800',
        cancelled: 'bg-red-100 text-red-800'
      };
      return classes[status] || 'bg-gray-100 text-gray-800';
    },
    canReview(meeting) {
      // Check if meeting is within 24 hours and hasn't been reviewed
      const meetingTime = new Date(meeting.start_time);
      const now = new Date();
      const hoursDiff = (now - meetingTime) / (1000 * 60 * 60);
      return hoursDiff <= 24 && meeting.status === 'completed' && !meeting.review;
    },
    async fetchMeetings() {
      try {
        this.loading.meetings = true;
        const response = await axios.get('/api/client/meetings');
        if (response.data && response.data.success) {
          this.recentMeetings = response.data.data || [];
        } else {
          this.recentMeetings = [];
          this.$toast?.error?.('Failed to fetch meetings');
        }
      } catch (error) {
        console.error('Error fetching meetings:', error);
        this.recentMeetings = [];
        this.$toast?.error?.('Failed to fetch meetings');
      } finally {
        this.loading.meetings = false;
      }
    },
    async fetchEarnings() {
      try {
        this.loading.earnings = true;
        const response = await axios.get('/api/client/earnings');
        if (response.data && response.data.success && response.data.data) {
          // Check if availableBalance exists in the response
          this.totalEarnings = response.data.data.availableBalance || 0;
        } else {
          this.totalEarnings = 0;
          this.$toast?.error?.('Failed to fetch earnings');
        }
      } catch (error) {
        console.error('Error fetching earnings:', error);
        this.totalEarnings = 0;
        this.$toast?.error?.('Failed to fetch earnings');
      } finally {
        this.loading.earnings = false;
      }
    },
    async markMeetingSuccessful(meetingId) {
      try {
        this.loading.action = true;
        await axios.post(`/api/client/meetings/${meetingId}/review`, {
          status: 'satisfied'
        });
        await this.fetchMeetings();
        this.$toast?.success?.('Meeting marked as successful!');
      } catch (error) {
        console.error('Error marking meeting:', error);
        this.$toast?.error?.('Failed to update meeting status');
      } finally {
        this.loading.action = false;
      }
    },
    showComplaintForm(meetingId) {
      this.selectedMeetingId = meetingId;
      this.complaintText = '';
    },
    cancelComplaint() {
      this.selectedMeetingId = null;
      this.complaintText = '';
    },
    async submitComplaint(meetingId) {
      if (!this.complaintText.trim()) return;
      
      try {
        this.loading.action = true;
        await axios.post(`/api/client/meetings/${meetingId}/review`, {
          status: 'complained',
          complaint_text: this.complaintText
        });
        this.cancelComplaint();
        await this.fetchMeetings();
        this.$toast?.success?.('Complaint submitted successfully');
      } catch (error) {
        console.error('Error submitting complaint:', error);
        this.$toast?.error?.('Failed to submit complaint');
      } finally {
        this.loading.action = false;
      }
    },
    async requestWithdrawal() {
      if (!this.withdrawalEmail.trim()) return;
      
      try {
        this.loading.action = true;
        await axios.post('/api/client/request-withdrawal', {
          payment_email: this.withdrawalEmail
        });
        this.$toast?.success?.('Withdrawal request submitted successfully');
        await this.fetchEarnings();
        this.withdrawalEmail = '';
      } catch (error) {
        console.error('Error requesting withdrawal:', error);
        this.$toast?.error?.('Failed to submit withdrawal request');
      } finally {
        this.loading.action = false;
      }
    }
  },
  mounted() {
    this.fetchMeetings();
    this.fetchEarnings();
  }
};
</script>

<style scoped>
/* Add any component-specific styles here */
</style>
