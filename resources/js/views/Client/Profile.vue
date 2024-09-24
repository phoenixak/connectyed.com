<template>  
    
    <div class="mx-full shadow-connectyed rounded-xl bg-connectyed-card-light flex flex-col py-5 px-5 mb-5">                                                    
                                                          
         
                <div class="grid grid-cols-4 gap-4">
                    <label class="text-lg font-bold text-gray-900 dark:text-white mb-4 p-2">About your Profile</label>
                    <span></span>
                    <span></span>
                    <button class="bg-connectyed-button-light text-connectyed-button-dark py-3 px-10" @click="isFormVisible = !isFormVisible" v-if="!isFormVisible">Edit Info</button>
                </div>

                <div class="main-content" v-if="!isFormVisible">
                    <div class="flex">
                        <div class="col-4 p-2">
                            <div class="flex flex-wrap justify-left cursor-pointer">
                                <!-- Main Image -->
                                <div class="w-[270px] h-[360px] overflow-hidden bg-gray-400" v-if="!currentAvatar">
                                    <img src="upload/images/profiles/default.png" alt="Main Image" class="w-full h-full object-cover">
                                </div>

                                <div class="w-[270px] h-[360px] overflow-hidden bg-gray-400" v-if="currentAvatar">
                                    <img :src="currentAvatar" alt="Main Image" class="w-full h-full object-cover">
                                </div>

                                <!-- Thumbnails -->
                                <div class="flex flex-wrap justify-left gap-1/2">
                                    <div class="w-[45px] h-[61px] p-1 overflow-hidden" v-for="(image, index) in userImages" :key="index">
                                        <img :src="image" 
                                        @click="updateAvatar(image)"
                                        alt="Profile" class="shadow-sm bg-gray-400 w-full h-full object-cover">
                                    </div>
                                </div>
                            </div>
                            
                            <div class="flex w-full my-2">
                                <!-- File input button -->
                                <label for="file_upload" class="cursor-pointer w-full flex">
                                <span class="text-connectyed-button-dark bg-connectyed-button-light hover:bg-connectyed-button-hover
                                hover:text-connectyed-button-hover-dark focus:outline-none focus:ring-2 focus:ring-blue-500 px-4 py-2 w-full
                                justify-center text-center
                                ">
                                    Upload Image
                                </span>
                                <input
                                    type="file"
                                    id="file_upload"
                                    class="hidden"
                                    @change="uploadFile"
                                />
                                </label>
                            </div>
                        </div>
                        <div class="col-7">
                            <div class="flex flex-wrap mb-1">
                                <div class="w-full">
                                <label class="text-gray-700 text-2xl">
                                    {{user.name}}
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
                                <div class="w-full">
                                <label class="text-gray-700 text-md">
                                    Gender: 
                                </label>                                        
                                {{ profile.gender ? profile.gender : 'N/A' }}
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


                
                <div class="main-content" v-if="isFormVisible">
                    <form class="w-full" action="javascript:void(0)" @submit="postProfile" method="put">
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
                                    <input class="appearance-none block w-full border border-gray-200 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" v-model="profile.state" id="state" type="text">
                                </div>
                            </div>
                        </div>                                

                        <div class="flex flex-wrap -mx-3 mb-6">
                            <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
                                <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="country">
                                    Country
                                </label>
                                <div class="relative">
                                    <select class="block appearance-none w-full border-gray-200 text-gray-700 py-3 px-4 pr-8 rounded leading-tight focus:outline-none focus:bg-white focus:border-gray-500" v-model="profile.country" id="country">
                                        <option value="United States of America">United States of America</option>                                                
                                        <option value="Canada">Canada</option>
                                    </select>
                                    <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                                    <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z"/></svg>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="flex flex-wrap -mx-3 mb-6">
                            <div class="w-full px-3 mb-6 md:mb-0">
                            <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="location">
                                Current location (City)
                            </label>
                            <input class="appearance-none block w-full border border-gray-200 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" v-model="profile.location" id="location" type="text">    
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
                            <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="haircolor">
                                    Hair Color
                                </label>
                                <input class="appearance-none block w-full border border-gray-200 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" v-model="profile.haircolor" id="haircolor" type="text">
                            </div>                       
                        </div>

                        <div class="flex flex-wrap -mx-3 mb-6">
                            <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="gender">
                                    Gender
                            </label>
                            <div class="relative">
                                <select class="block appearance-none w-full border border-gray-200 text-gray-700 py-3 px-4 pr-8 rounded leading-tight focus:outline-none focus:bg-white focus:border-gray-500" v-model="profile.gender" id="gender">
                                    <option>Male</option>
                                    <option>Female</option>                                            
                                </select>
                                <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                                <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z"/></svg>
                                </div>
                            </div>                     
                        </div>

                        <div class="flex flex-wrap -mx-3 mb-6">
                            <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
                                <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="weight">
                                    Weight (lbs)
                                </label>
                                <input class="appearance-none block w-full border border-gray-200 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" v-model="profile.weight" id="weight" type="text">
                            </div>
                            
                            <div class="w-full md:w-1/4 px-3 mb-6 md:mb-0">
                                <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="height">
                                    Height (Feet)
                                </label>
                                <input class="appearance-none block w-full border border-gray-200 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" v-model="profile.height" id="height" placeholder="0" max="8" type="text">
                            </div>

                            <div class="w-full md:w-1/4 px-3 mb-6 md:mb-0">
                                <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="inches">
                                    Inches
                                </label>
                                <input class="appearance-none block w-full border border-gray-200 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" v-model="profile.inches" id="inches" placeholder="0" max="11" type="text">
                            </div>
                        </div>

                        <div class="flex flex-wrap -mx-3 mb-6">
                            <div class="w-full md:w-1/4 px-3 mb-6 md:mb-0">
                                <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="maritalstatus">
                                    Marital Status
                                </label>
                                <div class="relative">
                                    <select class="block appearance-none w-full border border-gray-200 text-gray-700 py-3 px-4 pr-8 rounded leading-tight focus:outline-none focus:bg-white focus:border-gray-500" v-model="profile.maritalstatus" id="maritalstatus">
                                        <option>Single</option>
                                        <option>Separated</option>
                                        <option>Divorced</option>
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
                                        <option>4</option>
                                    </select>
                                    <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                                    <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z"/></svg>
                                    </div>
                                </div>
                            </div>

                            <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
                                <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="religion">
                                    Religion
                                </label>
                                <div class="relative">
                                    <select class="block appearance-none w-full border border-gray-200 text-gray-700 py-3 px-4 pr-8 rounded leading-tight focus:outline-none focus:bg-white focus:border-gray-500" v-model="profile.religion" id="religion">                                <option>Baha'i</option>
                                        <option>Buddhism</option>
                                        <option>Catholic</option>
                                        <option>Christian</option>
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
                                    <select class="block appearance-none w-full border border-gray-200 text-gray-700 py-3 px-4 pr-8 rounded leading-tight focus:outline-none focus:bg-white focus:border-gray-500" v-model="profile.drinker" id="drinker">                                      <option>None</option>
                                        <option>Occasionally</option>
                                        <option>Often</option>
                                    </select>
                                    <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                                    <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z"/></svg>
                                    </div>
                                </div>
                            </div>

                            

                        </div>


                        <div class="flex flex-wrap -mx-3 mb-6">
                            <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
                                <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="education">
                                    Education
                                </label>
                                <input class="appearance-none block w-full border border-gray-200 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" v-model="profile.education" id="education" type="text">
                            </div>
                                                                
                            <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
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

                        <div class="flex flex-wrap -mx-3 mb-6">
                            <div class="w-full px-3 mb-6 md:mb-0">
                                <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="languages">
                                    Self Description
                                </label>
                                <textarea class="appearance-none block w-full border border-gray-200 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" v-model="profile.description" id="description">
                                </textarea>    
                            </div>
                        </div>

                        <div class="flex flex-wrap -mx-3 mb-6">
                            <div class="w-full px-3 mb-6 md:mb-0">
                                <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="languages">
                                    Comment
                                </label>
                                <textarea class="appearance-none block w-full border border-gray-200 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" v-model="profile.comment" id="comment">
                                </textarea>    
                            </div>
                        </div>

                        <div class="flex flex-wrap -mx-3 mb-6 justify-center">    
                            <button type="submit" class="bg-connectyed-button-light text-connectyed-button-dark hover:bg-connectyed-button-hover-light hover:text-connectyed-button-hover-dark py-3 px-10">SAVE</button>
                        </div>
                    </form>

                </div>
            
        
            
             
    </div>


  </template>

