<template>  
    <div class="mx-auto max-w-7xl py-6 sm:px-6 lg:px-8 items-center justify-center">
        <div class="mx-full shadow-connectyed rounded-xl bg-connectyed-card-light flex flex-col py-5 px-5 mb-5"> 
          
            <div class="p-6 bg-gray-50 text-medium text-gray-500 dark:text-gray-400 dark:bg-gray-800 rounded-lg w-full">

                <div class="main-content">
                    <div class="flex">
                        <div class="col-4 p-2">
                            <div class="flex flex-wrap justify-center cursor-pointer">
                                <!-- Main Image -->
                                <div class="w-[270px] h-[360px] overflow-hidden bg-gray-400" v-if="!currentAvatar">
                                    <img src="upload/images/profiles/default.png" alt="Main Image" class="w-full h-full object-cover">
                                </div>

                                <div class="w-[270px] h-[360px] overflow-hidden bg-gray-400" v-if="currentAvatar">
                                    <img :src="currentAvatar" alt="Main Image" class="w-full h-full object-cover">
                                </div>
                            </div>
                            
                        </div>
                        <div class="col-7">
                            <div class="flex flex-wrap mb-1">
                                <div class="w-full">
                                <label class="text-gray-700 text-2xl">
                                    {{profile.name}}
                                </label>
                                </div>
                            </div>
                            <div class="flex flex-wrap mb-1">
                                <div class="w-full">
                                <label class="text-gray-700 text-2xl">
                                    {{ profile.city ? profile.city : 'Your City' }}, {{ profile.country ? profile.country : 'Your Country' }}
                                </label>
                                </div>
                            </div>
                            <div class="flex flex-wrap mb-3">
                                <div class="w-full">
                                <label class="text-gray-700 text-md">
                                    location: {{ profile.location ? profile.location : 'Your current location / City' }}
                                </label>
                                </div>
                            </div>                                    
                            <div class="flex flex-wrap mb-3">
                                <div class="w-full">
                                <label class="text-gray-700 text-md">
                                    Age: 
                                </label>                                        
                                {{ profile.age ? profile.age : 'N/A' }}
                                </div>
                            </div>  
                            <div class="flex flex-wrap mb-3">
                                <div class="w-[50%]">
                                <label class="text-gray-700 text-md">
                                    Weight (Kg): 
                                </label>                                        
                                {{ profile.weight ? profile.weight : 'N/A' }}
                                </div>
                                <div class="w-[50%]">
                                <label class="text-gray-700 text-md">
                                    Height (Feet):
                                </label>
                                {{ profile.height ? profile.height+'′' : 'N/A' }}
                                {{ profile.inches ? profile.inches+'″' : '0″' }}
                                </div>
                            </div>                                      

                            <div class="flex flex-wrap mb-3">
                                <div class="w-full">
                                <label class="text-gray-700 text-md">
                                    Hair Color: 
                                </label>                                        
                                {{ profile.haircolor ? profile.haircolor : 'N/A' }}
                                </div>
                            </div>     
                            
                            <div class="flex flex-wrap mb-3">
                                <div class="w-full">
                                <label class="text-gray-700 text-md">
                                    Marital Status: 
                                </label>
                                {{ profile.maritalstatus ? profile.maritalstatus : 'N/A' }}
                                </div>
                            </div>
                            <div class="flex flex-wrap mb-3">
                                <div class="w-full">
                                <label class="text-gray-700 text-md">
                                    Children:
                                </label>
                                {{ profile.children ? profile.children : 'N/A' }}
                                </div>
                            </div>   

                            <div class="flex flex-wrap mb-3">
                                <div class="w-full">
                                <label class="text-gray-700 text-md">
                                    Religion: 
                                </label>                                        
                                {{ profile.religion ? profile.religion : 'N/A' }}
                                </div>
                            </div>                                     

                            <div class="flex flex-wrap mb-3">
                                <div class="w-[50%]">
                                <label class="text-gray-700 text-md">
                                    Smoker: 
                                </label>                                        
                                {{ profile.smoker ? profile.smoker : 'N/A' }}
                                </div>
                                <div class="w-[50%]">
                                <label class="text-gray-700 text-md">
                                    Drinker: 
                                </label>                                        
                                {{ profile.drinker ? profile.drinker : 'N/A' }}
                                </div>
                            </div> 

                            <div class="flex flex-wrap mb-3">
                                <div class="w-full">
                                <label class="text-gray-700 text-md">
                                    Education: 
                                </label>                                        
                                {{ profile.education ? profile.education : 'N/A' }}
                                </div>
                            </div>

                            <div class="flex flex-wrap mb-3">
                                <div class="w-full">
                                <label class="text-gray-700 text-md">
                                    Job TItle: 
                                </label>                                        
                                {{ profile.jobtitle ? profile.jobtitle : 'N/A' }}
                                </div>
                            </div>                                    
                            <div class="flex flex-wrap mb-3">
                                <div class="w-full">
                                <label class="text-gray-700 text-md">
                                    Sports: 
                                </label>                                        
                                {{ profile.sports ? profile.sports : 'N/A' }}
                                </div>
                            </div>   
                            <div class="flex flex-wrap mb-3">
                                <div class="w-full">
                                <label class="text-gray-700 text-md">
                                    Hobbies: 
                                </label>                                        
                                {{ profile.hobbies ? profile.hobbies : 'N/A' }}
                                </div>
                            </div>   
                            <div class="flex flex-wrap mb-3">
                                <div class="w-full">
                                <label class="text-gray-700 text-md">
                                    English Level: 
                                </label>                                        
                                {{ profile.english ? profile.english : 'N/A' }}
                                </div>
                            </div>   
                            <div class="flex flex-wrap mb-3">
                                <div class="w-full">
                                <label class="text-gray-700 text-md">
                                    Languages: 
                                </label>                                        
                                {{ profile.languages ? profile.languages : 'N/A' }}
                                </div>
                            </div>   
                        </div>
                    </div>
                    <div class="grid grid-cols-1 px-17 min-h-16">
                        <label class="text-gray-700 text-md">
                            Self Description: 
                        </label> 
                        {{ profile.description ? profile.description : 'N/A' }}
                    </div>
                    <div class="grid grid-cols-1 px-17 min-h-16">
                        <label class="text-gray-700 text-md">
                            Comments: 
                        </label> 
                        {{ profile.comment ? profile.comment : 'N/A' }}
                    </div>                          
                </div>
            </div>

        </div>
    </div>    

  </template>

<script>
export default {
  name:"profiledetail",
    data(){
      return {        
        processing: false,        
        profile: [],
        currentAvatar: '',
      }
    },
    mounted() {
        this.getProfile();
    },
    methods: {                        
        async getProfile() {
            this.processing = true
            const username = this.$route.params.username
            await axios.get('/api/profile/getdetail/'+username)
                .then((response) => {    
                    console.log("response", response.data)                
                    this.currentAvatar = response.data.data.avatar
                    this.profile = response.data.data
            }).catch((error)=>{
                console.error(error);
            }).finally(()=>{
                this.processing = false
            })
        }
    },
}
</script>