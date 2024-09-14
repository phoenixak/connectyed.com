import { createStore } from 'vuex'
import createPersistedState from 'vuex-persistedstate'
import auth from './auth'

const store = createStore({
    modules:{
        auth       
    },
    plugins: [
        createPersistedState({
            storage: window.localStorage,           
        }),
    ],
})

export default store