<template>
    <div class="mx-auto max-w-7xl py-6 sm:px-6 lg:px-8 flex items-center justify-center">    
        <div class="w-full max-w-sm">
            <div v-if="successMessage" class="bg-green-200 text-green-800 p-4 mt-4 rounded absolute top-16">
            {{ successMessage }}
            </div>
            <div class="font-bold text-xl mb-2">

                <div class="relative">
                    <label class="flex items-center cursor-pointer">
                        <!-- Switch Container -->
                        <div class="relative">
                            <!-- Hidden checkbox input -->
                            <input type="checkbox" v-model="user.ismatchmaker" class="sr-only" />

                            <!-- Switch background -->
                            <div
                            :class="{
                                'bg-connectyed-button-light': !user.ismatchmaker,
                                'bg-connectyed-button-dark': user.ismatchmaker
                            }"
                            class="block w-14 h-8 rounded-full transition-colors duration-300"
                            ></div>

                            <!-- Switch handle -->
                            <div
                            class="dot absolute left-1 top-1 bg-white w-6 h-6 rounded-full transition-transform duration-300"
                            :class="{ 'translate-x-6': user.ismatchmaker }"
                            ></div>
                        </div>
                        <span class="ml-3 text-gray-700 text-base">{{ user.ismatchmaker ? 'Register as Matchmaker' : 'Switch to register as Matchmaker' }}</span>
                    </label>                            
                </div>  
                <span class="float-right" v-if="processing"><img class="h-5 ml-3" src="assets/images/icons/process.gif"></span>
            </div>
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
                <div class="mb-2">
                    <label class="block text-gray-700 text-sm font-bold mb-2" for="password_confirmation">
                        Confirm Password
                    </label>
                    <input class="appearance-none border rounded w-full py-2 px-3 text-gray-700 mb-3 leading-tight focus:outline-none focus:shadow-outline" type="password" name="password_confirmation" v-model="user.password_confirmation" id="password_confirmation" placeholder="Confirm Password" >        
                </div>
                <div class="mb-1">                                      
                    <label class="block text-gray-500 text-sm mb-2" for="privacypolicy">
                        <input class="w-4" id="privacypolicy" name="privacypolicy" type="checkbox" v-model="user.privacypolicy">  
                        I have read and agree to the 
                        <a @click="showPrivacy()" class="text-connectyed-link-dark">
                            Privacy Policy 
                        </a>
                    </label>
                </div>
                <div class="mb-6">
                    <label class="block text-gray-500 text-sm mb-2" for="termsofuse">
                        <input class="w-4" id="termsofuse" name="termsofuse" type="checkbox" v-model="user.termsofuse">
                        I have read and agree to the
                        <a @click="showTerm()" class="text-connectyed-link-dark"> 
                            Terms of Use.
                        </a>
                    </label>    
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
    <pdf-modal :isOpen="isModalOpen" :pdfUrl="pdfUrl" @close="closeModal" />
</template>

<script>
import axios from 'axios'
import { mapActions } from 'vuex'
import PdfModal from '../components/PdfModal.vue';

export default {
    name: 'register',
    components: {
        PdfModal,
    },
    data(){
        return {
            user:{
                name:"",
                username:"",
                email:"",
                password:"",
                password_confirmation: "",
                privacypolicy:"",
                termsofuse: "",
                ismatchmaker: false,
            },
            successMessage: '',
            validationErrors: {},
            isModalOpen: false,
            pdfUrl: '',
            modalMode: {
                header: "",
            },            
            processing:false
        }
    },
    methods:{
        ...mapActions({
            signIn:'auth/login'
        }),
        showPrivacy() {        
            this.modalMode.header = "Privacy Policy"        
            this.pdfUrl = "/upload/pdf/privacypolicy.pdf";
            this.isModalOpen = true;                            
        },
        showTerm() {        
            this.modalMode.header = "Terms of Use Agreement"                        
            this.pdfUrl = "/upload/pdf/termsofuse.pdf";
            this.isModalOpen = true; 
        },
        closeModal() {
            this.isModalOpen = false;
            this.pdfUrl = '';
        },
        async register(){
            this.processing = true
            await axios.post('/api/user/register',this.user).then(response=>{                
                if (response.data.success === true) {
                    this.successMessage = response.data.message
                    this.validationErrors = {}                                    
                    setTimeout(() => {
                        this.$router.push({ name: "login" });
                    }, 1500);
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