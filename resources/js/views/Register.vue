<template>
    <div class="max-w-lg mx-auto p-4 bg-white">
      <h2 class="text-xl font-semibold mb-4">{{ form.ismatchmaker ? 'Matchmaker Registration' : 'Client Registration' }}</h2>
        <div v-if="successMessage" class="bg-green-200 text-green-800 p-4 mt-4 rounded absolute top-16">
        {{ successMessage }}
        </div>


        <div class="font-bold text-xl mb-2">

            <div class="relative">
                <label class="flex items-center cursor-pointer mb-4 bg-orange-50 py-2 px-1 rounded-xl">
                    <!-- Switch Container -->
                    <div class="relative">
                        <!-- Hidden checkbox input -->
                        <input type="checkbox" v-model="form.ismatchmaker" class="sr-only" @click="switchMatchmaker"/>

                        <!-- Switch background -->
                        <div
                        :class="{
                            'bg-connectyed-button-light': !form.ismatchmaker,
                            'bg-connectyed-button-dark': form.ismatchmaker
                        }"
                        class="block w-14 h-8 rounded-full transition-colors duration-300"
                        ></div>

                        <!-- Switch handle -->
                        <div
                        class="dot absolute left-1 top-1 bg-white w-6 h-6 rounded-full transition-transform duration-300"
                        :class="{ 'translate-x-6': form.ismatchmaker }"
                        ></div>
                    </div>
                    <span class="ml-3 text-gray-700 text-base uppercase">{{ form.ismatchmaker ? 'Switch to Register as a Client' : 'Switch to Register as a Matchmaker' }}</span>
                </label>                            
            </div>  
            <span class="float-right" v-if="processing"><img class="h-5 ml-3" src="assets/images/icons/process.gif"></span>
        </div>


      <!-- Step Indicator -->
      <div class="flex items-center mb-6" v-if="!form.ismatchmaker">        
        <div v-for="(step, index) in steps" :key="index">
          <div @click="goToStep(step)"
            class="text-center py-2 px-3 mx-1 rounded-full cursor-pointer"
            :class="{
              'bg-connectyed-button-light text-connectyed-button-dark': currentStep === index + 1,
              'bg-gray-200 text-gray-600': currentStep !== index + 1
            }"
          >
            {{ index + 1 }}
          </div>
        </div>
      </div>

        <form action="javascript:void(0)" @submit="register" method="post">
            <!-- Form Steps -->
            <div v-if="currentStep === 1">
                <!-- Step 1: Account Information -->
                <h3 class="font-semibold text-lg mb-4">Account Information</h3>
                <div class="grid grid-cols-1 md:grid-cols-1 gap-1">
                <input-text label="Name" v-model="form.name" :required="true" :error="!!errors.name"
                :errorMessage="errors.name"/>
                <input-text label="Username" v-model="form.username" :required="true" :error="!!errors.username"
                :errorMessage="errors.username"/>
                <input-text label="Email" v-model="form.email" :required="true" :error="!!errors.email"
                :errorMessage="errors.email"/>
                <input-text label="Password" type="password" v-model="form.password" :required="true" :error="!!errors.password"
                :errorMessage="errors.password"/>
                <input-text label="Confirm Password" type="password" v-model="form.password_confirmation" :required="true" :error="!!errors.password_confirmation"
                :errorMessage="errors.password_confirmation"/>
                </div>
            </div>
        
            <div v-if="currentStep === 2">
                <!-- Step 2: Location Details -->
                <h3 class="font-semibold text-lg mb-4">Location Details</h3>
                <div class="grid grid-cols-1 md:grid-cols-1 gap-1">
                <input-text label="City" v-model="form.city" :required="true" :error="!!errors.city"
                :errorMessage="errors.city"/>
                <input-text label="State" v-model="form.state" :required="true" :error="!!errors.state"
                :errorMessage="errors.state"/>
                <select-option label="Country" :options="countries" v-model="form.country" :required="true" :error="!!errors.country"
                :errorMessage="errors.country"/>
                <input-text label="Current Location (City)" v-model="form.currentLocation" :required="true" :error="!!errors.currentLocation"
                :errorMessage="errors.currentLocation"/>
                </div>
            </div>
        
            <div v-if="currentStep === 3">
                <!-- Step 3: Personal Information -->
                <h3 class="font-semibold text-lg mb-4">Personal Information</h3>
                <div class="grid grid-cols-1 md:grid-cols-1 gap-1">
                <input-text label="Age" v-model="form.age" :required="true" :error="!!errors.age"
                :errorMessage="errors.age"/>
                <select-option label="Gender" :options="genders" v-model="form.gender" :required="true" :error="!!errors.gender"
                :errorMessage="errors.gender"/>
                <input-text label="Hair Color" v-model="form.hairColor" :required="true" :error="!!errors.hairColor"
                :errorMessage="errors.hairColor"/>
                <input-text label="Weight (lbs)" v-model="form.weight" :required="true" :error="!!errors.weight"
                :errorMessage="errors.weight"/>
                <div class="flex gap-4">
                    <input-text label="Height (Feet)" v-model="form.heightFeet" :required="true" :error="!!errors.heightFeet"
                    :errorMessage="errors.heightFeet"/>
                    <input-text label="Inches" v-model="form.heightInches" :required="true" :error="!!errors.heightInches"
                    :errorMessage="errors.heightInches"/>
                </div>
                </div>
            </div>
        
            <div v-if="currentStep === 4">
                <!-- Step 4: Lifestyle Information -->
                <h3 class="font-semibold text-lg mb-4">Lifestyle Information</h3>
                <div class="grid grid-cols-1 md:grid-cols-1 gap-1">
                <select-option label="Marital Status" :options="maritalStatuses" v-model="form.maritalStatus" :required="true"/>
                <select-option label="Children" :options="childrenOptions" v-model="form.children" :required="true"/>
                <select-option label="Religion" :options="religions" v-model="form.religion" :required="true"/>
                <select-option label="Smoker" :options="yesNoOptions" v-model="form.smoker" :required="true"/>
                <select-option label="Drinker" :options="drinkerOptions" v-model="form.drinker" :required="true"/>
                </div>
            </div>
        
            <div v-if="currentStep === 5">
                <!-- Step 5: Professional and Hobbies -->
                <h3 class="font-semibold text-lg mb-4">Professional and Hobbies</h3>
                <div class="grid grid-cols-1 md:grid-cols-1 gap-1">
                <input-text label="Education" v-model="form.education" :required="true" :error="!!errors.education"
                :errorMessage="errors.education"/>
                <input-text label="Job Title" v-model="form.jobTitle" :required="true" :error="!!errors.jobTitle"
                :errorMessage="errors.jobTitle"/>
                <input-text label="Sports" v-model="form.sports" :required="true" :error="!!errors.sports" :errorMessage="errors.sports"/>
                <input-text label="Hobbies" v-model="form.hobbies" :required="true" :error="!!errors.hobbies"
                :errorMessage="errors.hobbies"/>
                </div>
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4 mt-4">
                <select-option label="English Level" :options="englishLevels" v-model="form.englishLevel" :required="true" :error="!!errors.englishLevel"
                :errorMessage="errors.englishLevel"/>
                <input-text label="Languages" v-model="form.languages" :required="true" :error="!!errors.languages"
                :errorMessage="errors.languages"/>
                </div>
            </div>
        
            <div v-if="currentStep === 6">
                <!-- Step 6: Terms and Privacy -->
                <h3 class="font-semibold text-lg mb-4">Terms and Conditions</h3>
                <div class="space-y-4 flex">
                    <label class="text-gray-500 text-sm mb-2 flex text-left">
                        <div class="text-right w-4 m-1">
                            <input type="checkbox" v-model="form.privacypolicy" id="privacypolicy" name="privacypolicy" :required="true" :error="!!errors.privacypolicy"
                            :errorMessage="errors.privacypolicy">
                        </div>
                        <div class="px-2 text-lg">
                        I have read and agree to the
                        </div>
                    </label>
                        <a @click="showPrivacy()" class="text-connectyed-link-dark relative -top-3 -ml-1">
                            Privacy Policy 
                        </a>
                </div>
                <div class="space-y-4 flex"> 
                    <label class="text-gray-500 text-sm mb-2 flex text-left">
                        <div class="text-left w-4 m-1">
                        <input type="checkbox" v-model="form.termsofuse" id="termsofuse" name="termsofuse" :required="true" :error="!!errors.termsofuse"
                        :errorMessage="errors.termsofuse"/>
                        </div>
                        <div class="px-2 text-lg">
                        I have read and agree to the
                        </div>
                    </label>
                    <a @click="showTerm()" class="text-connectyed-link-dark relative -top-3 -ml-1"> 
                        Terms of Use
                    </a>
                </div>
            </div>
        
            <!-- Navigation Buttons -->
            <div class="mt-6">
                <a
                    v-if="currentStep > 1"
                    class="bg-connectyed-button-pagination-light text-connectyed-button-dark py-2 px-4 rounded min-w-32 cursor-pointer"
                    @click="prevStep"
                    :disabled="currentStep === 1"
                >
                Previous
                </a>
                <a
                v-if="currentStep < steps.length"
                class="bg-connectyed-button-pagination-light text-connectyed-button-dark py-2 px-4 rounded min-w-32 float-right cursor-pointer"
                @click="nextStep"
                >
                Next
                </a>
                <button
                v-else
                class="bg-connectyed-button-light hover:bg-connectyed-button-hover-light text-connectyed-button-hover-light hover:text-connectyed-button-hover-dark py-2 px-4 rounded float-right"
                type="submit"
                :disabled="processing"
                @click="register"
                >
                {{ processing ? "Please wait" : "Register" }}
                </button>
            </div>

        </form>

        <label class="my-4 w-full">Already have an account? <router-link :to="{name:'login'}">Login Now!</router-link></label>

        </div>

    <pdf-modal :isOpen="isModalOpen" :pdfUrl="pdfUrl" @close="closeModal" />
