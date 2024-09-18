<template>
    <div class="mb-2">
      <label class="block text-gray-700 text-sm font-bold mb-2">{{ label }}</label>
      <select
        class="block w-full bg-white border border-gray-300 rounded-md py-2 px-3 shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"
        :value="modelValue"
        @change="$emit('update:modelValue', $event.target.value)"
        :required="required"
        :class="{'border-red-500': error}"
      >
        <option value="" disabled>Select {{ label }}</option>
        <option v-for="option in options" :key="option" :value="option">
          {{ option }}
        </option>
      </select>
    </div>
  </template>
  
  <script>
  export default {
    name: 'SelectOption',
    props: {
      label: {
        type: String,
        required: true
      },
      options: {
        type: Array,
        required: true
      },
      modelValue: {
        type: String,
        required: false
      },
        required: {
            type: Boolean,
            default: false // Required prop, defaults to false
        },
        error: {
            type: Boolean, // New prop to indicate if there is an error
            default: false
        },
        errorMessage: {
            type: String, // Prop for displaying the error message
            default: ''
        }
    },
  };
  </script>
  
  <style scoped>
  /* Additional custom styles can be added here if needed */
  </style>
  