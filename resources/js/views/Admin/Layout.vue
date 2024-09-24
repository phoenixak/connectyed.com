<template>
  
    <!-- ================> header section start here <================== -->
    <header class="header" id="navbar">
        <div class="d-none d-lg-block bg-connectyed-header-light">
      <div class="container">
        <div class="header__top--area">
          <div class="header__top--left p-4">
            
          </div>
          <div class="header__top--right">
            
          </div>
        </div>
      </div>
    </div>
    <div class="header bg-[#213366]">      
        <nav class="navbar navbar-expand-lg">
          <a class="navbar-brand" href="#"><h2><router-link :to="{name:'home'}" class="nav-link"><img src="/assets/images/logo/connectyedlogo.png" alt="Connectyed Logo" class="w-[70px]"></router-link></h2></a>
          <button class="navbar-toggler collapsed" type="button" data-bs-toggle="collapse"
            data-bs-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false"
            aria-label="Toggle navigation">
            <span class="navbar-toggler--icon"></span>
          </button>
          <div class="navbar-collapse justify-content-end" id="navbarNavAltMarkup">
            <div class="navbar-nav mainmenu">
              <ul>
                <li>
                  <a href="#">
                    <router-link :to="{name:'home'}" class="nav-link hidden">Home</router-link>
                  </a>									
                </li>								
                <li>
                  <a href="#">
                    <router-link :to="{name:'admin'}" class="nav-link">Dashboard</router-link>
                  </a>									
                </li>																
              </ul>
            </div>
            <div class="header__more">
              <button class="btn" type="button" v-if="currentRouteName=='login'">
                <router-link :to="{name:'register'}" class="bg-connectyed-button-light text-connectyed-button-dark hover:bg-connectyed-button-hover-light hover:text-connectyed-button-light py-4 px-5">Register</router-link>
              </button>                          
              <button class="btn"type="button" v-else-if="currentRouteName=='register' || !user.user.name">
                <router-link :to="{name:'login'}" class="bg-connectyed-button-light text-connectyed-button-dark hover:bg-connectyed-button-hover-light hover:text-connectyed-button-light py-4 px-5">Login</router-link>
              </button>
                        
              <a @click="logout" href="javascript:void(0)" class="bg-connectyed-button-light text-connectyed-button-dark hover:bg-connectyed-button-hover-light hover:text-connectyed-button-light py-4 px-5" aria-current="page" v-if="!!user.user.name">Logout</a>
            </div>
          </div>
        </nav>      
    </div>
    </header>
    <!-- ================> header section end here <================== -->
    <main>      
        <router-view></router-view>      
    </main>
  
  
    <!-- ================> Footer section start here <================== -->
  <footer class="footer footer--style2">        
    <div class="footer__bottom wow fadeInUp" data-wow-duration="1.5s">
      <div class="container">
        <div class="footer__content text-center">
          <p class="mb-0">All Rights Reserved &copy; <a href="index.html">Connectyed</a> || Design By: Connectyed</p>
        </div>
      </div>
    </div>
  </footer>
    <!-- ================> Footer section end here <================== -->
  </template>
  
  <script setup>
  import { reactive, computed } from 'vue'
  import { Disclosure, DisclosureButton, DisclosurePanel, Menu, MenuButton, MenuItem, MenuItems } from '@headlessui/vue'
  import { Bars3Icon, BellIcon, XMarkIcon } from '@heroicons/vue/24/outline'
  import { useStore } from 'vuex'
  import { useRouter, useRoute } from 'vue-router'
  
  const store = useStore();
  const router = useRouter();
  const route = useRoute();
  const currentRouteName = computed(() => route.name)
  const auth = reactive(store.state.auth)
  const user = auth.user
  
  const logout = async () => {  
    const token = auth.authorization.token  
    //const headers = { 'Authorization': `Bearer ${token}` }
    await axios.post('/api/user/logout').then(({data})=>{
      localStorage.getItem("user", JSON.stringify(data))                    
	    axios.defaults.headers.common.Authorization = `Bearer ${data.authorization.token}`
      store.dispatch('auth/logout')
      router.push({name:"home"})                  
    }).catch((error) => {
      console.error(error)
      store.dispatch('auth/logout')
      router.push({name:"home"}) 
    }) 
  }
  </script>