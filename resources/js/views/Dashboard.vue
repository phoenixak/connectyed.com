<template>  
    <div class="mx-auto max-w-7xl py-6 sm:px-6 lg:px-8 items-center justify-center">
        <div class="mx-full shadow-connectyed rounded-xl bg-white border border-gray-200 flex flex-col py-5 px-5 mb-5"> 
          <div class="text-2xl">Dashboard </div>
          <div class="text-base"><p class="mb-0">You are logged in as <b>{{user.username}}</b> ({{ user.name }})</p></div>
        </div>
        <div class="mx-full shadow-connectyed rounded-xl bg-connectyed-card-light flex flex-col py-5 px-5 mb-5"> 
          <div class="card-body">              
              
                        
                <div class="md:flex">
                    <ul class="flex-column space-y space-y-4 text-sm font-medium text-gray-500 dark:text-gray-400 md:me-4 mb-4 md:mb-0">
                        <li>
                            <a href="#" class="inline-flex items-center px-4 py-3 text-white bg-connectyed-button-light rounded-lg active w-full dark:bg-blue-600" aria-current="page">
                                Profile Info
                            </a>
                        </li>
                        <li>
                            <a href="#" class="inline-flex items-center px-4 py-3 rounded-lg hover:text-gray-900 bg-gray-50 hover:bg-gray-100 w-full dark:bg-gray-800 dark:hover:bg-gray-700 dark:hover:text-white">
                                Recommendations
                            </a>
                        </li>
                        <li>
                            <a href="#" class="inline-flex items-center px-4 py-3 rounded-lg hover:text-gray-900 bg-gray-50 hover:bg-gray-100 w-full dark:bg-gray-800 dark:hover:bg-gray-700 dark:hover:text-white">
                                Interaction
                            </a>
                        </li>
                        <li>
                            <a href="#" class="inline-flex items-center px-4 py-3 rounded-lg hover:text-gray-900 bg-gray-50 hover:bg-gray-100 w-full dark:bg-gray-800 dark:hover:bg-gray-700 dark:hover:text-white">
                                Notifications
                            </a>
                        </li>
                        
                    </ul>
                    <div class="p-6 bg-gray-50 text-medium text-gray-500 dark:text-gray-400 dark:bg-gray-800 rounded-lg w-full">
                        <h3 class="text-lg font-bold text-gray-900 dark:text-white mb-2">About your Profile</h3>
                        <div class="main-content">
                            <form class="w-full max-w-lg" action="javascript:void(0)" @submit="postProfile" method="put">
                                <div class="flex flex-wrap -mx-3 mb-6">
                                    <div class="w-full px-3 mb-6 md:mb-0">
                                    <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="name">
                                        Full Name
                                    </label>
                                    <input class="appearance-none block w-full border border-gray-500 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white" type="text" v-model="user.name" id="name">
                                    </div>
                                </div>
                                
                                <div class="flex flex-wrap -mx-3 mb-6">
                                    <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
                                    <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="city">
                                        City
                                    </label>
                                    <input class="appearance-none block w-full border border-gray-200 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" v-model="profile.city" id="city" type="text">
                                    </div>
                                    
                                    <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
                                        <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="state">
                                            State
                                        </label>
                                        <div class="relative">
                                            <select class="block appearance-none w-full border border-gray-200 text-gray-700 py-3 px-4 pr-8 rounded leading-tight focus:outline-none focus:bg-white focus:border-gray-500" v-model="profile.state" id="state">                                   <option>Other</option>
                                            </select>
                                            <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                                            <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z"/></svg>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="flex flex-wrap -mx-3 mb-6">
                                    <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
                                        <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="country">
                                            Country
                                        </label>
                                        <div class="relative">
                                            <select class="block appearance-none w-full border-gray-200 text-gray-700 py-3 px-4 pr-8 rounded leading-tight focus:outline-none focus:bg-white focus:border-gray-500" v-model="profile.country" id="country">                                   <option value="Canada">Canada</option>													
                                                <option value="United States of America">United States of America</option>
                                                <option value="Ukraine">Ukraine</option>
                                            </select>
                                            <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                                            <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z"/></svg>
                                            </div>
                                        </div>
                                    </div>
                                </div>


                                <div class="flex flex-wrap -mx-3 mb-6">
                                    <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
                                    <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="age">
                                        Age
                                    </label>
                                    <input class="appearance-none block w-full border border-gray-200 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" v-model="profile.age" id="age" type="text">
                                    </div>
                                    
                                    <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
                                        <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="zodiac">
                                            Zodiac
                                        </label>
                                        <div class="relative">
                                            <select class="block appearance-none w-full border border-gray-200 text-gray-700 py-3 px-4 pr-8 rounded leading-tight focus:outline-none focus:bg-white focus:border-gray-500" v-model="profile.zodiac" id="zodiac">                                       <option>Aries</option>
                                                <option>Gemini</option>
                                            </select>
                                            <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                                            <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z"/></svg>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="flex flex-wrap -mx-3 mb-6">
                                    <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
                                        <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="weight">
                                            Weight (Kg)
                                        </label>
                                        <input class="appearance-none block w-full border border-gray-200 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" v-model="profile.weight" id="weight" type="text">
                                    </div>
                                    
                                    <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
                                        <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="height">
                                            Height (Cm)
                                        </label>
                                        <input class="appearance-none block w-full border border-gray-200 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" v-model="profile.height" id="height" type="text">
                                    </div>
                                </div>

                                <div class="flex flex-wrap -mx-3 mb-6">
                                    <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
                                        <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="eyecolor">
                                            Eye Color
                                        </label>
                                        <input class="appearance-none block w-full border border-gray-200 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" v-model="profile.eyecolor" id="eyecolor" type="text">
                                    </div>
                                    
                                    <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
                                        <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="haircolor">
                                            Hair Color
                                        </label>
                                        <input class="appearance-none block w-full border border-gray-200 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" v-model="profile.haircolor" id="haircolor" type="text">
                                    </div>
                                </div>

                                <div class="flex flex-wrap -mx-3 mb-6">
                                    <div class="w-full md:w-1/3 px-3 mb-6 md:mb-0">
                                        <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="maritalstatus">
                                            Marital Status
                                        </label>
                                        <div class="relative">
                                            <select class="block appearance-none w-full border border-gray-200 text-gray-700 py-3 px-4 pr-8 rounded leading-tight focus:outline-none focus:bg-white focus:border-gray-500" v-model="profile.maritalstatus" id="maritalstatus">
                                                <option>Single</option>
                                            </select>
                                            <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                                            <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z"/></svg>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="w-full md:w-1/4 px-3 mb-6 md:mb-0">
                                        <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="children">
                                            Children
                                        </label>
                                        <div class="relative">
                                            <select class="block appearance-none w-full border border-gray-200 text-gray-700 py-3 px-4 pr-8 rounded leading-tight focus:outline-none focus:bg-white focus:border-gray-500" v-model="profile.children" id="children">                                  <option>0</option>
                                                <option>1</option>
                                                <option>2</option>
                                                <option>3</option>
                                            </select>
                                            <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                                            <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z"/></svg>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="w-full md:w-1/3 px-3 mb-6 md:mb-0">
                                        <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="religion">
                                            Religion
                                        </label>
                                        <div class="relative">
                                            <select class="block appearance-none w-full border border-gray-200 text-gray-700 py-3 px-4 pr-8 rounded leading-tight focus:outline-none focus:bg-white focus:border-gray-500" v-model="profile.religion" id="religion">                                <option>Baha'i</option>
                                                <option>Buddhism</option>
                                                <option>Christianity</option>
                                                <option>Confucianism</option>
                                                <option>Hinduism</option>
                                                <option>Islam</option>
                                                <option>Jainism</option>
                                                <option>Judaism</option>
                                                <option>Shinto</option>
                                                <option>Sikhism</option>
                                                <option>Taoism</option>
                                                <option>Zoroastrianism</option>
                                                <option>Other</option>
                                            </select>
                                            <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                                            <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z"/></svg>
                                            </div>
                                        </div>
                                    </div>

                                </div>



                                <div class="flex flex-wrap -mx-3 mb-6">
                                    <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
                                        <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="smoker">
                                            Smoker
                                        </label>
                                        <div class="relative">
                                            <select class="block appearance-none w-full border border-gray-200 text-gray-700 py-3 px-4 pr-8 rounded leading-tight focus:outline-none focus:bg-white focus:border-gray-500" v-model="profile.smoker" id="smoker">
                                                <option>Yes</option>
                                                <option>No</option>
                                            </select>
                                            <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                                            <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z"/></svg>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
                                        <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="drinker">
                                            Drinker
                                        </label>
                                        <div class="relative">
                                            <select class="block appearance-none w-full border border-gray-200 text-gray-700 py-3 px-4 pr-8 rounded leading-tight focus:outline-none focus:bg-white focus:border-gray-500" v-model="profile.drinker" id="drinker">                                  <option>Yes</option>
                                                <option>No</option>
                                                
                                            </select>
                                            <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                                            <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z"/></svg>
                                            </div>
                                        </div>
                                    </div>

                                    

                                </div>


                                <div class="flex flex-wrap -mx-3 mb-6">
                                    <div class="w-full md:w-1/3 px-3 mb-6 md:mb-0">
                                        <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="education">
                                            Education
                                        </label>
                                        <input class="appearance-none block w-full border border-gray-200 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" v-model="profile.education" id="education" type="text">
                                    </div>
                                    
                                    <div class="w-full md:w-1/3 px-3 mb-6 md:mb-0">
                                        <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="company">
                                            Company
                                        </label>
                                        <input class="appearance-none block w-full border border-gray-200 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" v-model="profile.company" id="company" type="text">
                                    </div>

                                    <div class="w-full md:w-1/3 px-3 mb-6 md:mb-0">
                                        <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="jobtitle">
                                            Job TItle
                                        </label>
                                        <input class="appearance-none block w-full border border-gray-200 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" v-model="profile.jobtitle" id="jobtitle" type="text">
                                    </div>
                                </div>

                                <div class="flex flex-wrap -mx-3 mb-6">
                                    <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
                                        <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="sports">
                                            Sports
                                        </label>
                                        <input class="appearance-none block w-full border border-gray-200 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" v-model="profile.sports" id="sports" type="text">
                                    </div>
                                    
                                    <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
                                        <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="hobbies">
                                            Hobbies
                                        </label>
                                        <input class="appearance-none block w-full border border-gray-200 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" v-model="profile.hobbies" id="hobbies" type="text">
                                    </div>
                                </div>

                                <div class="flex flex-wrap -mx-3 mb-6">
                                    <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
                                        <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="english">
                                            English Level
                                        </label>
                                        <div class="relative">
                                            <select class="block appearance-none w-full border border-gray-200 text-gray-700 py-3 px-4 pr-8 rounded leading-tight focus:outline-none focus:bg-white focus:border-gray-500" v-model="profile.english" id="english">                                      <option>Beginner</option>
                                                <option>Intermediate</option>
                                                <option>Proficient</option>
                                            </select>
                                            <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                                            <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z"/></svg>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
                                        <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="languages">
                                            Languages
                                        </label>
                                        <input class="appearance-none block w-full border border-gray-200 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" v-model="profile.languages" id="languages" type="text">
                                    </div>
                                </div>
                                <button type="submit" class="bg-connectyed-button-light text-white py-3 px-10">SUBMIT</button>
                            </form>

                        </div>
                    </div>
                </div>




              
          </div>
          
        </div>
    </div>    

  </template>

<script>
export default {
  name:"dashboard",
  data(){
      return {
          csrf: document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
          user: this.$store.state.auth.user.user,
          profile:this.$store.state.auth.user.profile,
          authorization:this.$store.state.auth.authorization,
          posts:{},
          isModalVisible: false,
          modalMode: {
              header: "",
          },
          post: {
              id: null,
              title: "",
              content: "",
              _token: document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
          },
          postUrl: "",
          isNew: true,
          processing: false,
      }
  },
    methods: {   
        async postProfile() {
            console.log("test")
            this.processing = true
            axios.defaults.headers.common.Authorization = `Bearer ${this.authorization.token}`        
            await axios.put('/api/updateprofile', {                
                user: this.user,
                profile: this.profile
            })
            .then(({data})=>{
                console.log(data);
                alert('Profile updated successfully');
            }).catch((error)=>{
                console.error(error);
            }).finally(()=>{
                this.processing = false
            })
        },     
  }
}
</script>