<template>
  <div class="max-w-4xl mx-auto p-6 bg-white rounded-sm shadow-sm">
    <h2 class="text-2xl font-semibold mb-4">Matchmaker Profile</h2>
        
    <!-- Profile Picture -->
    <div class="mb-4 w-1/4 ">      
      <!-- Image Preview -->
      <div class="flex mb-4" v-if="currentAvatar">
        <img :src="currentAvatar" alt="Profile Preview" class="rounded-full object-cover w-48 h-48" />
      </div>            
      <!-- File input button -->
      <label for="profile-picture" class="cursor-pointer w-full flex">
      <span class="text-connectyed-button-dark bg-connectyed-button-light hover:bg-connectyed-button-hover
      hover:text-connectyed-button-hover-dark focus:outline-none focus:ring-2 focus:ring-blue-500 px-4 py-2 w-full
      justify-center text-center
      ">
          Upload Image
      </span>
      <input
          type="file"
          id="profile-picture"
          class="hidden"
          @change="uploadAvatar"
          accept="image/*"
      />
      </label>                        
    </div>    
              
    <form class="w-full" action="javascript:void(0)" @submit="postProfile" method="put">
      <!-- Name -->
      <div class="flex flex-wrap -mx-3">
          <div class="w-full px-3 mb-4 md:mb-0">
          <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="name">
              Full Name
          </label>
          <input class="appearance-none block w-full border border-gray-500 rounded p-2 mb-3 leading-tight focus:outline-none focus:bg-white" type="text" v-model="user.name" id="name">
          </div>
      </div>

      <div class="flex flex-wrap -mx-3 mb-4">
          <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
          <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="yearsexperience">
              Years of Experience
          </label>
          <input class="appearance-none block w-full border border-gray-200 rounded p-2 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" v-model="profile.yearsexperience" id="yearsexperience" type="text">
          </div>                              
      </div>

      <div class="flex flex-wrap -mx-3">
        <div class="w-full md:w-1/2 px-3 mb-4 md:mb-0">
            <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="city">
                City
            </label>
            <input class="appearance-none block w-full border border-gray-200 rounded p-2 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" v-model="profile.city" id="city" type="text">
        </div>
        
        <div class="w-full md:w-1/2 px-3 mb-4 md:mb-0">
            <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="state">
                State
            </label>
            <div class="relative">
                <input class="appearance-none block w-full border border-gray-200 rounded p-2 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" v-model="profile.state" id="state" type="text">
            </div>
        </div>
    </div>   

    <div class="flex flex-wrap -mx-3 mb-4">
        <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
            <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="country">
                Country
            </label>
            <div class="relative">
                <select class="block appearance-none w-full border-gray-200 text-gray-700 p-2 pr-8 rounded leading-tight focus:outline-none focus:bg-white focus:border-gray-500" v-model="profile.country" id="country">
                  <option value="United States of America">United States of America</option>
                  <option value="Canada">Canada</option>													                    
                  <option value="Other">Other</option>
                </select>
                <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z"/></svg>
                </div>
            </div>
        </div>
    </div>        

      <!-- Submit Button -->
      <div class="flex items-center justify-end">
        <button
          class="bg-connectyed-button-light text-connectyed-button-dark hover:bg-connectyed-button-hover hover:text-connectyed-button font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline"
          type="submit"
        >
          Save Profile
        </button>
      </div>
    </form>

  </div>
</template>
  
<script>
export default {
  data() {
    return {
      user:{},
      profile:{},      
      authorization:this.$store.state.auth.authorization,
      currentAvatar: '/upload/images/profiles/default.png'
    };
  },  
  mounted() {      
      this.getProfile();
  },
  methods: {
    async postProfile() {            
        this.processing = true
        axios.defaults.headers.common.Authorization = `Bearer ${this.authorization.token}`        
        await axios.put('/api/profile/update', {                
            user: this.user,
            profile: this.profile
        })
        .then(({data})=>{                
            alert('Profile updated successfully');
        }).catch((error)=>{
            console.error(error);
        }).finally(()=>{
            this.processing = false
        })
    },  
    async uploadAvatar(event) {
        const file = event.target.files[0];
        if (!file) return;
        const formData = new FormData();
        formData.append("file", file);
        this.processing = true            
        axios.defaults.headers.common.Authorization = `Bearer ${this.authorization.token}` 
        await axios.post('/api/profile/uploadavatar', formData, {
        headers: {
            'Content-Type': 'multipart/form-data'
        }
        })
          .then((response) => {                        
            this.currentAvatar = response.data.data              
        }).catch((error)=>{
            console.error(error);
        }).finally(()=>{
            this.processing = false
        })
    },
    async getProfile() {
        this.processing = true
        axios.defaults.headers.common.Authorization = `Bearer ${this.authorization.token}` 
        await axios.get('/api/profile/getprofile')
          .then((response) => {                                       
            this.currentAvatar = response.data.data.avatar;
            this.profile = response.data.data;
            this.user = response.data.data.user;
        }).catch((error)=>{
            console.error(error);
        }).finally(()=>{
            this.processing = false
        })
    }
  }
};
</script>