<template>
    <div>
      <h4>Processing Zoom Callback...</h4>
    </div>
  </template>
  
  <script>
  export default {
    created() {
      const queryParams = new URLSearchParams(window.location.search);
      const authCode = queryParams.get('code');
  
      if (authCode) {
        this.processZoomCallback(authCode);
      } else {
        console.error('No Zoom authorization code found.');
      }
    },
    methods: {
      async processZoomCallback(code) {
        try {          
          const response = await axios.get(`/api/zoom/callback?code=${code}`);                      
            const localUser = JSON.parse(localStorage.getItem('user')) 
            localStorage.setItem("zoom_token", JSON.stringify(response.data)) 
            if (localUser.data.user.role === 'admin') {
                this.$router.push({ path: '/admin/dashboard' });
            } else if (localUser.data.user.role === 'matchmaker') {
                this.$router.push({ path: '/matchmaker/communication' });                        
            } else if (localUser.data.user.role === 'candidate') {
                this.$router.push({ path: '/matchmaker/communication' });
            } else if (localUser.data.user.role === 'client') {                       
                this.$router.push({ path: '/client/dashboard' });                        
            }
        } catch (error) {
          console.error('Error processing Zoom callback:', error);
        }
      }
    }
  };
  </script>
  