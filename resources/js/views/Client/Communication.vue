<template>
  <div v-if="meetingUrl" class="w-full mx-auto p-3 bg-white rounded-lg shadow-sm">
    <iframe v-if="meetingUrl" :src="meetingUrl" width="100%" height="600px"></iframe>
  </div>
  
      
    <h2 class="text-xl font-semibold mb-2">Upcoming Meetings</h2>
    <div v-if="clientMeetings.length" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-2 gap-6">
      <div
        v-for="meeting in clientMeetings"
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
      clientMeetings: [],
    };
  },
  mounted() {            
    this.getUpcomingMeeting()
  }, 
  methods: {                
    async getUpcomingMeeting() {            
      this.processing = true    
      axios.defaults.headers.common.Authorization = `Bearer ${this.authorization.token}`  
      await axios.get('/api/zoom/upcoming-meetings')
      .then(({ data }) => {                               
        this.clientMeetings = data.data.clientMeetings;            
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
