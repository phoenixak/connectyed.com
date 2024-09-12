import { createWebHistory, createRouter } from 'vue-router'
import store from '@/store'

/*Templates*/
const TemplateLayout = () => import('@/views/Templates/Layout.vue')
const GuestLayout = () => import('@/views/Templates/LayoutGuest.vue')

/*Pages*/
const Dashboard = () => import('@/views/Dashboard.vue')

/* Guest Component */
const Login = () => import('@/views/Login.vue')
const Register = () => import('@/views/Register.vue')
const Home = () => import('@/views/Home.vue')
const BlogDetail = () => import('@/views/BlogDetail.vue')
/* Guest Component */
const EmailVerification = () => import('@/components/EmailVerification.vue')

const routes = [
    {
        path: '/email/verify',
        name: '',
        component: GuestLayout,
        meta: {
            middleware: "guest"
        },        
        children: [
            {
                name: "EmailVerification",
                path: '/email/verify',
                component: EmailVerification,
                props: true,
                meta: {
                    title: `EmailVerification`
                },
                props: route => ({
                    verificationUrl: route.query.verification_url
                }),
            }
        ]
    },
    {
        path: "/",
        component: GuestLayout,
        meta: {
            middleware: "guest"
        },
        children: [
            {
                name: "home",
                path: '/',
                component: Home,
                props: true,
                meta: {
                    title: `Home`
                }
            }
        ]
    },
    {
        path: "/login",
        component: GuestLayout,
        meta: {
            middleware: "guest"
        },
        children: [
            {
                name: "login",
                path: '/login',
                component: Login,
                meta: {
                    title: `Login`
                }
            }
        ]
    },
    {
        path: "/register",
        component: GuestLayout,
        meta: {
            middleware: "guest"
        },
        children: [
            {
                name: "register",
                path: '/register',
                component: Register,
                meta: {
                    title: `Register`
                }
            }
        ]
    },
    {
        path: "/dashboard",
        component: TemplateLayout,
        meta: {
            middleware: "auth"
        },
        children: [
            {
                name: "dashboard",
                path: '/dashboard',
                component: Dashboard,
                props: true,
                meta: {
                    title: `Dashboard`
                }
            }
        ]
    },   
    {
        path: "/:slug",
        component: GuestLayout,
        meta: {
            middleware: "guest"
        },
        children: [
            {
                name: "blogdetail",
                path: '/:slug',
                component: BlogDetail,
                meta: {
                    title: `Blog Detail`
                }
            }
        ]
    }
]

const router = createRouter({
    history: createWebHistory(),
    routes, 
})

router.beforeEach((to, from, next) => {
    if (to.name !== 'login' && !store.state.auth.authenticated) {
        if (to.meta.middleware === "guest") {
            next()    
        } else {
            next({ name: 'login' })   
        }        
    } else {
        next()
    }
})

export default router