<template>
  <div class="min-h-full">
    <Disclosure as="nav" class="bg-gray-800" v-slot="{ open }">
      <div class="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
        <div class="flex h-16 items-center justify-between">
          <div class="flex items-center">
            <div class="flex-shrink-0">
              <img class="h-8 w-8" src="assets/images/icons/logo.svg" alt="Your Company" />
            </div>
          </div>
          <div class="hidden md:block">
            <div class="ml-4 flex items-center md:ml-6">
              <div class="ml-5 flex items-baseline space-x-4">
                <a href="#" class="bg-gray-900 text-white rounded-md px-3 py-2 text-sm font-medium" aria-current="page">
                    <router-link :to="{name:'dashboard'}" class="nav-link">Dashboard</router-link>
                </a>
              </div>
              <div class="ml-5 flex items-baseline space-x-4">
                <a href="#" class="bg-gray-900 text-white rounded-md px-3 py-2 text-sm font-medium" aria-current="page">
                    <router-link :to="{name:'home'}" class="nav-link">Blogs</router-link>
                </a>
              </div>
              <div class="ml-5 flex items-baseline space-x-4" v-if="currentRouteName=='login'">
                <a href="#" class="bg-gray-900 text-white rounded-md px-3 py-2 text-sm font-medium" aria-current="page">
                  <router-link :to="{name:'register'}" class="nav-link">Register</router-link>
                </a>
              </div>
              <div class="ml-5 flex items-baseline space-x-4" v-else-if="currentRouteName=='register' || !user.name">
                <a href="#" class="bg-gray-900 text-white rounded-md px-3 py-2 text-sm font-medium" aria-current="page">
                  <router-link :to="{name:'login'}" class="nav-link">Login</router-link>
                </a>
              </div>
              <div class="ml-5 flex items-baseline space-x-4" v-if="!!user.name">
                <a @click="logout" href="javascript:void(0)" class="bg-gray-900 text-white rounded-md px-3 py-2 text-sm font-medium" aria-current="page">Logout</a>
              </div>
            </div>
          </div>
          <div class="-mr-2 flex md:hidden">
            <!-- Mobile menu button -->
            <DisclosureButton class="relative inline-flex items-center justify-center rounded-md bg-gray-800 p-2 text-gray-400 hover:bg-gray-700 hover:text-white focus:outline-none focus:ring-2 focus:ring-white focus:ring-offset-2 focus:ring-offset-gray-800">
              <span class="absolute -inset-0.5" />
              <span class="sr-only">Open main menu</span>
              <Bars3Icon v-if="!open" class="block h-6 w-6" aria-hidden="true" />
              <XMarkIcon v-else class="block h-6 w-6" aria-hidden="true" />
            </DisclosureButton>
          </div>
        </div>
      </div>

      <DisclosurePanel class="md:hidden">
        <div class="space-y-1 px-2 pb-3 pt-2 sm:px-3">
          <DisclosureButton v-for="item in navigation" :key="item.name" as="a" :href="item.href" :class="[item.current ? 'bg-gray-900 text-white' : 'text-gray-300 hover:bg-gray-700 hover:text-white', 'block rounded-md px-3 py-2 text-base font-medium']" :aria-current="item.current ? 'page' : undefined">{{ item.name }}</DisclosureButton>
        </div>
        <div class="border-t border-gray-700 pb-3 pt-4">
          <div class="flex items-center px-5">
            <div class="ml-5 flex items-baseline space-x-4">
                <a href="#" class="text-white rounded-md px-3 py-2 text-md font-medium" aria-current="page">
                    <router-link :to="{name:'dashboard'}" class="nav-link">Dashboard</router-link>
                </a>
              </div>
          </div>

          <div class="flex items-center px-5">
            <div class="ml-5 flex items-baseline space-x-4">
                <a href="#" class="text-white rounded-md px-3 py-2 text-md font-medium" aria-current="page">
                    <router-link :to="{name:'home'}" class="nav-link">Blogs</router-link>
                </a>
              </div>
          </div>
          
          <div class="flex items-center px-5" v-if="currentRouteName=='login'">          
            <div class="ml-5 flex items-baseline space-x-4">
              <a href="#" class="bg-gray-900 text-white rounded-md px-3 py-2 text-sm font-medium" aria-current="page">
                <router-link :to="{name:'register'}" class="nav-link">Register</router-link>
              </a>
            </div>
          </div>
              
          <div class="flex items-center px-5" v-else-if="currentRouteName=='register' || !user.name">
            <div class="ml-5 flex items-baseline space-x-4">
                <a href="#" class="bg-gray-900 text-white rounded-md px-3 py-2 text-sm font-medium" aria-current="page">
                  <router-link :to="{name:'login'}" class="nav-link">Login</router-link>
                </a>
              </div>
          </div>
          
          <div class="flex items-center px-5" v-if="!!user.name">
            <div class="ml-5 flex items-baseline space-x-4">
              <a @click="logout" href="javascript:void(0)" class="bg-gray-900 text-white rounded-md px-3 py-2 text-sm font-medium" aria-current="page">Logout</a>
            </div>
          </div>          

          <div class="mt-3 space-y-1 px-2">
            <DisclosureButton v-for="item in guestNavigation" :key="item.name" as="a" :href="item.href" class="block rounded-md px-3 py-2 text-base font-medium text-gray-400 hover:bg-gray-700 hover:text-white">{{ item.name }}</DisclosureButton>
          </div>
        </div>
      </DisclosurePanel>
    </Disclosure>

    <header class="bg-white shadow">
      <div class="mx-auto max-w-7xl px-4 py-6 sm:px-6 lg:px-8">
        <h1 class="text-3xl font-bold tracking-tight text-gray-900">Blogs</h1>
      </div>
    </header>
    <main>      
        <router-view></router-view>      
    </main>
  </div>
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

  await axios.post('/api/user/logout').then(({data})=>{
    axios.defaults.headers.common.Authorization = `Bearer ${token}`
    store.dispatch('auth/logout')
    router.push({name:"home"})                  
  }).catch((error) => {
    console.error(error)
    store.dispatch('auth/logout')
    router.push({name:"home"}) 
  }) 
}
</script>