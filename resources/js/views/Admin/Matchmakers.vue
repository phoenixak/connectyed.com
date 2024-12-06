<!-- resources/js/components/Matchmakers.vue -->
<template>
  <div class="p-8 bg-gray-100 min-h-screen">
    <!-- Statistics Header -->
    <div class="mb-8">
      <h1 class="text-2xl font-bold text-gray-800 mb-4">Matchmaker Management</h1>
      <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
        <div class="bg-white p-4 rounded-lg shadow-sm">
          <p class="text-sm text-gray-500">Total Candidates</p>
          <p class="text-2xl font-bold text-gray-800">{{ candidates.length }}</p>
        </div>
        <div class="bg-white p-4 rounded-lg shadow-sm">
          <p class="text-sm text-gray-500">Verified</p>
          <p class="text-2xl font-bold text-green-600">{{ verifiedCount }}</p>
        </div>
        <div class="bg-white p-4 rounded-lg shadow-sm">
          <p class="text-sm text-gray-500">Avg Experience</p>
          <p class="text-2xl font-bold text-blue-600">{{ averageExperience }}y</p>
        </div>
        <div class="bg-white p-4 rounded-lg shadow-sm">
          <p class="text-sm text-gray-500">Countries</p>
          <p class="text-2xl font-bold text-purple-600">{{ uniqueCountries.length }}</p>
        </div>
      </div>
    </div>

    <!-- Filters -->
    <div class="mb-6 space-y-4">
      <div class="flex flex-wrap gap-4 bg-white p-4 rounded-lg shadow-sm">
        <button 
          v-for="filter in filters" 
          :key="filter.value"
          @click="currentFilter = filter.value"
          :class="[
            'px-4 py-2 rounded-md text-sm font-medium transition-colors',
            currentFilter === filter.value 
              ? 'bg-blue-500 text-white' 
              : 'bg-gray-100 text-gray-700 hover:bg-gray-200'
          ]"
        >
          {{ filter.label }}
        </button>
      </div>

      <!-- Search -->
      <input 
        v-model="searchQuery"
        type="text"
        placeholder="Search by name, location, or bio..."
        class="w-full px-4 py-2 bg-white rounded-lg border border-gray-200 focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
      />
    </div>

    <!-- Candidate Grid -->
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
      <div 
        v-for="candidate in filteredCandidates" 
        :key="candidate.id" 
        class="bg-white rounded-lg shadow-md overflow-hidden hover:shadow-lg transition-shadow"
      >
        <!-- Profile Image Section -->
        <div class="relative h-64">
          <img 
            :src="candidate.profile?.profile_image1 || '/path/to/default-image.jpg'" 
            :alt="candidate.name"
            class="w-full h-full object-cover"
          />
          <button 
            v-if="candidate.profile?.profile_image2"
            @click="toggleImage(candidate)"
            class="absolute bottom-4 right-4 p-2 bg-white rounded-full shadow hover:bg-gray-100"
          >
            <i class="fas fa-images"></i>
          </button>
        </div>

        <!-- Candidate Info -->
        <div class="p-6">
          <div class="flex justify-between items-start mb-4">
            <div>
              <h2 class="text-xl font-semibold text-gray-800">{{ candidate.name }}</h2>
              <p class="text-sm text-gray-500">@{{ candidate.username }}</p>
            </div>
            <span 
              :class="[
                'px-3 py-1 rounded-full text-sm font-medium',
                candidate.email_verified_at 
                  ? 'bg-green-100 text-green-800' 
                  : 'bg-orange-100 text-orange-800'
              ]"
            >
              {{ candidate.email_verified_at ? 'Verified' : 'Pending' }}
            </span>
          </div>

          <!-- Details -->
          <div class="space-y-3">
            <div class="flex items-center text-gray-600">
              <i class="fas fa-map-marker-alt w-5"></i>
              <span class="text-sm">{{ formatLocation(candidate.profile) }}</span>
            </div>

            <div class="flex items-center text-gray-600">
              <i class="fas fa-briefcase w-5"></i>
              <span class="text-sm">{{ candidate.profile?.yearsexperience || 0 }} years experience</span>
            </div>

            <div v-if="candidate.profile?.age" class="flex items-center text-gray-600">
              <i class="fas fa-user w-5"></i>
              <span class="text-sm">{{ candidate.profile.age }} years old</span>
            </div>

            <div v-if="candidate.profile?.bio" class="mt-2">
              <p class="text-sm text-gray-600 line-clamp-2">{{ candidate.profile.bio }}</p>
            </div>
          </div>

          <!-- Actions -->
          <div class="flex gap-2 mt-4">
            <button
              v-if="candidate.role === 'candidate'"
              @click="approveCandidate(candidate.id)"
              :disabled="processing"
              class="flex-1 px-4 py-2 bg-green-500 text-white rounded-md hover:bg-green-600 transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
            >
              Approve
            </button>
            <button
              class="flex-1 px-4 py-2 bg-gray-100 text-gray-700 rounded-md hover:bg-gray-200 transition-colors"
              @click="viewDetails(candidate)"
            >
              View Details
            </button>
          </div>
        </div>
      </div>
    </div>

    <!-- Loading Indicator -->
    <div v-if="processing" class="fixed inset-0 bg-gray-800 bg-opacity-50 flex items-center justify-center z-50">
      <div class="loader ease-linear rounded-full border-8 border-t-8 border-gray-200 h-32 w-32"></div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      authorization: this.$store.state.auth.authorization,
      candidates: [],
      currentFilter: 'all',
      searchQuery: '',
      filters: [
        { label: 'All Candidates', value: 'all' },
        { label: 'Verified', value: 'verified' },
        { label: 'Experienced (3y+)', value: 'experienced' }
      ],
      processing: false, // Define processing state
    };
  },

  computed: {
    verifiedCount() {
      return this.candidates.filter(c => c.email_verified_at).length;
    },

    averageExperience() {
      const total = this.candidates.reduce((sum, c) => sum + (c.profile?.yearsexperience || 0), 0);
      return (this.candidates.length > 0 ? (total / this.candidates.length).toFixed(1) : '0.0');
    },

    uniqueCountries() {
      return [...new Set(this.candidates.map(c => c.profile?.country).filter(Boolean))];
    },

    filteredCandidates() {
      let filtered = [...this.candidates];

      // Filter
      if (this.currentFilter === 'verified') {
        filtered = filtered.filter(c => c.email_verified_at);
      } else if (this.currentFilter === 'experienced') {
        filtered = filtered.filter(c => (c.profile?.yearsexperience || 0) >= 3);
      }

      // Search
      if (this.searchQuery) {
        const query = this.searchQuery.toLowerCase();
        filtered = filtered.filter(c => 
          c.name?.toLowerCase().includes(query) ||
          (c.profile?.city && c.profile.city.toLowerCase().includes(query)) ||
          (c.profile?.country && c.profile.country.toLowerCase().includes(query)) ||
          (c.profile?.bio && c.profile.bio.toLowerCase().includes(query))
        );
      }

      // Ensure only candidates with role 'candidate' are shown
      if (this.currentFilter === 'all') {
        filtered = filtered.filter(c => c.role === 'candidate');
      } else {
        // For other filters, ensure the role is 'candidate'
        filtered = filtered.filter(c => c.role === 'candidate');
      }

      return filtered;
    }
  },

  methods: {
    async fetchCandidates() {
      this.processing = true;
      try {
        axios.defaults.headers.common.Authorization = `Bearer ${this.authorization.token}`;
        const response = await axios.get('/api/admin/candidates');
        // Assuming the API returns only candidates with role 'candidate'
        this.candidates = response.data.data.filter(c => c.role === 'candidate');
      } catch (error) {
        console.error('Error fetching candidates:', error);
      } finally {
        this.processing = false;
      }
    },

    async approveCandidate(userId) {
      this.processing = true;
      try {
        await axios.post('/api/admin/candidates/approve', { user_id: userId });
        // Remove the approved candidate from the list
        this.candidates = this.candidates.filter(c => c.id !== userId);
        // Optionally, show a success message
        this.$toast.success('Candidate approved and promoted to Matchmaker.');
      } catch (error) {
        console.error('Error approving candidate:', error);
        // Optionally, show an error message
        this.$toast.error('Failed to approve candidate.');
      } finally {
        this.processing = false;
      }
    },

    formatLocation(profile) {
      if (!profile) return 'Location not specified';
      return [profile.city, profile.state, profile.country].filter(Boolean).join(', ');
    },

    toggleImage(candidate) {
      if (candidate.profile?.profile_image2) {
        [candidate.profile.profile_image1, candidate.profile.profile_image2] = 
        [candidate.profile.profile_image2, candidate.profile.profile_image1];
      }
    },

    viewDetails(candidate) {
      // Implement view details functionality
      // For example, navigate to a detailed view page
      this.$router.push({ name: 'CandidateDetails', params: { id: candidate.id } });
    }
  },

  mounted() {
    this.fetchCandidates();
  }
};
</script>

<style scoped>
.line-clamp-2 {
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.transition-colors {
  transition: all 0.3s ease;
}

.transition-shadow {
  transition: box-shadow 0.3s ease;
}

/* Loader Styles */
.loader {
  border-top-color: #3498db;
  animation: spinner 1.5s linear infinite;
}

@keyframes spinner {
  to { transform: rotate(360deg); }
}
</style>