<script>
export default {
    name:"profile",
    data(){
      return {
        csrf: document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
        user: this.$store.state.auth.user.user,
        profile:this.$store.state.auth.user.profile,
        authorization:this.$store.state.auth.authorization,
        posts:{},
        isFormVisible: false,
        post: {
            id: null,
            title: "",
            content: "",
            _token: document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
        },
        postUrl: "",
        isNew: true,
        processing: false,
        userImages: [],        
        uploadedImages: [],
        currentAvatar: 'upload/images/profiles/default.png',
      }
    },
    mounted() {
        this.showUserImages();
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
                this.isFormVisible = !this.isFormVisible
                alert('Profile updated successfully');
            }).catch((error)=>{
                console.error(error);
            }).finally(()=>{
                this.processing = false
            })
        },   
        async showUserImages() {            
            this.processing = true
            axios.defaults.headers.common.Authorization = `Bearer ${this.authorization.token}` 
            await axios.get('/api/profile/images')
                .then((response) => {       
                this.userImages = Object.values(response.data.data);
            }).catch((error)=>{
                console.error(error);
            }).finally(()=>{
                this.processing = false
            })
        },
        async uploadFile(event) {
            const file = event.target.files[0];
            if (!file) return;
            const formData = new FormData();
            formData.append("file", file);
            formData.append("user_id", this.user.id);
            this.processing = true            
            axios.defaults.headers.common.Authorization = `Bearer ${this.authorization.token}` 
            await axios.post('/api/profile/uploadimages', formData, {
            headers: {
                'Content-Type': 'multipart/form-data'
            }
            })
            .then((response) => {
                this.userImages.push(`/${response.data.data}`);                  
            }).catch((error)=>{
                console.error(error);
            }).finally(()=>{
                this.processing = false
            })
        },
        async updateAvatar(image) {
            this.processing = true
            axios.defaults.headers.common.Authorization = `Bearer ${this.authorization.token}`        
            await axios.put('/api/profile/updateavatar', {                
                avatar: image,
            })
            .then((response)=>{
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
            }).catch((error)=>{
                console.error(error);
            }).finally(()=>{
                this.processing = false
            })
        }
    },
}
</script>