</template>
  
<script>
import axios from 'axios'
import { mapActions } from 'vuex'
import PdfModal from '../components/PdfModal.vue';
import InputText from '../components/InputText.vue';
import SelectOption from '../components/SelectOption.vue';
// Other imports

export default {
    name:"register",
    components: {
        InputText,
        SelectOption,
        PdfModal,
    },
    data() {
      return {
            currentStep: 1,
            steps: [1, 2, 3, 4, 5, 6],
            form: {
                name: "",
                username: "",
                email: "",
                password: "",
                password_confirmation: "",
                city: "",
                state: "",
                country: "",
                currentLocation: "",
                age: "",
                gender: "",
                hairColor: "",
                weight: "",
                heightFeet: "",
                heightInches: "",
                maritalStatus: "",
                children: "",
                religion: "",
                smoker: "",
                drinker: "",
                education: "",
                jobTitle: "",
                sports: "",
                hobbies: "",
                englishLevel: "",
                languages: "",
                privacypolicy: false,
                termsofuse: false,
                ismatchmaker: false
          },
            errors: {
                name: '',
                username: '',
                email:'',
                password: '',
                password_confirmation: '',
                city: '',
                state: '',
                country: '',
                currentLocation: '',
                age: '',
                gender: '',
                hairColor: '',
                weight: '',
                heightFeet: '',
                heightInches: '',
                maritalStatus: '',
                children: '',
                religion: '',
                smoker: '',
                drinker: '',
                education: '',
                jobTitle: '',
                sports: '',
                hobbies: '',
                englishLevel: '',
                languages: '',
                privacypolicy: false,
                termsofuse: false
          },
            errorCount: 0,
            countries: ['United States of America', 'Canada'],
            genders: ['Male', 'Female'],
            maritalStatuses: ['Single', 'Separated', 'Divorced'],
            childrenOptions: ['0', '1', '2', '3', '4'],
            religions: ['Buddhism', 'Catholic', 'Christian', 'Confucianism', 'Hinduism', 'Islam', 'Jainism', 'Judaism', 'Shinto', 'Sikhism', 'Taoism', 'Zoroastrianism', 'Other'],
            yesNoOptions: ['Yes', 'No'],
            drinkerOptions: ['None', 'Occasionally', 'Often'],
            englishLevels: ['Beginner', 'Intermediate', 'Proficient'],
            successMessage: '',
            validationErrors: {},
            isModalOpen: false,
            pdfUrl: '',
            modalMode: {
                header: "",
            },            
            processing:false
      };
    },
    methods: {
        ...mapActions({
            signIn:'auth/register'
        }),
        nextStep() {
            this.clearErrors();           
            if (this.currentStep == 1) {
                if (this.form.name === '') {
                    this.errors.name = 'Name is required';
                    this.errorCount++;
                } else if (this.form.username === '') {
                    this.errors.username = 'Username is required';
                    this.errorCount++;
                } else if (this.form.email === '') {
                    this.errors.email = 'Email is required';
                    this.errorCount++;
                } else if (this.form.password === '') {
                    this.errors.password = 'Password is required';
                    this.errorCount++;
                } else if (this.form.password_confirmation === '') {
                    this.errors.password_confirmation = 'Password confirmation is required';
                    this.errorCount++;
                }                
            } else if (this.currentStep == 2) {
                if (this.form.city === '') {
                    this.errors.city = 'City is required';
                    this.errorCount++;
                } else if (this.form.state === '') {
                    this.errors.state = 'State is required';
                    this.errorCount++;
                } else if (this.form.country === '') {
                    this.errors.country = 'Country is required';
                    this.errorCount++;
                } else if (this.form.currentLocation === '') {
                    this.errors.currentLocation = 'Current Location is required';
                    this.errorCount++;
                } 
            } else if (this.currentStep == 3) {
                if (this.form.age === '') {
                    this.errors.age = 'Age is required';
                    this.errorCount++;
                } else if (this.form.gender === '') {
                    this.errors.gender = 'Gender is required';
                    this.errorCount++;
                } else if (this.form.hairColor === '') {
                    this.errors.hairColor = 'Hair Color is required';
                    this.errorCount++;
                } else if (this.form.weight === '') {
                    this.errors.weight = 'Weight is required';
                    this.errorCount++;
                } else if (this.form.heightFeet === '') {
                    this.errors.heightFeet = 'Height in Feet is required';
                    this.errorCount++;
                } else if (this.form.heightInches === '') {
                    this.errors.heightInches = 'Inches is required';
                    this.errorCount++;
                } 
            } else if (this.currentStep == 4) {
                if (this.form.maritalStatuses === '') {
                    this.errors.maritalStatuses = 'Marital Status is required';
                    this.errorCount++;
                } else if (this.form.children === '') {
                    this.errors.children = 'Children is required';
                    this.errorCount++;
                } else if (this.form.religion === '') {
                    this.errors.religion = 'Religion is required';
                    this.errorCount++;
                } else if (this.form.smoker === '') {
                    this.errors.smoker = 'Smoker is required';
                    this.errorCount++;
                } else if (this.form.drinker === '') {
                    this.errors.drinker = 'Drinker is required';
                    this.errorCount++;
                } 
            } else if (this.currentStep == 5) {
                if (this.form.education === '') {
                    this.errors.education = 'Education Status is required';
                    this.errorCount++;
                } else if (this.form.jobTitle === '') {
                    this.errors.jobTitle = 'JobTitle is required';
                    this.errorCount++;
                } else if (this.form.sports === '') {
                    this.errors.sports = 'Sports is required';
                    this.errorCount++;
                } else if (this.form.hobbies === '') {
                    this.errors.hobbies = 'Hobbies is required';
                    this.errorCount++;
                } else if (this.form.englishLevel === '') {
                    this.errors.englishLevel = 'English Level is required';
                    this.errorCount++;
                } else if (this.form.languages === '') {                    
                    this.errors.languages = 'Languages is required';
                    this.errorCount++;
                }                
            } else if (this.currentStep == 6) { 
                if (!this.form.privacypolicy) {
                    this.errors.privacypolicy = 'Privacy Policy is required';
                    this.errorCount++;
                } else if (!this.form.termsofuse) {
                    this.errors.termsofuse = 'Term of Use is required';
                    this.errorCount++;
                }
            }
            if (this.errorCount === 0) {
                if (this.currentStep < this.steps.length) {
                    if (this.form.ismatchmaker === true) {
                        if (this.currentStep == 2) {
                            this.currentStep = this.currentStep+4;    
                        } else {
                            this.currentStep++;    
                        }
                    } else {
                        this.currentStep++;
                    }                                        
                }   
            }               
            this.errorCount = 0;
        },
        clearErrors() {
            this.errors = {
                name: '',
                username: '',
                email:'',
                password: '',
                password_confirmation: '',
                city: '',
                state: '',
                country: '',
                currentLocation: '',
                age: '',
                gender: '',
                hairColor: '',
                weight: '',
                heightFeet: '',
                heightInches: '',
                maritalStatus: '',
                children: '',
                religion: '',
                smoker: '',
                drinker: '',
                education: '',
                jobTitle: '',
                sports: '',
                hobbies: '',
                englishLevel: '',
                languages: '',
                privacypolicy: false,
                termsofuse: false
            };
        },
        prevStep() {
            if (this.currentStep > 1) {
                if (this.form.ismatchmaker === true) {
                    if (this.currentStep == 6) {
                        this.currentStep = this.currentStep-4;
                    } else {
                        this.currentStep--;
                    }
                } else {
                    this.currentStep--;
                }             
            }
        },
        goToStep(number) {
            this.currentStep = number
        },
        showPrivacy() {        
            this.modalMode.header = "Privacy Policy"        
            this.pdfUrl = "/upload/pdf/privacypolicy.pdf";
            this.isModalOpen = true;    
            console.log("Privacy Policy")                        
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
        async register() {
            console.log("register")
            this.processing = true
            await axios.post('/api/user/register', this.form).then(response=>{                
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
                    console.log("response", response)
                    alert(response.data.message)
                }
            }).finally(()=>{
                this.processing = false
            })
        },
        switchMatchmaker() {
            this.form.ismatchmaker = !this.form.ismatchmaker
            if (this.form.ismatchmaker === true) {
                this.steps = [1, 2, 6]
            }
        }
    }
  };
  </script>
  