<template>
    <div class="mx-auto max-w-7xl py-6 sm:px-6 lg:px-8 flex items-center justify-center">        
        <div class="w-full max-w-sm mt-20 ">
            <div class="font-bold text-xl mb-2">Login</div>
            <form class="bg-connectyed-card-light shadow-md rounded px-8 pt-6 pb-8 mb-4 border-solid border-2 border-gray-200" action="javascript:void(0)" method="post">
                <div class="mb-1" v-if="Object.keys(validationErrors).length > 0">
                    <div class="alert alert-danger">
                        <ul class="mb-0">
                            <li class="text-red-500 text-xs italic" v-for="(value, key) in validationErrors" :key="key">{{ value[0] }}</li>
                        </ul>
                    </div>
                </div>
                <div class="mb-4">
                <label class="block text-gray-700 text-sm font-bold mb-2" for="username">
                    Username
                </label>
                <input class="appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" v-model="auth.username" name="username" id="username" type="text" placeholder="Username" autocomplete="off">
                </div>
                <div class="mb-6">
                <label class="block text-gray-700 text-sm font-bold mb-2" for="password">
                    Password
                </label>
                <input class="appearance-none border rounded w-full py-2 px-3 text-gray-700 mb-3 leading-tight focus:outline-none focus:shadow-outline" v-model="auth.password" name="password" id="password" type="password" placeholder="******">
                </div>
                <div class="flex items-center justify-between">
                <button class="bg-connectyed-button-light text-connectyed-button-dark hover:bg-connectyed-button-hover-light hover:text-connectyed-button-light w-full h-12 duration-150" type="submit" :disabled="processing" @click="login">
                    {{ processing ? "Please wait" : "Login" }}
                </button>
                </div>
                <div class="my-5 text-black">
                    
                </div>
        
                <label>Don't have an account? <router-link :to="{name:'register'}">Register Now!</router-link></label>
                <div class="mt-4">
                <router-link to="/password/forgot" class="text-blue-500 hover:underline">
                    Forgot your password?
                </router-link>
            </div>
            </form>

            <p class="text-center text-gray-500 text-xs">
                &copy;2024 Connectyed.
            </p>
        </div>
    </div>
</template>
    
    <script>
    import { mapActions } from 'vuex'       
                    
    export default {
        name:"login",
        data(){
            return {
                auth:{
                    username:"",
                    password:""
                },
                validationErrors:{},
                processing:false
            }
        },
        methods:{
            ...mapActions({
                signIn:'auth/login'
            }),
            async login() {                
                this.processing = true
                await axios.post('/api/user/login', this.auth).then(({ data }) => {                        
                    localStorage.setItem("user", JSON.stringify(data))                    
                    axios.defaults.headers.common.Authorization = `Bearer ${data.authorization.token}`
                    this.signIn()                                        
                    if (data.data.user.role === 'admin') {
                        this.$router.push({ name: 'admin' });
                    } else if (data.data.user.role === 'matchmaker') {
                        this.$router.push({ name: 'matchmaker' });                        
                    } else if (data.data.user.role === 'candidate') {
                        this.$router.push({ name: 'matchmaker' });
                    } else if (data.data.user.role === 'client') {                       
                        this.$router.push({ name: 'dashboard' });                        
                    }
                }).catch(({response}) => {                    
                    if(response.status===422){
                        this.validationErrors = response.data.data
                        //console.log(response)
                    } else {                                      
                        this.validationErrors = response.data.data
                        //console.log("2", response)
                    }
                }).finally(()=>{
                    this.processing = false
                })
            },
        }
    }
    </script>