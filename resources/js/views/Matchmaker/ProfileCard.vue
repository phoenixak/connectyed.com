<template>
    <div class="dark:bg-gray-700 bg-gray-200 pt-12">
    <!-- Card start -->
        <div class="max-w-sm mx-auto bg-white dark:bg-gray-900 rounded-lg shadow-sm">
            <h4 class="p-2 uppercase text-center text-sm text-gray-600 dark:text-white mb-1">
                {{ profile.user.name }}
            </h4>
            <div class="border-b">
                <div class="text-center">
                    <img class="w-full border-4 border-white dark:border-gray-800 mx-auto"
                    :src="profile.avatar" :alt="profile.name">
                    
                </div>                                      
                <div class="flex justify-center items-center flex-wrap" v-if="profile.clients.length > 0">
                    <div v-for="client in profile.clients" class="w-[25%]">
                        <router-link :to="'/' + client.user.username">
                        <img 
                            class="border-2 border-white dark:border-gray-800 " 
                            :key="client.id"
                            :src="(client.avatar) ? client.avatar : '/upload/images/profiles/default.png'" 
                            :alt="(client.name)">
                                                        
                        </router-link>
                    </div>
                </div>
                 
          
                <div class="py-2 flex justify-center items-center f">                    
                    <div class="inline-flex text-gray-700 dark:text-gray-300 items-center">
                        <svg class="h-5 w-5 text-gray-400 dark:text-gray-600 mr-1" fill="currentColor"
                            xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24">
                            <path class=""
                                d="M5.64 16.36a9 9 0 1 1 12.72 0l-5.65 5.66a1 1 0 0 1-1.42 0l-5.65-5.66zm11.31-1.41a7 7 0 1 0-9.9 0L12 19.9l4.95-4.95zM12 14a4 4 0 1 1 0-8 4 4 0 0 1 0 8zm0-2a2 2 0 1 0 0-4 2 2 0 0 0 0 4z" />
                        </svg>
                        {{ profile.location }}
                    </div>
                </div>                
            </div>
            <!-- List of Availability -->
            <div class="mt-4">
                <div class="text-center font-semibold text-lg">Availability</div>
                <ul class="mt-2 space-y-2">
                <li v-for="(slot, index) in profile.user.availability" :key="index" class="">
                    <div class="grid grid-cols-1 p-1 text-center">
                        <div class="bg-connectyed-card-light p-1 rounded-md">{{ formatDate(slot.start_date) }} - {{ formatDate(slot.end_date) }}</div>
                        <div v-if="slot.start_time" class="rounded text-center text-sm font-bold">{{ slot.start_time }} - {{ slot.end_time }} </div>
                    </div>
                </li>
                </ul>
            </div>
            
        </div>
    <!-- Card end -->
    </div>    
</template>
  
  <script>
  export default {
    props: {
      profile: {
        type: Object,
        required: true,
        default: () => ({
          name: '',                  
          avatar: '/upload/images/profiles/default.png'
        }),
      },
    },
    methods: {
        formatDate(date) {                    
            const options = { year: 'numeric', month: 'long', day: 'numeric' };
            return new Date(date).toLocaleDateString(undefined, options);
        }
    }
  };
  </script>