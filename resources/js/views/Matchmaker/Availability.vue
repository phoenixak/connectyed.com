<template>
    <div class="min-h-screen bg-gray-100 p-6">
      <div class="max-w-7xl mx-auto bg-white shadow-lg rounded-lg p-8">
        <h2 class="text-3xl font-semibold mb-6">Set Your Availability</h2>
  
        <!-- VueCal Calendar -->
        <vue-cal
          v-model="events"
          :time="true"
          default-view="week"
          :on-event-click="editEvent"
          @cell-click="addEvent"
          class="bg-white border rounded-lg shadow-sm"
          style="height: 600px;"
        ></vue-cal>
  
        <!-- Add/Edit Event Modal -->
        <div v-if="showModal" class="fixed inset-0 z-50 overflow-auto bg-smoke-light flex">
          <div class="relative p-8 bg-white w-full max-w-md m-auto flex-col flex rounded-lg">
            <h3 class="text-2xl font-semibold mb-4">{{ modalAction }} Availability</h3>
  
            <!-- Event Title -->
            <label class="block text-sm mb-2">Availability Description</label>
            <input
              type="text"
              v-model="currentEvent.title"
              class="block w-full p-2 border rounded-lg mb-4"
              placeholder="Enter description (e.g., 'Available for consultations')"
            />
  
            <!-- Event Time (Start/End) -->
            <label class="block text-sm mb-2">Start Time</label>
            <input
              type="datetime-local"
              v-model="currentEvent.start"
              class="block w-full p-2 border rounded-lg mb-4"
            />
  
            <label class="block text-sm mb-2">End Time</label>
            <input
              type="datetime-local"
              v-model="currentEvent.end"
              class="block w-full p-2 border rounded-lg mb-4"
            />
  
            <!-- Modal Buttons -->
            <div class="flex justify-end space-x-2">
              <button @click="saveEvent" class="bg-blue-500 text-white px-4 py-2 rounded-lg">
                Save
              </button>
              <button @click="cancelEvent" class="bg-gray-300 px-4 py-2 rounded-lg">
                Cancel
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </template>
  
  <script>
  import VueCal from 'vue-cal';
  import 'vue-cal/dist/vuecal.css';
  
  export default {
    components: {
      VueCal
    },
    data() {
      return {
        events: [], // Array to store availability events
        showModal: false, // Boolean to show or hide modal
        modalAction: 'Add', // Tracks whether the modal is adding or editing
        currentEvent: {
          id: null,
          title: '',
          start: '',
          end: ''
        }
      };
    },
    methods: {
      // Add new availability event
      addEvent({ date }) {
        this.showModal = true;
        this.modalAction = 'Add';
        this.currentEvent = { title: '', start: date, end: date };
      },
  
      // Edit existing availability event
      editEvent(event) {
        this.showModal = true;
        this.modalAction = 'Edit';
        this.currentEvent = { ...event };
      },
  
      // Save event (add or edit)
      saveEvent() {
        if (this.modalAction === 'Add') {
          this.currentEvent.id = Math.random().toString(36).substr(2, 9); // Generate a unique ID
          this.events.push(this.currentEvent); // Add event to the array
        } else {
          const index = this.events.findIndex(e => e.id === this.currentEvent.id);
          if (index !== -1) {
            this.events.splice(index, 1, this.currentEvent); // Edit event
          }
        }
        this.showModal = false;
      },
  
      // Cancel event action
      cancelEvent() {
        this.showModal = false;
      }
    }
  };
  </script>
  
  <style scoped>
  .bg-smoke-light {
    background-color: rgba(0, 0, 0, 0.5);
  }
  </style>
  