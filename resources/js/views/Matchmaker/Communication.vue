<template>
  <div v-if="meetingUrl" class="w-full mx-auto p-3 bg-white rounded-lg shadow-sm">
    <iframe v-if="meetingUrl" :src="meetingUrl" width="100%" height="600px"></iframe>
  </div>
  <div v-if="!meetingUrl" class="w-full max-w-md mx-auto p-3 bg-white rounded-lg shadow-sm">
    <h2 class="text-xl font-semibold mb-4">Schedule a Zoom Meeting</h2>

    <label for="clients" class="block text-sm font-medium text-gray-700 mb-2">Select Up to Two Clients</label>
    
    <div class="mb-4">
      <input
        ref="clientInput"
        type="text"
        v-model="searchQuery"
        @focus="showDropdown = true"
        @blur="hideDropdown"
        placeholder="Search client..."
        class="w-full px-4 py-2 border border-gray-300 rounded-lg shadow-sm focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition duration-300 ease-in-out placeholder-gray-400"
        :disabled="selectedClients.length === 2"
      />
      
      <!-- Dropdown for filtered clients -->
      <ul v-if="showDropdown && filteredClients.length" class="z-10 w-full mt-1 bg-white border border-gray-300 rounded-lg shadow-lg max-h-60 overflow-y-auto">
        <li
          v-for="client in filteredClients"
          :key="client.id"
          @mousedown.prevent="selectClient(client)"
          class="px-4 py-2 hover:bg-gray-100 cursor-pointer"
        >
          {{ client.name }}
        </li>
      </ul>
    </div>

    <!-- Display selected clients -->
    <div v-if="selectedClients.length" class="mb-4 space-y-1">
      <div v-for="client in selectedClients" :key="client.id" class="flex justify-between items-center px-4 py-2 bg-gray-100 rounded-lg">
        <span class="text-sm font-medium text-gray-700">{{ client.name }} <span class="text-blue-700">({{ client.email }})</span></span>
        <button @click="removeClient(client.id)" class="text-red-500 hover:text-red-700 font-semibold text-sm">Remove</button>
      </div>
    </div>

    <!-- Date and Time -->
    <div class="mb-4">
      <label class="block text-sm font-medium text-gray-700 mb-2">Meeting Date & Time</label>
      <input
        type="datetime-local"
        v-model="startTime"
        class="w-full px-4 py-2 border border-gray-300 rounded-lg shadow-sm focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition duration-300 ease-in-out placeholder-gray-400"
      />
    </div>

    <!-- Meeting Duration -->
    <div class="mb-4">
      <label class="block text-sm font-medium text-gray-700 mb-2">Duration (minutes)</label>
      <select v-model="duration" class="w-full px-4 py-2 border border-gray-300 rounded-lg shadow-sm focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition duration-300 ease-in-out placeholder-gray-400">
        <option value="15">15 minutes</option>
        <option value="30">30 minutes</option>
        <option value="60">60 minutes</option>
      </select>
    </div>

    <button @click="scheduleMeeting" class="w-full py-2 bg-blue-500 text-white rounded-lg">Schedule Meeting</button>
  </div>
      
    <h2 class="text-xl font-semibold mb-2">Upcoming Meetings</h2>
    <div v-if="matchmakerMeetings.length" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-2 gap-6">
      <div
        v-for="meeting in matchmakerMeetings"
        :key="meeting.id"
        class="bg-white rounded-lg shadow-md p-4"
      >
        <h3 class="text-lg font-bold mb-2">Meeting ID: {{ meeting.zoom_meeting_id }}</h3>

        <p class="text-gray-700">Start Time: {{ meeting.start_time }}</p>
        <p class="text-gray-700">Duration: {{ meeting.duration }} minutes</p>

        <div v-if="meeting.zoom_meeting_url">
          <a
            @click="this.meetingUrl=meeting.zoom_meeting_url"
            class="text-blue-600 hover:text-blue-800 underline cursor-pointer"
            target="_blank"
            rel="noopener noreferrer"
          >Join Zoom Meeting</a>
        </div>

        <div v-if="meeting.zoom_start_url">
          <a            
            @click="this.meetingUrl=meeting.zoom_start_url"
            class="text-green-600 hover:text-green-800 underline cursor-pointer"
            target="_blank"
            rel="noopener noreferrer"
          >Start Zoom Meeting</a>
        </div>

        <div class="mt-4">
          <h4 class="font-bold mb-1">Clients:</h4>
          <ul class="list-disc ml-4">
            <li v-for="client in meeting.clients" :key="client.id">
              {{ client.name }} ({{ client.email }})
            </li>
          </ul>
        </div>
      </div>
    </div>

  
  
