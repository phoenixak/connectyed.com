<template>
  <div class="max-w-7xl mx-auto p-6 bg-white rounded-sm shadow-xs">
    <h2 class="text-xl font-bold mb-4">Create Date Availability</h2>

    <!-- Multiple Date Selection -->
    <div class="mb-4">
      <label class="block text-gray-700 font-bold mb-2">Select Dates:</label>
      <div v-for="(date, index) in selectedDates" :key="index" class="flex items-center space-x-2 mb-2">
        <input
          type="date"
          class="border border-gray-300 rounded p-2"
          v-model="selectedDates[index].start_date"
        />
        <input
          type="time"
          class="border border-gray-300 rounded p-2"
          v-model="selectedDates[index].start_time"
        />
        <input
          type="time"
          class="border border-gray-300 rounded p-2"
          v-model="selectedDates[index].end_time"
        />
        <button class="text-red-500 hover:text-red-700" @click="removeDate(index)">Remove</button>
      </div>
      <button @click="addNewDate" class="bg-blue-500 text-white font-bold py-2 px-4 rounded">
        Add Another Date
      </button>
    </div>

    <!-- Date Range Selection -->
    <div class="mb-4">
      <label class="block text-gray-700 font-bold mb-2">Select Date Range:</label>
      <div class="flex items-center space-x-2">
        <input type="date" class="border border-gray-300 rounded p-2" v-model="rangeStart" />
        <span>to</span>
        <input type="date" class="border border-gray-300 rounded p-2" v-model="rangeEnd" />
      </div>
    </div>

    <!-- Submit Button -->
    <button
      class="mt-4 bg-green-500 hover:bg-green-600 text-white font-bold py-2 px-4 rounded float-right"
      @click="submitAvailability"
    >
      Save Availability
    </button>
  </div>


  <div class="max-w-7xl mx-auto p-6 bg-white rounded-sm shadow-xs">
    <h2 class="text-xl font-bold mb-4">Availability List</h2>


    <table class="display w-full max-w-7xl bg-white border border-gray-200 rounded-lg shadow-md">
    <thead>
        <tr class="border-b bg-gray-100">
          <th class="px-2 py-2 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Start Date</th>
          <th class="px-2 py-2 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">End Date</th>
          <th class="px-2 py-2 text-left text-xs font-medium text-gray-500 uppercase tracking-wider" colspan="2">Time</th>
        </tr>
    </thead>
    <tbody>
        <tr v-if="listAvailabilities.length" v-for="(availability, index) in listAvailabilities" :key="index"  class="border-b">
            <td class="px-1 py-3 whitespace-nowrap"><p v-if="availability.start_date">{{ formatDate(availability.start_date) }}</p></td>
            <td class="px-1 py-3 whitespace-nowrap"><p v-if="availability.end_date">{{ formatDate(availability.end_date) }}</p></td>
            <td class="px-1 py-3 whitespace-nowrap"><p v-if="availability.start_time && availability.end_time">Time:{{ formatTime(availability.start_time) }} to {{ formatTime(availability.end_time) }}</p>
              <p v-else></p>
            </td>
            <td class="px-1 py-3 whitespace-nowrap"><button class="text-red-500 hover:text-red-700" @click="removeAvailability(index)">Remove</button></td>
        </tr>
      </tbody>
  </table>

  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      user: this.$store.state.auth.user.user,
      authorization: this.$store.state.auth.authorization,
      processing: false,
      selectedDates: [{ start_date: '', start_time: '', end_time: '' }],
      rangeStart: '',
      rangeEnd: '',
      listAvailabilities: [],
    };
  },
  methods: {
    addNewDate() {
      this.selectedDates.push({ start_date: '', start_time: '', end_time: '' });
    },
    removeDate(index) {
      this.selectedDates.splice(index, 1);
    },
    removeAvailability() {
      console.log("remove availability")
    },
    async submitAvailability() {                   
      this.processing = true
      //selectedDates
      let availabilities = []
      if (!!this.selectedDates[0].start_date) {        
        availabilities = this.selectedDates.map(date => ({
          start_date: date.start_date,
          start_time: date.start_time,
          end_time: date.end_time,
        }));

        // If rangeStart and rangeEnd are selected, push to availabilities array
        if (this.rangeStart && this.rangeEnd) {
          availabilities.push({
            start_date: this.rangeStart,
            end_date: this.rangeEnd,
            start_time: null,
            end_time: null,
          });
        }        
      } else {
        // If rangeStart and rangeEnd are selected, push to availabilities array
        if (this.rangeStart && this.rangeEnd) {
          availabilities = [{
            start_date: this.rangeStart,
            end_date: this.rangeEnd,
            start_time: null,
            end_time: null,
          }];
        }
        console.log("startdate not selected", this.selectedDates)
      }
                
        axios.defaults.headers.common.Authorization = `Bearer ${this.authorization.token}`         
        await axios.post('/api/availabilities', {                
          user_id: this.user.id, 
          availabilities,          
        })
        .then(({data})=>{                
          alert('Availability saved successfully!');
          this.selectedDates = [{ start_date: '', start_time: '', end_time: '' }];
          this.fetchAvailabilities();
        }).catch((error)=>{
            console.error(error);
        }).finally(()=>{
            this.processing = false
        })
    },    
    formatDate(date) {
      return new Date(date).toLocaleDateString();
    },
    formatTime(time) {
      return new Date(`1970-01-01T${time}Z`).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
    },
    async fetchAvailabilities() {
      try {
        const response = await axios.get(`/api/availabilities/`+this.user.id); // Replace '1' with the actual matchmaker ID
        this.listAvailabilities = response.data.data;
      } catch (error) {
        console.error('Error fetching availabilities:', error);
      }
    },
  },
  created() {
    this.fetchAvailabilities();
  },
};
</script>
