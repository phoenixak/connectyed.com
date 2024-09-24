import axios from 'axios'
import router from '@/router'

export default {
    namespaced: true,
    state:{
        authenticated:false,
        user:{},
        authorization:{},
        userRole: null,
    },
    getters:{
        authenticated(state){
            return state.authenticated
        },
        user(state){
            return state.user
        },
        userRole: (state) => state.userRole,
    },
    mutations:{
        SET_AUTHENTICATED (state, value) {
            state.authenticated = value
        },
        SET_USER (state, value) {
            state.user = value
            state.userRole = value.role
        },
        SET_TOKEN (state, value) {
            state.authorization = value
        },
        CLEAR_USER(state) {
            state.user = null
            state.userRole = null
        },
        SET_USER_ROLE (state, value) {
            state.userRole = value
        },
    },
    actions:{
        login({commit}){ 
            return axios.post('/api/user/refresh').then(({ data }) => {                     
                //const localUser = JSON.parse(localStorage.getItem('user'));
                localStorage.removeItem("user")
                localStorage.setItem("user", JSON.stringify(data)) 
                const localUser = JSON.parse(localStorage.getItem('user'))                
                commit('SET_USER', localUser.data)
                commit('SET_AUTHENTICATED',true)
                commit('SET_TOKEN', localUser.authorization)
                commit('SET_USER_ROLE', localUser.data.user.role)   
                console.log("localUser.data.user.role", localUser.data.user.role)
                if (localUser.data.user.role === 'admin') {
                    router.push({ path: 'admin/dashboard' });
                } else if (localUser.data.user.role === 'matchmaker') {
                    router.push({ path: 'matchmaker/dashboard' });                        
                } else if (localUser.data.user.role === 'candidate') {
                    router.push({ path: 'matchmaker/dashboard' });
                } else if (localUser.data.user.role === 'client') {                       
                    router.push({ path: 'client/dashboard' });                        
                }
                //router.push({name:'dashboard'})
            }).catch((response)=>{
                commit('SET_USER',{})
                commit('SET_AUTHENTICATED',false)
                commit('SET_TOKEN',{})
            })
        },
        logout({commit}){
            commit('SET_USER',{})
            commit('SET_AUTHENTICATED',false)
            commit('SET_TOKEN',{})
            commit('CLEAR_USER', {})
            commit('SET_USER_ROLE', {})
            localStorage.removeItem("user")
            localStorage.removeItem("vuex")
        }
    }
}