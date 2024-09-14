<template>
    <div>
        <h1>Unauthorized</h1>
        <p>You don't have permission to view this page.</p>
        <router-link to="/">Go back to home</router-link>
    </div>
</template>

<script>
    export default {
        name: 'Unauthorized',
    };
</script>