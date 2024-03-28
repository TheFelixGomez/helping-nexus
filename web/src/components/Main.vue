<template>
  <main>
    <div class="flex items-center justify-center w-full">
      <img alt="People helping image"
           src="https://firebasestorage.googleapis.com/v0/b/helping-nexus.appspot.com/o/assets%2Fhelp1.webp?alt=media"
           class="opacity-50 z-10 relative">
      <div class="absolute z-20 font-bold bg-[#b7a4fa] rounded-md font-serif lg:text-4xl lg:p-10">
        <h1>Matchmaking for Good: Swipe Right for Volunteering!</h1>
      </div>
    </div>

    <section id="wip" class="px-32 flex flex-col items-center justify-center gap-32 w-full h-screen">
      <h2 class="text-6xl font-bold">
        Work In Progress
      </h2>
      <p class="text-xl w-1/2 text-center">
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