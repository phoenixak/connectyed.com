<template>
  <div class="max-w-7xl mx-auto p-6 bg-white rounded-sm shadow-xs">
    <!-- Header -->
    <div class="flex justify-between items-center mb-6">
      <h2 class="text-2xl font-semibold">Matchmaker's Clients</h2>
      <!-- Add Client Button -->
      <button
        @click="showAddClientForm = !showAddClientForm"
        class="bg-green-500 hover:bg-green-700 text-white font-bold py-2 px-4 rounded"
      >
        {{ showAddClientForm ? 'Cancel' : 'Add Client' }}
      </button>
    </div>

    <!-- Add Client Form -->
    <div v-if="showAddClientForm" class="mb-10">
      <h3 class="text-xl font-semibold mb-4">Add New Client</h3>


      <form @submit.prevent="addClient" enctype="multipart/form-data"> 
        <div class="mb-1" v-if="Object.keys(validationErrors).length > 0">
            <div class="alert alert-danger">
                <ul class="mb-0">
                    <li class="text-red-500 text-xs italic" v-for="(value, key) in validationErrors" :key="key">{{ value[0] }}</li>
                </ul>
            </div>
        </div>                       
        <!-- Step 1: Account Information -->        
        <div class="mb-4">
          <div v-if="preview" class="mb-4">
            <img :src="preview" alt="Image Preview" class="w-48 h-48 object-cover rounded-md shadow-lg" />
          </div>
          <label for="avatar" class="block text-gray-700">Upload Image</label>
          <input @change="onFileChange" id="avatar" type="file" 
          accept="image/jpeg, image/png, image/jpg, image/gif, image/svg+xml"
          class="mt-2 block w-full text-sm text-gray-500
                 file:mr-4 file:py-2 file:px-4
                 file:rounded-md file:border-0
                 file:text-sm file:font-semibold
                 file:bg-blue-50 file:text-blue-700
                 hover:file:bg-blue-100" />
        </div>
        <div class="grid grid-cols-1 md:grid-cols-1 gap-1">
        <input-text label="Name" v-model="newClient.name" :required="true" :error="!!errors.name"
        :errorMessage="errors.name"/>        
        <input-text label="Email" v-model="newClient.email" :required="true" :error="!!errors.email"
        :errorMessage="errors.email"/>        
        </div>                               
        <!-- Step 2: Location Details -->        
        <div class="grid grid-cols-1 md:grid-cols-1 gap-1">
        <input-text label="City" v-model="newClient.city" :required="true" :error="!!errors.city"
        :errorMessage="errors.city"/>
        <input-text label="State" v-model="newClient.state" :required="true" :error="!!errors.state"
        :errorMessage="errors.state"/>
        <select-option label="Country" :options="countries" v-model="newClient.country" :required="true" :error="!!errors.country"
        :errorMessage="errors.country"/>
        <input-text label="Current Location (City)" v-model="newClient.currentLocation" :required="true" :error="!!errors.currentLocation"
        :errorMessage="errors.currentLocation"/>
        </div>   
        <!-- Step 3: Personal Information -->        
        <div class="grid grid-cols-1 md:grid-cols-1 gap-1">
        <input-text label="Age" v-model="newClient.age" :required="true" :error="!!errors.age"
        :errorMessage="errors.age"/>
        <input-text label="Hair Color" v-model="newClient.hairColor" :required="true" :error="!!errors.hairColor"
        :errorMessage="errors.hairColor"/>
        <select-option label="Body Type" :options="bodyTypes" v-model="newClient.bodytype" :required="true"/>
        <div class="flex gap-4">
            <input-text label="Height (Feet)" v-model="newClient.heightFeet" :required="true" :error="!!errors.heightFeet"
            :errorMessage="errors.heightFeet"/>
            <input-text label="Inches" v-model="newClient.heightInches" :required="true" :error="!!errors.heightInches"
            :errorMessage="errors.heightInches"/>
        </div>
        </div>
        <!-- Step 4: Lifestyle Information -->        
        <div class="grid grid-cols-1 md:grid-cols-1 gap-1">
        <select-option label="Marital Status" :options="maritalStatuses" v-model="newClient.maritalStatus" :required="true"/>
        <select-option label="Children" :options="childrenOptions" v-model="newClient.children" :required="true"/>
        <select-option label="Religion" :options="religions" v-model="newClient.religion" :required="true"/>
        <select-option label="Smoker" :options="yesNoOptions" v-model="newClient.smoker" :required="true"/>
        <select-option label="Drinker" :options="drinkerOptions" v-model="newClient.drinker" :required="true"/>
        </div>
        <!-- Step 5: Professional and Hobbies -->        
        <div class="grid grid-cols-1 md:grid-cols-1 gap-1">
        <input-text label="Education" v-model="newClient.education" :required="true" :error="!!errors.education"
        :errorMessage="errors.education"/>
        <input-text label="Job Title" v-model="newClient.jobTitle" :required="true" :error="!!errors.jobTitle"
        :errorMessage="errors.jobTitle"/>
        <input-text label="Sports" v-model="newClient.sports" :required="true" :error="!!errors.sports" :errorMessage="errors.sports"/>
        <input-text label="Hobbies" v-model="newClient.hobbies" :required="true" :error="!!errors.hobbies"
        :errorMessage="errors.hobbies"/>
        </div>
        <div class="grid grid-cols-1 md:grid-cols-2 gap-4 mt-4">
        <select-option label="English Level" :options="englishLevels" v-model="newClient.englishLevel" :required="true" :error="!!errors.englishLevel"
        :errorMessage="errors.englishLevel"/>
        <input-text label="Languages" v-model="newClient.languages" :required="true" :error="!!errors.languages"
        :errorMessage="errors.languages"/>
        </div>              

        <button          
          class="bg-connectyed-button-light hover:bg-connectyed-button-hover-light text-connectyed-button-hover-light hover:text-connectyed-button-hover-dark py-2 px-4 rounded float-right"
          type="submit"
          :disabled="processing"
          @click="addClient"
          >
          {{ processing ? "Please wait" : "Save" }}
          </button>
          
      </form>
            
    </div>

    <!-- List of Clients -->
    <div v-if="clients.length > 0">
      <h3 class="text-xl font-semibold mb-4">Clients List</h3>
      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        <div
          v-for="client in clients"
          :key="client.id"
          class="p-4 bg-gray-100 rounded-lg shadow-md flex items-start"
        >
          <!-- Client Image -->
          <img
            :src="(client.avatar) ? client.avatar : '/upload/images/profiles/default.png'"
            alt="Client Profile"
            class="w-24 h-24 rounded-full object-cover mr-4"
          />

          <!-- Client Details -->
          <div>
            <h4 class="text-lg font-bold">
              <router-link :to="'/' + client.user.username">
                {{ client.user.name }}
              </router-link>              
            </h4>
            <p class="text-gray-500 text-sm">Age: {{ client.age }}</p>
            <p class="text-gray-500 text-sm">Location: {{ client.location }}</p>
            <p class="text-orange-500 text-sm py-2 cursor-pointer" @click="editClient(client.id)">Edit</p>
          </div>
        </div>
      </div>
    </div>

    <!-- No Clients Message -->
    <div v-else class="mt-10 text-gray-500">No clients added yet.</div>
  </div>
