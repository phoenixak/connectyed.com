<template>
  <!-- ================> Banner section start here <================== -->
	<div class="banner banner--style2 padding-top bg_img">
		<div class="container">
			<div class="banner__wrapper">
				<div class="row g-0 justify-content-center">
					<div class="col-lg-4 col-12">
						<div class="banner__content wow fadeInLeft" data-wow-duration="1.5s">
							<div class="banner__title">
								<h2>Find Your Perfect Match.</h2>
								<p>At Connectyed, we understand the challenges of finding meaningful connections in a busy world. Our mission is to make your search for the perfect match as effortless and rewarding as possible.</p>
								<a href="#">
									<span>
										<router-link :to="{name:'register'}" class="bg-connectyed-button-light text-connectyed-button-dark hover:bg-connectyed-button-hover-light hover:text-connectyed-button-light py-4 px-5">
											Free matchmaking until 9/15
										</router-link>
									</span></a>
							</div>
						</div>
					</div>
					<div class="col-lg-8 col-12">
						<div class="banner__thumb wow fadeInUp" data-wow-duration="1.5s">
							<img src="assets/images/banner/ct01.png" alt="banner">
							<div class="banner__thumb--shape">
								<div class="shapeimg shapeimg__one">
									<img src="assets/images/banner/shape/home2/01.png" alt="dating thumb">
								</div>
								<div class="shapeimg shapeimg__two">
									<img src="assets/images/banner/shape/home2/02.png" alt="dating thumb">
								</div>
								<div class="shapeimg shapeimg__three">
									<img src="assets/images/banner/shape/home2/03.png" alt="dating thumb">
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
    <!-- ================> Banner section end here <================== -->


	<!-- ================> Story section start here <================== -->
	<div class="story bg_img padding-top padding-bottom">
		<div class="container">
			<div class="section__header style-2 text-center wow fadeInUp" data-wow-duration="1.5s">				
				
			</div>
			<div class="section__wrapper">
				<div class="row g-4 justify-content-center row-cols-lg-3 row-cols-sm-2 row-cols-1">
					<div class="col wow fadeInUp" data-wow-duration="1.5s" v-for="(post, index) in featuredPosts.data" :key="index">
						<div class="story__item">
							<div class="story__inner">
								<div class="story__thumb">
									<a v-bind:href="post.slug"><img :src="post.image" alt="dating thumb"></a>									
								</div>
								<div class="story__content">
									<a v-bind:href="post.slug" class="text-"><h4 class="h-20">{{ post.title }}</h4></a>							
								</div>
							</div>
						</div>
					</div>
					
				</div>
			</div>
		</div>
	</div>
    <!-- ================> Story section end here <================== -->

	<!-- ================> About section start here <================== -->
	<div class="about padding-top padding-bottom bg_img">
		<div class="container">
			<div class="section__header style-2 text-center wow fadeInUp" data-wow-duration="1.5s">
				<h2>How it Works</h2>
				<p>Comnectyed specializes in matchmaking for busy professionals. We offer a streamlined, personalized approach to help you connect with someone.</p>
			</div>
			<div class="section__wrapper">
				<div class="row g-4 justify-content-center row-cols-xl-4 row-cols-lg-3 row-cols-sm-2 row-cols-1">
					<div class="col wow fadeInUp" data-wow-duration="1.5s">
						<div class="about__item text-center">
							<div class="about__inner">
								<div class="about__thumb flex justify-center">
									<img src="assets/images/about/01.jpg" alt="dating thumb">
								</div>
								<div class="about__content">
									<h4>Choose Your Matchmaker</h4>
									<p>Browse our curated list of qualified matchmakers. each with their own expertise and approach. Select the one who best aligns with your relationship goals and preferences.</p>
								</div>
							</div>
						</div>
					</div>
					<div class="col wow fadeInUp" data-wow-duration="1.6s">
						<div class="about__item text-center">
							<div class="about__inner">
								<div class="about__thumb flex justify-center">
									<img src="assets/images/about/02.jpg" alt="dating thumb">
								</div>
								<div class="about__content">
									<h4>Introduction Session</h4>
									<p>Set up an initial introduction session with your chosen matchmaker. This is vour opportuniy to discuss your relationship goals and get professionai advice on how to navigate the dating world.</p>
								</div>
							</div>
						</div>
					</div>
					<div class="col wow fadeInUp" data-wow-duration="1.7s">
						<div class="about__item text-center">
							<div class="about__inner">
								<div class="about__thumb flex justify-center">
									<img src="assets/images/about/03.jpg" alt="dating thumb">
								</div>
								<div class="about__content">
									<h4>Personalized Matchmaking</h4>
									<p>Based on your criteria, your matchmaker will curate 1-on-1 video dates with targeted singles who meet your specifications. Enjoy meaningful connections from the comfort of your own home.</p>
								</div>
							</div>
						</div>
					</div>
					<div class="col wow fadeInUp" data-wow-duration="1.8s">
						<div class="about__item text-center">
							<div class="about__inner">
								<div class="about__thumb flex justify-center">
									<img src="assets/images/about/04.jpg" alt="dating thumb">
								</div>
								<div class="about__content">
									<h4>Flexible Pricing</h4>
									<p>Prices vary by matchmaker, allowing you to choose a package that fits your needs and budget.</p>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
    <!-- ================> About section end here <================== -->

	<!-- ================> Work section start here <================== -->
	<div class="work work--style2 padding-top padding-bottom bg_img hidden" style="background-image: url(assets/images/bg-img/01.jpg);">
		<div class="container">
			<div class="section__wrapper">
				<div class="row g-4 justify-content-center">
					<div class="col-xl-6 col-lg-8 col-12 wow fadeInLeft" data-wow-duration="1.5s">
						<div class="work__item">
							<div class="work__inner">
								<div class="work__thumb">
									<img src="assets/images/work/09.png" alt="dating thumb">
								</div>
								<div class="work__content">
									<h3>Trust And Safety</h3>
									<p>Choose from one of our membership levels and unlock features you need. </p>
									<a href="policy.html" class="default-btn"><span>See More Details</span></a>
								</div>
							</div>
						</div>
					</div>
					<div class="col-xl-6 col-lg-8 col-12 wow fadeInRight" data-wow-duration="1.5s">
						<div class="work__item">
							<div class="work__inner">
								<div class="work__thumb">
									<img src="assets/images/work/10.png" alt="dating thumb">
								</div>
								<div class="work__content">
									<h3>Simple Membership</h3>
									<p>Choose from one of our membership levels and unlock features you need. </p>
									<a href="membership.html" class="default-btn reverse"><span>Membership Details</span></a>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
    <!-- ================> Work section end here <================== -->

</template>


<script setup>
import { onMounted } from 'vue'
import usePosts from "../composables/posts";

const { featuredPosts, getFeaturedPosts } = usePosts()
onMounted(() => {
	getFeaturedPosts()	
})        
</script>