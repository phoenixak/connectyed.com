<template>
  <div class="max-w-4xl mx-auto p-6 bg-white rounded-sm shadow-sm">

    <h2 class="text-2xl font-semibold mb-4">Matchmaker Specialties</h2>

    <!-- Age Range Inputs -->
    <form class="w-full" action="javascript:void(0)" @submit="postSpecialties" method="put">
      <div class="mb-4">
        <label for="age-range" class="block uppercase font-bold text-xs  text-gray-700 mb-2">
          My Clients are between the ages of
        </label>
        <div class="flex space-x-2">
          <input
            type="number"
            v-model="specialties.minage"
            class="w-full p-2 border border-gray-300 rounded-md"
            placeholder="Min Age"
            min="18"
            id="minage"
          />
          <input
            type="number"
            v-model="specialties.maxage"
            class="w-full p-2 border border-gray-300 rounded-md"
            placeholder="Max Age"
            min="18"
            id="maxage"
          />
        </div>
      </div>

      <!-- Gender Select Option -->
      <div class="mb-6">
        <label for="gender" class="block uppercase font-bold text-xs  text-gray-700 mb-2">
          My Clients are
        </label>
        <select
          v-model="specialties.gender"
          class="w-full p-2 border border-gray-300 rounded-md"
          id="gender"
        >
          <option value="male">Male</option>
          <option value="female">Female</option>
          <option value="male_female">Male & Female</option>
        </select>
      </div>    
      <!-- Tags for selected locations -->
      <div class="flex flex-wrap mb-2">
        <label for="locations" class="block uppercase w-full font-bold text-xs  text-gray-700">
          My Clients are from the following locations (Select up to 5 locations)
        </label>
        <span
          v-for="(location, index) in selectedLocations"
          :key="location.id"
          class="bg-blue-500 text-white rounded-full px-4 py-1 mr-2 mb-2 flex items-center"
        >
          {{ location.name }}
          <button
            @click="removeLocation(index)"
            class="ml-2 text-white hover:text-red-400"
          >
            &times;
          </button>
        </span>
      </div>

      <!-- Searchable Dropdown for selecting new locations -->
      <div class="relative mb-4">
        <input
          type="text"
          v-model="searchQuery"
          placeholder="Search for locations..."
          class="block w-full p-2 border border-gray-300 rounded-lg focus:ring focus:ring-blue-200 focus:outline-none"
        />
        <ul
          v-if="filteredLocations.length && searchQuery.length > 0"
          class="absolute z-10 bg-white border border-gray-300 w-full rounded-lg mt-1 max-h-60 overflow-y-auto"
        >
          <li
            v-for="location in filteredLocations"
            :key="location.id"
            @click="addLocation(location)"
            class="p-2 hover:bg-gray-200 cursor-pointer"
          >
            {{ location.name }}
          </li>
        </ul>
      </div>

      <!-- Submit Button -->
      <div class="flex items-center justify-end">
        <button
          class="bg-connectyed-button-light text-connectyed-button-dark hover:bg-connectyed-button-hover hover:text-connectyed-button font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline"
          type="submit"
        >
          Save
        </button>
      </div>
    </form>

  </div>
</template>

<script>
import locationsData from './Locations.json';

export default {
  data() {
    return {
      specialties: {
        minage: '',
        maxage: '',
        gender: '',
        locations: []
      },
      searchQuery: '',
      selectedLocations: [],
      authorization:this.$store.state.auth.authorization,
      locations: locationsData
    };
  },
  mounted() {      
    this.getSpecialties();        
  },
  computed: {
    filteredLocations() {
      // Filter locations based on search query, excluding already selected ones
      return this.locations.filter(
        location =>
          location.name.toLowerCase().includes(this.searchQuery.toLowerCase()) &&
          !this.selectedLocations.includes(location)
      );
    }
  },
  methods: {
    async postSpecialties() {                   
        this.processing = true
        this.specialties.locations = this.selectedLocations
        const formData = this.specialties
        axios.defaults.headers.common.Authorization = `Bearer ${this.authorization.token}`         
        await axios.put('/api/specialties/update', {                
          specialties: formData          
        })
        .then(({data})=>{                
            alert('Specialties updated successfully');
        }).catch((error)=>{
            console.error(error);
        }).finally(()=>{
            this.processing = false
        })
    },  
    async getSpecialties() {
        this.processing = true
        axios.defaults.headers.common.Authorization = `Bearer ${this.authorization.token}` 
        await axios.get('/api/specialties/getspecialties')
          .then((response) => {
            if (response.data.data) {                
                this.specialties = response.data.data                            
                this.selectedLocations = (response.data.data.locations) ? JSON.parse(response.data.data.locations) : []
            }
        }).catch((error)=>{
          console.error(error);
          this.selectedLocations = []
        }).finally(()=>{
            this.processing = false
        })
    },
    addLocation(location) {
      // Add the selected location to selectedLocations and reset search query
      if (!this.selectedLocations.includes(location)) {
        this.selectedLocations.push(location);
        this.searchQuery = '';
      }      
    },
    removeLocation(index) {
      // Remove location from selectedLocations
      this.selectedLocations.splice(index, 1);
    }
  }
};
</script>

<style scoped>
/* Optional: Style for dropdown items and hover effect */
</style>