</template>

<script>

import InputText from '../../components/InputText.vue';
import SelectOption from '../../components/SelectOption.vue';


export default {
  name:"matchmakerclient",
  components: {
    InputText,
    SelectOption    
  },
  data() {
    return {      
      processing: false,
      showAddClientForm: false, 
      user: this.$store.state.auth.user.user,
      authorization: this.$store.state.auth.authorization,      
      newClient: {
        userId: "",
        isUpdating: false,
        name: "",        
        email: "",        
        city: "",
        state: "",
        country: "",
        currentLocation: "",
        age: "",
        hairColor: "",
        bodytype: "",
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
        avatar: null
      },
      errors: {
        userId: "",
        isUpdating: false,
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
        hairColor: '',
        bodytype: '',
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
        avatar: null
      },      
      clients: [], 
      countries: ['United States of America', 'Canada'],
      bodyTypes: ['Slender', 'Average', 'Athletic', 'Curvy', 'Big and Beautiful'],
      maritalStatuses: ['Single', 'Separated', 'Divorced'],
      childrenOptions: ['0', '1', '2', '3', '4'],
      religions: ['Buddhism', 'Catholic', 'Christian', 'Confucianism', 'Hinduism', 'Islam', 'Jainism', 'Judaism', 'Shinto', 'Sikhism', 'Taoism', 'Zoroastrianism', 'Other'],
      yesNoOptions: ['Yes', 'No'],
      drinkerOptions: ['None', 'Occasionally', 'Often'],
      englishLevels: ['Beginner', 'Intermediate', 'Proficient'],
      successMessage: '',
      validationErrors: {},
      preview: null,
      file: null,
    };
  },
  methods: {
    onFileChange(event) {
      const file = event.target.files[0];
      this.newClient.avatar = file;      
      if (file) {
        this.preview = URL.createObjectURL(file);
        this.file = file;
      } else {
        this.preview = null;
        this.file = null;
      }
    },
    async addClient() {            
      this.processing = true
      const profile = this.newClient               
        axios.defaults.headers.common.Authorization = `Bearer ${this.authorization.token}`            
      await axios.post('/api/matchmaker/clients', profile, {
        headers: {
            'Content-Type': 'multipart/form-data'
        }
        })
        .then(({ data }) => {                         
            if (data.success) {                            
              alert('Profile updated successfully');
              this.showAddClientForm = false
              this.getClient();
            } else {              
              this.validationErrors = data.data
            }          
          }).catch(({ response }) => {          
            if(response.data.success===false){
                this.validationErrors = response.data.errors
            }else{
                this.validationErrors = {}                                
            }
        }).finally(()=>{
            this.processing = false
        })
    },
    async getClient() {            
      this.processing = true
      const matchmakerId = this.user.id
      const profile = this.newClient        
        await axios.get('/api/matchmaker/clients/'+matchmakerId)
        .then(({ data }) => {                            
          this.clients = data.data            
        }).catch((error)=>{
            console.error(error);
        }).finally(()=>{
            this.processing = false
        })
    },
    async editClient(id) {
      this.showAddClientForm = !this.showAddClientForm
      let selectedProfile = this.clients.find(client => client.id === id)      
      this.newClient = selectedProfile
      this.newClient.isUpdating = true
      this.newClient.userId = selectedProfile.user_id
      this.newClient.children = selectedProfile.children.toString()
      this.newClient.name = selectedProfile.user.name
      this.newClient.email = selectedProfile.user.email
      this.newClient.currentLocation = selectedProfile.location
      this.newClient.hairColor = selectedProfile.haircolor
      this.newClient.heightFeet = selectedProfile.height
      this.newClient.heightInches = selectedProfile.inches
      this.newClient.jobTitle = selectedProfile.jobtitle
      this.newClient.englishLevel = selectedProfile.english
      this.preview = selectedProfile.avatar      
    }  
  },
  created() {
    this.getClient();
  }
};
</script>