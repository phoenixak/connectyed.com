import { createStore } from 'vuex'
import createPersistedState from 'vuex-persistedstate'
import auth from '@/store/auth'
import post from '@/store/post'

const store = createStore({
    plugins:[
        createPersistedState()
    ],
    modules:{
        auth,
        post
    }
})

export default store