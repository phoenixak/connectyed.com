<template>
  
    <!-- ================> header section start here <================== -->
    <header class="header" id="navbar">
        <div class="header__top d-none d-lg-block">
			<div class="container">
				<div class="header__top--area">
					<div class="header__top--left">
						<ul>
                            <li>
                                <i class="fa-solid fa-phone"></i> <span>+800-123-4567 6587</span>
                            </li>
                            <li>
                                <i class="fa-solid fa-location-dot"></i> Beverley, New York 224 USA
                            </li>
                        </ul>
					</div>
					<div class="header__top--right">
						<ul>
                            <li><a href="#"><i class="fa-brands fa-facebook-f"></i> Facebook</a></li>
                            <li><a href="#"><i class="fa-brands fa-instagram"></i> Instagram</a></li>
                            <li><a href="#"><i class="fa-brands fa-youtube"></i> Youtube</a></li>
                        </ul>
					</div>
				</div>
			</div>
		</div>
		<div class="header__bottom">
			<div class="container">
				<nav class="navbar navbar-expand-lg">
					<a class="navbar-brand" href="index.html"><h2>Connectyed</h2></a>
					<button class="navbar-toggler collapsed" type="button" data-bs-toggle="collapse"
						data-bs-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false"
						aria-label="Toggle navigation">
						<span class="navbar-toggler--icon"></span>
					</button>
					<div class="navbar-collapse justify-content-end" id="navbarNavAltMarkup">
						<div class="navbar-nav mainmenu">
							<ul>
								<li>
									<a href="#">
                    <router-link :to="{name:'home'}" class="nav-link">Home</router-link>
                  </a>									
								</li>								
								<li>
                  <a href="#">
                    <router-link :to="{name:'home'}" class="nav-link">Blogs</router-link>
                  </a>									
								</li>
								<li>
									<a href="#">
                    <router-link :to="{name:'home'}" class="nav-link">Shops</router-link>
                  </a>									
								</li>
                <li v-if="!!user.name">
									<a href="#">
                    <router-link :to="{name:'dashboard'}" class="nav-link">Dashboard</router-link>
                  </a>									
								</li>																
							</ul>
						</div>
						<div class="header__more">
              <button class="btn" type="button" v-if="currentRouteName=='login'">
                <router-link :to="{name:'register'}" class="bg-connectyed-button-light text-white p-3">Register</router-link>
              </button>                          
              <button class="btn"type="button" v-else-if="currentRouteName=='register' || !user.name">
                <router-link :to="{name:'login'}" class="bg-connectyed-button-light text-white p-3">Login</router-link>
              </button>
            
              <button class="bg-connectyed-button-light text-white  default-btn" type="button" v-if="!!user.name">Logout</button>
						</div>
					</div>
				</nav>
			</div>
		</div>
    </header>
    <!-- ================> header section end here <================== -->
    <main>      
        <router-view></router-view>      
    </main>
  

    <!-- ================> Footer section start here <================== -->
	<footer class="footer footer--style2">
		<div class="footer__top bg_img">
			<div class="footer__newsletter wow fadeInUp" data-wow-duration="1.5s">
				<div class="container">
					<div class="row g-4 justify-content-center">
						<div class="col-lg-6 col-12">
							<div class="footer__newsletter--area">
								<div class="footer__newsletter--title">
									<h4>Newsletter Sign up</h4>
								</div>
								<div class="footer__newsletter--form">
									<form action="#">
										<input type="email" placeholder="Your email address">
										<button type="submit" class="default-btn"><span>Subscribe</span></button>
									</form>
								</div>
							</div>
						</div>
						<div class="col-lg-6 col-12">
							<div class="footer__newsletter--area justify-content-xxl-end">
								<div class="footer__newsletter--title me-xl-4">
									<h4>Join Community</h4>
								</div>
								<div class="footer__newsletter--social">
									<ul>
										<li><a href="#"><i class="fa-brands fa-twitter"></i></a></li>
										<li><a href="#"><i class="fa-brands fa-twitch"></i></a></li>
										<li><a href="#"><i class="fa-brands fa-instagram"></i></a></li>
										<li><a href="#"><i class="fa-brands fa-dribbble"></i></a></li>
										<li><a href="#"><i class="fa-brands fa-facebook-messenger"></i></a></li>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="footer__toparea padding-top padding-bottom wow fadeInUp" data-wow-duration="1.5s">
				<div class="container">
					<div class="row g-4">
						<div class="col-lg-3 col-sm-6 col-12">
							<div class="footer__item footer--about">
								<div class="footer__inner">
									<div class="footer__content">
										<div class="footer__content--title">
											<h4>About Connectyed</h4>
										</div>
										<div class="footer__content--desc">
											<p>Connectyed is a matchmaking platform that connects people with ideal partners using advanced technology and expert matchmakers. Whether for friendship, love, or networking, we offer a trusted and easy-to-use service.</p>
										</div>
										<div class="footer__content--info">
											<p><b>Address :</b> 3rd Floor Tropical Building Elephant Road 1205</p>
                    						<p><b>Contact :</b> connectyed.com</p>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="footer__bottom wow fadeInUp" data-wow-duration="1.5s">
			<div class="container">
				<div class="footer__content text-center">
					<p class="mb-0">All Rights Reserved &copy; <a href="index.html">Connectyed</a> || Design By: Connectyed</p>
				</div>
			</div>
		</div>
	</footer>
    <!-- ================> Footer section end here <================== -->
</template>

<script setup>
import { reactive, computed } from 'vue'
import { Disclosure, DisclosureButton, DisclosurePanel, Menu, MenuButton, MenuItem, MenuItems } from '@headlessui/vue'
import { Bars3Icon, BellIcon, XMarkIcon } from '@heroicons/vue/24/outline'
import { useStore } from 'vuex'
import { useRouter, useRoute } from 'vue-router'

const store = useStore();
const router = useRouter();
const route = useRoute();
const currentRouteName = computed(() => route.name)
const auth = reactive(store.state.auth)
const user = auth.user
  
const logout = async () => {  
  const token = auth.authorization.token

  await axios.post('/api/user/logout').then(({data})=>{
    axios.defaults.headers.common.Authorization = `Bearer ${token}`
    store.dispatch('auth/logout')
    router.push({name:"home"})                  
  }).catch((error) => {
    console.error(error)
    store.dispatch('auth/logout')
    router.push({name:"home"}) 
  }) 
}
</script>