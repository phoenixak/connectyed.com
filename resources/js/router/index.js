import { createWebHistory, createRouter } from 'vue-router'
import store from '@/store'

/* Guest Component */
const GuestLayout = () => import('@/views/Templates/LayoutGuest.vue')
const Login = () => import('@/views/Login.vue')
const Register = () => import('@/views/Register.vue')
const Home = () => import('@/views/Home.vue')
const BlogDetail = () => import('@/views/BlogDetail.vue')
const ProfileDetail = () => import('@/views/ProfileDetail.vue')
const EmailVerification = () => import('@/components/EmailVerification.vue')
const Unauthorized = () => import('@/views/Unauthorized.vue')

/*Clients*/
const ClientLayout = () => import('@/views/Client/Layout.vue')
const ClientDashboard = () => import('@/views/Client/Dashboard.vue')

/*Matchmaker*/
const MatchmakerLayout = () => import('@/views/Matchmaker/Layout.vue')
const MatchmakerDashboard = () => import('@/views/Matchmaker/Dashboard.vue')
const MatchmakerProfile = () => import('@/views/Matchmaker/Profile.vue')
const MatchmakerSpecialties= () => import('@/views/Matchmaker/Specialties.vue')

/*Admin*/
const AdminLayout = () => import('@/views/Admin/Layout.vue')
const AdminDashboard = () => import('@/views/Admin/Dashboard.vue')


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
        path: "/tips/:slug",
        component: GuestLayout,
        meta: {
            middleware: "guest"
        },
        children: [
            {
                name: "blogdetail",
                path: '/tips/:slug',
                component: BlogDetail,
                meta: {
                    title: `Blog Detail`
                }
            }
        ]
    },
    {
        path: "/:username",
        component: GuestLayout,
        meta: {
            middleware: "guest"
        },
        children: [
            {
                name: "profiledetail",
                path: '/:username',
                component: ProfileDetail,
                meta: {
                    title: `Profile Detail`
                }
            }
        ]
    },
    {
        path: "/admin",
        name: "admin",
        component: AdminLayout,
        meta: {
            middleware: "auth",
            title: "Admin Dashboard",
            role: 'admin'
        },
        children: [
            {
                props: true,     
                name: "admin",
                path: '/admin',
                component: AdminDashboard,
                meta: {
                    title: `Admin Dashboard`
                }
            }
            
        ]
    },
    {
        path: "/matchmaker",
        name: "matchmaker",
        component: MatchmakerLayout,
        meta: {
            middleware: "auth",
            title: "Matchmaker Dashboard",
            role: ['matchmaker', 'candidate']                      
        },
        children: [
            {
                props: true,     
                name: "matchmaker",
                path: '/matchmaker',
                component: MatchmakerDashboard,
                meta: {
                    title: `Matchmaker Dashboard`
                },
                children: [
                    {
                      path: 'specialties', // Will match /dashboard/profile/edit
                      component: MatchmakerSpecialties
                    },
                    {
                      path: 'profile', // Will match /dashboard/profile/view
                      component: MatchmakerProfile
                    }
                  ]

            }            
        ]
    },
    {
        path: "/dashboard",
        name: "dashboard",
        component: ClientLayout,
        meta: {
            middleware: "auth",
            title: "Client Dashboard",            
            role: "client"
        },
        children: [
            {
                props: true,     
                name: "dashboard",
                path: '/dashboard',
                component: ClientDashboard,
                meta: {
                    title: `Client Dashboard`
                }
            }
            
        ]
    },        
    {
        path: "/unauthorized",
        name: "unauthorized",
        component: GuestLayout,
        meta: {
            middleware: "guest",
            title: "Unauthorize",
        },
        children: [
            {
                name: "unauthorized",
                path: '/unauthorized',
                component: Unauthorized,
                meta: {
                    title: `Unauthorized`
                }
            }
        ]       
    },
]

const router = createRouter({
    history: createWebHistory(),
    routes, 
})

router.beforeEach((to, from, next) => { 
    const isAuthenticated = store.getters['auth/authenticated']
    const userRole = store.getters['auth/userRole']       
    // Guest Middleware
    if (to.meta.middleware === 'guest') {
        if (isAuthenticated) {
        // Redirect to the correct dashboard based on role
        if (userRole === 'admin') {
            return next({ name: 'admin' });
        } else if (userRole === 'matchmaker' || userRole === 'candidate') {
            return next({ name: 'matchmaker' });
        } else if (userRole === 'client') {
            return next({ name: 'dashboard' });
        }
        }
        return next();  // Proceed for guest
    }
    
    // Auth Middleware
    if (to.meta.middleware === 'auth') {
        if (!isAuthenticated) {
            return next({ name: 'login' });  // Redirect to login if not authenticated
        }
        // Role-based access control
        if (to.meta.role) {
            if (userRole === to.meta.role || to.meta.role.includes(userRole)) {                
            return next();  // Allow access to route
        } else {
            return next({ name: 'login' });  // Redirect if role doesn't match
        }
        }
    }

  // Proceed to the route if no middleware issues
    next();
    
})

export default router