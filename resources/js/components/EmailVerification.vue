<template>  
  <div class="mx-auto max-w-7xl py-6 sm:px-6 lg:px-8 items-center justify-center">
      <div class="mx-full shadow-connectyed rounded-xl bg-connectyed-card-light flex flex-col py-5 px-5 mb-5"> 
        <div class="card-body">    
          <p v-if="loading">Verifying your email...</p>
          <p v-if="message">{{ message }}</p>
        </div>
      </div>
  </div>
</template>

<script>
export default {
  props: ['verificationUrl'],
  data() {
    return {
      loading: true,
      message: ''
    };
  },
  mounted() {    
    this.verifyEmail();
  },
  methods: {
    async verifyEmail() {
      try {
        console.log("VERIfying")
        console.log(this.verificationUrl);
        const response = await fetch(this.verificationUrl);

        if (response.ok) {
          this.message = 'Your email has been successfully verified!';
          setTimeout(() => {
              this.$router.push({ name: "login" });
          }, 1500);
        } else {
          this.message = 'Failed to verify your email. Please try again.';
        }
      } catch (error) {
        this.message = 'An error occurred while verifying your email.';
      } finally {
        this.loading = false;
      }
    }
  }
};
</script>