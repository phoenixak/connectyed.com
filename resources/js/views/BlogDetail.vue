<template>
    <div class="mx-auto max-w-7xl py-6 sm:px-6 lg:px-8 items-center justify-center">
        <div class="bg-connectyed-body-light mx-full">                                             
            <article class="mx-full shadow-connectyed rounded-xl bg-white border border-gray-200 flex flex-col py-5 px-5 mb-5">
                <div class="flex text-xs items-end">
                    <time time datetime="posts.created_at" class="text-gray-500 float-end">{{  }}</time>
                </div>
                <div class="group relative">
                    <h2 class="my-5 text-3xl font-semibold leading-6 text-gray-900 group-hover:text-gray-600">                        
                        {{ posts.title }}                        
                    </h2>                    
                    <div class="my-5 text-sm leading-6">
                        <p class="font-semibold text-gray-900">
                        <a href="#">
                            <span class="absolute inset-0"></span>
                            {{ posts.name }}
                        </a>
                        <span class="text-gray-600 px-3">({{ (posts.role==="admin") ? "Administrator" : "Users" }})</span>
                        </p>                        
                    </div>
                    <div class="form-control text-xl my-5 text-justify" v-html="posts.content"></div>                                                  
                </div>   
                <div class="col-md-2 offset-md-10" v-if="!!user.name">
                    <form @submit.prevent="submit" action="javascript:void(0)" @submit="postLike(posts.id)" class="row" method="post" 
                    v-if="!liked">
                        <input type="hidden" name="_token" :value="csrf">
                        <button type="submit" class="bg-connectyed-button-dark hover:bg-connectyed-button-light text-connectyed-text-light font-bold py-1 px-4 rounded-r float-end rounded-sm">Like</button>
                    </form>
                    <form @submit.prevent="submit" action="javascript:void(0)" @submit="postUnLike(posts.id)" class="row" method="post"
                    v-if="liked">
                        <input type="hidden" name="_token" :value="csrf">
                        <button type="submit" class="bg-connectyed-button-dark hover:bg-connectyed-button-light text-connectyed-text-light font-bold py-1 px-4 rounded-r float-end rounded-sm">Liked</button>
                    </form>
                </div>
                <div class="col-md-2 offset-md-10" v-if="!!!user.name">                    
                    <a class="bg-connectyed-button-dark hover:bg-connectyed-button-light text-connectyed-text-light font-bold py-1 px-4 rounded-r float-end rounded-sm"><router-link :to="{name:'login'}">Like</router-link></a>
                </div>                 
            </article>         
            
            <div v-for="(comment, index) in comments" :key="index" class="flex mx-auto items-end justify-center shadow-lg mb-4 max-w-2xl">
                <div class="w-full max-w-2xl bg-white rounded-lg px-4 pt-2">
                    <div class="flex flex-wrap -mx-3 mb-6">
                        <h2 class="px-4 pt-3 pb-2 text-gray-800 text-lg">{{ comment.name }}</h2>
                        <div class="w-full md:w-full px-3 m-2 mt-2">
                            {{ comment.body }}
                        </div>
                        <div class="w-full md:w-full flex items-start md:w-full px-3">
                            <div class="items-start w-1/2 text-gray-700 px-2 mr-auto">        
                            <p class="text-xs md:text-sm pt-px">{{ comment.date }}
                            </p>                            
                            </div>
                        </div>                            
                        <div class="w-full md:w-full items-end justify-end flex items-start md:w-full px-3">
                            <div class="float-end">
                                <form action="javascript:void(0)" @submit="commentLike(comment.id)" class="row" method="post" v-if="!comment.is_liked==1">
                                    <input type="hidden" name="_token" :value="csrf">
                                    <button type="submit" class="bg-connectyed-button-dark hover:bg-connectyed-button-light text-connectyed-text-light font-bold py-1 px-4 rounded-r float-end rounded-sm">Like</button>
                                </form>
                                <form action="javascript:void(0)" @submit="commentUnLike(comment.id)" class="row" method="post"
                                v-if="comment.is_liked==1">
                                    <input type="hidden" name="_token" :value="csrf">
                                    <button type="submit" class="bg-connectyed-button-dark hover:bg-connectyed-button-light text-connectyed-text-light font-bold py-1 px-4 rounded-r float-end rounded-sm">Liked</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>                            
            
            <div class="flex mx-auto items-end justify-center shadow-lg mb-4 max-w-2xl">
                <form action="javascript:void(0)" @submit="postComment" method="post" class="w-full max-w-2xl bg-white rounded-lg px-4 pt-2" name="frmcomment" id="frmcomment">
                    <div class="flex flex-wrap -mx-3 mb-6">
                        <h2 class="w-full text-center px-4 pt-3 pb-2 text-gray-800 text-lg">Add a new comment</h2>

                        <a v-if="!!!user.name" class="w-full text-center bg-connectyed-button-white hover:bg-connectyed-button-dark hover:text-connectyed-text-light text-connectyed-text-dark font-bold py-1 px-4 rounded-r float-end rounded-sm"><router-link :to="{name:'login'}">Login to comment</router-link></a>

                        <div v-if="!!user.name" class="w-full md:w-full px-3 mb-2 mt-2">
                            <textarea class="bg-gray-100 rounded border border-gray-400 leading-normal resize-none w-full h-20 py-2 px-3 font-medium placeholder-gray-700 focus:outline-none focus:bg-white" placeholder='Type Your Comment' required v-model="newcomment.body" name="body" id="body"></textarea>
                        </div>
                                                                                   
                        <div class="w-full md:w-full flex items-start md:w-full px-3" v-if="!!user.name">
                            
                            <div class="flex items-start w-1/2 text-gray-700 px-2 mr-auto">
                            <svg fill="none" class="w-5 h-5 text-gray-600 mr-1" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                            </svg>
                            <p class="text-xs md:text-sm pt-px">Some HTML is okay.</p>
                            </div>
                            <div class="-mr-1">
                            <input type='submit' class="bg-white text-gray-700 font-medium py-1 px-4 border border-gray-400 rounded-lg tracking-wide mr-1 hover:bg-gray-100" value='Post Comment'>
                            </div>
                        </div>
                    </div>
                </form>
            </div>                            
            
        </div>
    </div>
