import{_ as c,y as i,e as r,f as t,t as o,p as l,o as d}from"./app-D0Fdxhbm.js";const p={name:"postdetail",data(){return{postId:0,csrf:document.querySelector('meta[name="csrf-token"]').getAttribute("content"),post:{},posts:{},postUrl:"",liked:!1,user:this.$store.state.auth.user,authorization:this.$store.state.auth.authorization}},async created(){const a=this.$route.params.slug;await axios.get("/api/post/".concat(a)).then(({data:e})=>{this.posts=e.data}).catch(function(e){console.error(e)})},computed(){},methods:{...i({toDetail:"/"})}},_={class:"mx-auto max-w-7xl py-6 sm:px-6 lg:px-8 items-center justify-center"},u={class:"bg-connectyed-body-light mx-full"},h={class:"mx-full shadow-connectyed rounded-xl bg-white border border-gray-200 flex flex-col py-5 px-5 mb-5"},m={class:"flex text-xs items-end"},x={time:"",datetime:"posts.created_at",class:"text-gray-500 float-end"},f={class:"group relative"},g={class:"text-3xl font-semibold leading-6 text-gray-900 group-hover:text-gray-600"},y={class:"my-3 text-sm leading-6"},b={class:"font-semibold text-gray-900"},v={href:"#"},k=t("span",{class:"inset-0"},null,-1),w=["innerHTML"];function B(a,n,e,$,s,D){return d(),r("div",_,[t("div",u,[t("article",h,[t("div",m,[t("time",x,o(),1)]),t("div",f,[t("h2",g,o(s.posts.title),1),t("div",y,[t("p",b,[t("a",v,[k,l(" "+o(s.posts.name),1)])])]),t("div",{class:"text-xl my-5 text-justify",innerHTML:s.posts.content},null,8,w)])])])])}const j=c(p,[["render",B]]);export{j as default};