</template>

<script>
export default {
  data() {
    return {
      meetingUrl: null,
      user: this.$store.state.auth.user.user,      
      authorization:this.$store.state.auth.authorization,
      startTime: '', 
      duration: 30,
      searchQuery: "",
      showDropdown: false,
      selectedClients: [],
      clients: [],
      baseurl: "",
      matchmakerMeetings: [],
    };
  },
  mounted() {
    this.baseurl = window.location.hostname
    const zoomToken = localStorage.getItem('zoom_token')
    const meetingUrl = localStorage.getItem('zoom_url')
    this.meetingUrl = (meetingUrl || meetingUrl!=="undefined") ? meetingUrl : null
    this.getClient()    
    if (!zoomToken || zoomToken==="undefined") {
      this.redirectToZoom() 
    } else {
      if (this.isTokenExpired(zoomToken)){
        this.redirectToZoom()
      }
    }
    this.getUpcomingMeeting()
  },
  computed: {
    filteredClients() {
      const query = this.searchQuery.toLowerCase();
      return this.clients.filter((client) =>
        client.name.toLowerCase().includes(query) && !this.selectedClients.find(c => c.id === client.id)
      );
    },
  },
  methods: {
    selectClient(client) {
      if (this.selectedClients.length < 2) {
        this.selectedClients.push(client);
        this.searchQuery = ""; 
        this.showDropdown = false;
        this.$refs.clientInput.blur();
      }
    },
    removeClient(clientId) {
      this.selectedClients = this.selectedClients.filter(client => client.id !== clientId);
    },
    hideDropdown() {      
      setTimeout(() => {
        this.showDropdown = false;
      }, 100);
    },
    async getClient() {            
      this.processing = true            
        await axios.get('/api/clients')
        .then(({ data }) => {                            
          this.clients = data.data            
        }).catch((error)=>{
            console.error(error);
        }).finally(()=>{
            this.processing = false
        })
    },
    redirectToZoom() {
      const query = new URLSearchParams({
        response_type: 'code',
        client_id: 'vEmcNL82SZqsngIZBrF5Bw',
        redirect_uri: 'https://connectyed.com/zoom/callback',
      }).toString();

      window.location.href = `https://zoom.us/oauth/authorize?${query}`;
    },
    async scheduleMeeting() {
      axios.defaults.headers.common.Authorization = `Bearer ${this.authorization.token}`      
      await axios.post('/api/zoom/meeting', {
        client_ids: this.selectedClients.map(client => client.id),
        start_time: this.startTime,
        duration: this.duration,
        matchmaker_id: this.user.id, // Matchmaker ID (assuming you have this stored)
      })
      .then(response => {        
        this.meetingUrl = response.data.data.zoom.join_url;
        localStorage.setItem("zoom_url", JSON.stringify(response.data.data.zoom.join_url)) 
        localStorage.setItem("zoom_token", false)
        alert('Meeting scheduled successfully');
      })
      .catch(error => {
        // Handle error
        console.error(error);
        localStorage.setItem("zoom_token", false)
      });
    },
    isTokenExpired(token) {
      if (!token) {
        return true;
      }
      try {
        const base64Url = token.split('.')[1]; // Get the payload part of the token
        const base64 = base64Url.replace(/-/g, '+').replace(/_/g, '/');
        const payload = JSON.parse(window.atob(base64)); // Decode the Base64-encoded payload

        const currentTime = Math.floor(Date.now() / 1000); // Current time in seconds
        return payload.exp < currentTime; // Check if the token has expired
      } catch (error) {
        console.error("Invalid token or unable to decode:", error);
        return true;
      }
    },
    async getUpcomingMeeting() {            
      this.processing = true    
      axios.defaults.headers.common.Authorization = `Bearer ${this.authorization.token}`  
      await axios.get('/api/zoom/upcoming-meetings')
      .then(({ data }) => {                             
        this.matchmakerMeetings = data.data.matchmakerMeetings;            
      }).catch((error)=>{
          console.error(error);
      }).finally(()=>{
          this.processing = false
      })
    },

  },
};
</script>

<style scoped>
ul {
  max-height: 10rem; /* Limit height for scrollable list */
}
</style>