</template>
  
<script>
import { mapActions, useStore } from 'vuex'
import usePosts from "../composables/posts";


export default {
    name:'postdetail',
    data() {
        return {
            postId: 0,
            csrf: document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
            post: {},
            posts: {},
            comments:{},
            newcomment:{
                body:"",
                post_id:"",
            },
            postLikeData: {
                id: null,
                _token: document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
            },
            postUrl: "",
            liked: false,
            user:this.$store.state.auth.user,
            authorization:this.$store.state.auth.authorization
        }
    },
    async created() {
        const slug = this.$route.params.slug
        let url = "/api/post/"
        await axios.get(url.concat(slug)).then(({data})=>{
            this.posts = data.data            
            this.newcomment.post_id = data.data.id
            this.postLikeData.id = data.data.id
            this.postId = data.data.id
        })
        .catch(function (error) {
           console.error(error);
        });

        this.fetchComment()
        this.isLike()
    },
    computed() {
    },
    methods: {
        ...mapActions({
            toDetail:"/"
        }),
        async postComment(){
            this.processing = true
            axios.defaults.headers.common.Authorization = `Bearer ${this.authorization.token}`
            await axios.post('/api/comment',this.newcomment).then(({data})=>{
                this.validationErrors = {}
                this.newcomment.body = ""
                this.fetchComment()
            }).catch((error)=>{
                console.error(error);
            }).finally(()=>{
                this.processing = false
            })
        },
        async postLike(){
            this.processing = true
            axios.defaults.headers.common.Authorization = `Bearer ${this.authorization.token}`
            this.postUrl = "/api/post/like"
            await axios.post(this.postUrl, this.postLikeData).then(({data})=>{
                this.validationErrors = {}
                this.liked = !this.liked
            }).catch((error)=>{
                console.error(error);
            }).finally(()=>{
                this.processing = false
            })
        },
        async postUnLike(){
            this.processing = true
            axios.defaults.headers.common.Authorization = `Bearer ${this.authorization.token}`
            this.postUrl = "/api/post/unlike"
            await axios.post(this.postUrl, this.postLikeData).then(({data})=>{
                this.validationErrors = {}
                this.liked = !this.liked
            }).catch((error)=>{
                console.error(error);
            }).finally(()=>{
                this.processing = false
            })
        },
        async isLike(){
            this.processing = true
            axios.defaults.headers.common.Authorization = `Bearer ${this.authorization.token}`
            this.postUrl = "/api/post/islike"
            await axios.post(this.postUrl, this.postLikeData).then(({data})=>{
                this.validationErrors = {}
                this.liked = data.data ? !!data.data.is_liked : false
            }).catch((error)=>{
                console.error(error);
            }).finally(()=>{
                this.processing = false
            })
        },
        async fetchComment(){
            this.processing = true
            this.postUrl = "/api/comment/islike"
            axios.defaults.headers.common.Authorization = `Bearer ${this.authorization.token}`
            await axios.post(this.postUrl, this.postLikeData).then(({data})=>{
                this.validationErrors = {}
                this.comments = data.data.data                
            }).catch((error)=>{
                console.error(error);
            }).finally(()=>{
                this.processing = false
            })
        },
        async commentLike(commentId){
            this.processing = true
            axios.defaults.headers.common.Authorization = `Bearer ${this.authorization.token}`
            this.postUrl = "/api/comment/like"
            const commentData = {
                id: commentId,
            }
            await axios.post(this.postUrl, commentData).then(({data})=>{
                this.validationErrors = {}
                this.fetchComment()
            }).catch((error)=>{
                console.error(error);
            }).finally(()=>{
                this.processing = false
            })
        },
        async commentUnLike(commentId){
            this.processing = true
            axios.defaults.headers.common.Authorization = `Bearer ${this.authorization.token}`
            this.postUrl = "/api/comments/unlike"
            const commentData = {
                id: commentId,
            }
            await axios.post(this.postUrl, commentData).then(({data})=>{
                this.validationErrors = {}
                this.fetchComment()
            }).catch((error)=>{
                console.error(error);
            }).finally(()=>{
                this.processing = false
            })
        },
    }
} 
</script>