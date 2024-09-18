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
        <!-- Name -->
        <div class="mb-4">
          <label class="block text-gray-700 font-semibold mb-2">Name</label>
          <input
            v-model="newClient.name"
            type="text"
            placeholder="Enter client's name"
            class="w-full py-2 px-4 text-gray-700 border rounded-lg focus:outline-none focus:ring"
          />
        </div>

        <!-- Email -->
        <div class="mb-4">
          <label class="block text-gray-700 font-semibold mb-2">Email</label>
          <input
            v-model="newClient.email"
            type="email"
            placeholder="Enter client's email"
            class="w-full py-2 px-4 text-gray-700 border rounded-lg focus:outline-none focus:ring"
          />
        </div>

        <!-- Age -->
        <div class="mb-4">
          <label class="block text-gray-700 font-semibold mb-2">Age</label>
          <input
            v-model="newClient.age"
            type="number"
            placeholder="Enter client's age"
            class="w-full py-2 px-4 text-gray-700 border rounded-lg focus:outline-none focus:ring"
          />
        </div>

        <!-- Location -->
        <div class="mb-4">
          <label class="block text-gray-700 font-semibold mb-2">Location</label>
          <input
            v-model="newClient.location"
            type="text"
            placeholder="Enter client's location"
            class="w-full py-2 px-4 text-gray-700 border rounded-lg focus:outline-none focus:ring"
          />
        </div>

        <!-- Profile Picture Upload -->
        <div class="mb-4">
          <label class="block text-gray-700 font-semibold mb-2">Profile Picture</label>
          <input
            type="file"
            @change="handleFileUpload"
            class="w-full py-2 px-4 text-gray-700 border rounded-lg focus:outline-none focus:ring"
          />
        </div>

        <!-- Submit Button -->
        <button
          type="submit"
          class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline"
        >
          Add Client
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
            :src="client.image"
            alt="Client Profile"
            class="w-24 h-24 rounded-full object-cover mr-4"
          />

          <!-- Client Details -->
          <div>
            <h4 class="text-lg font-bold">{{ client.name }}</h4>
            <p class="text-gray-600">{{ client.email }}</p>
            <p class="text-gray-500 text-sm">Age: {{ client.age }}</p>
            <p class="text-gray-500 text-sm">Location: {{ client.location }}</p>
          </div>
        </div>
      </div>
    </div>

    <!-- No Clients Message -->
    <div v-else class="mt-10 text-gray-500">No clients added yet.</div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      showAddClientForm: false, // Controls the visibility of the Add Client form
      newClient: {
        name: '',
        email: '',
        age: null,
        location: '',
        image: null // Holds the uploaded image
      },
      clients: [], // Stores the list of clients
      clientId: 1 // Dummy client ID generator
    };
  },
  methods: {
    // Handles file input for the profile picture
    handleFileUpload(event) {
      const file = event.target.files[0];
      if (file) {
        this.newClient.image = URL.createObjectURL(file); // Generate a preview URL
      }
    },

    // Add new client to the list
    addClient() {
      if (this.newClient.name && this.newClient.email) {
        // Add a new client with a unique ID
        const client = { ...this.newClient, id: this.clientId++ };
        this.clients.push(client);

        // Clear the form after adding the client
        this.newClient = {
          name: '',
          email: '',
          age: null,
          location: '',
          image: null
        };

        this.showAddClientForm = false; // Close the form
      } else {
        alert('Please fill out all required fields');
      }
    }
  }
};
</script>