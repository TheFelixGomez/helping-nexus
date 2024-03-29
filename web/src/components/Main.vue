<template>
  <main>
    <div class="flex items-center justify-center w-full h-screen relative">
      <img alt="People helping image"
           src="https://firebasestorage.googleapis.com/v0/b/helping-nexus.appspot.com/o/assets%2Fhelp1.webp?alt=media"
           class="opacity-50 h-full w-full object-cover">
      <div class="absolute bg-[#b7a4fa] rounded-2xl px-4 py-8 lg:p-10 mx-4 w-auto lg:w-3/4 lg:mx-auto">
        <h1 class="text-5xl lg:text-6xl font-bold text-center">
          Matchmaking for Good:<br class="block lg:hidden">
          <span class="text-3xl lg:text-6xl">
            Swipe Right for Volunteering!
          </span>
        </h1>
      </div>
    </div>

    <section id="wip" class="px-4 lg:px-32 flex flex-col items-center justify-center gap-32 w-full h-screen">
      <h2 class="text-6xl font-bold text-center">
        Work In Progress
      </h2>
      <p class="text-xl w-full lg:w-1/2 text-center">
        Our goal is to create a platform that connects volunteers with NGOs.<br><br>
        We are looking for contributors to help us with the development of the platform.
        If you are interested in helping, please visit our GitHub repository.
      </p>
      <a href="https://github.com/TheFelixGomez/helping-nexus" target="_blank"
         rel="nofollow noopener noreferrer"
         class="bg-[#7e5bf6] hover:bg-[#b7a4fa] text-white text-xl font-bold py-4 px-6 rounded-2xl">
        Help Now
      </a>
    </section>

    <Carousel/>
  </main>
</template>

<script setup>
import Carousel from "./Carousel.vue";
</script>