<template>
    <div class="mx-auto max-w-7xl py-6 sm:px-6 lg:px-8 flex items-center justify-center">    
        <div class="w-full max-w-sm mt-20">
            <div class="font-bold text-xl mb-2">Register</div>
            <form class="bg-connectyed-card-light shadow-md rounded px-8 pt-6 pb-8 mb-4 border-solid border-2 border-gray-200" action="javascript:void(0)" @submit="register" method="post">
                <div class="mb-1" v-if="Object.keys(validationErrors).length > 0">
                    <div class="alert alert-danger">
                        <ul class="mb-0">
                            <li class="text-red-500 text-xs italic" v-for="(value, key) in validationErrors" :key="key">{{ value[0] }}</li>
                        </ul>
                    </div>
                </div>
                <div class="mb-4">
                    <label class="block text-gray-700 text-sm font-bold mb-2" for="name">
                        Name
                    </label>
                    <input class="appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" type="text" name="name" v-model="user.name" id="name" placeholder="Enter name" autocomplete="off"> 
                </div>
                <div class="mb-4">
                    <label class="block text-gray-700 text-sm font-bold mb-2" for="username">
                        Username
                    </label>
                    <input class="appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" type="text" name="username" v-model="user.username" id="username" placeholder="Enter Username" autocomplete="off">        
                </div>
                <div class="mb-4">
                    <label class="block text-gray-700 text-sm font-bold mb-2" for="email">
                        Email
                    </label>
                    <input class="appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" type="text" name="email" v-model="user.email" id="email" placeholder="Enter Email" autocomplete="off">        
                </div>
                <div class="mb-6">
                    <label class="block text-gray-700 text-sm font-bold mb-2" for="password">
                        Password
                    </label>
                    <input class="appearance-none border rounded w-full py-2 px-3 text-gray-700 mb-3 leading-tight focus:outline-none focus:shadow-outline" type="password" name="password" v-model="user.password" id="password" placeholder="Enter Password">        
                </div>
                <div class="mb-6">
                    <label class="block text-gray-700 text-sm font-bold mb-2" for="password_confirmation">
                        Confirm Password
                    </label>
                    <input class="appearance-none border rounded w-full py-2 px-3 text-gray-700 mb-3 leading-tight focus:outline-none focus:shadow-outline" type="password" name="password_confirmation" v-model="user.password_confirmation" id="password_confirmation" placeholder="Confirm Password" >        
                </div>
                <div class="flex items-center justify-between mb-6">
                    <button class="bg-connectyed-button-light text-connectyed-button-dark hover:bg-connectyed-button-hover-light hover:text-connectyed-button-light w-full h-12 transition-colors duration-150 focus:shadow-outline font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline max-w-100" type="submit" :disabled="processing" @click="login">
                        {{ processing ? "Please wait" : "Register" }}
                    </button>
                </div>
                <label>Already have an account? <router-link :to="{name:'login'}">Login Now!</router-link></label>
            </form>
            <p class="text-center text-gray-500 text-xs">
                &copy;2024 Connectyed.
            </p>
        </div>
    </div>
</template>

<script>
import axios from 'axios'
import { mapActions } from 'vuex'
export default {
    name:'register',
    data(){
        return {
            user:{
                name:"",
                username:"",
                email:"",
                password:"",
                password_confirmation:""
            },
            validationErrors:{},
            processing:false
        }
    },
    methods:{
        ...mapActions({
            signIn:'auth/login'
        }),
        async register(){
            this.processing = true
            await axios.post('/api/user/register',this.user).then(response=>{                
                if (response.data.success === true) {
                    this.validationErrors = {}                
                    this.$router.push({ name: "login" });
                } else {
                    this.validationErrors = response.data.data
                }                                
            }).catch(({response})=>{
                if(response.status===422){
                    this.validationErrors = response.data.errors
                }else{
                    this.validationErrors = {}
                    alert(response.data.message)
                }
            }).finally(()=>{
                this.processing = false
            })
        }
    }
}
</script>