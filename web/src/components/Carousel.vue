<template>
  <main  class="max-h-screen overflow-y-scroll snap snap-y snap-mandatory">
    <section class="flex items-center justify-center w-full h-screen bg-center bg-cover snap-start bg-home-1">
      <img alt="" title="" src="https://firebasestorage.googleapis.com/v0/b/helping-nexus.appspot.com/o/assets%2Fhelp1.webp?alt=media" class="opacity-50 z-10">
    </section>
    <section class="flex items-center justify-center w-full h-screen snap-start">
      <div class="grid grid-flow-row grid-cols-12 grid-rows-1">
        <div class="z-10 flex flex-col justify-center col-span-3 col-start-2 row-start-1 ">
          <h1 class="font-black text-purple ">About The Helpingnex.us</h1>
          <h3 class="text-pink">Try to match with th e help you want to make!</h3>
        </div>
        <div class="flex flex-col items-end col-span-6 col-start-3 row-start-1 z-0">
          <img src="https://firebasestorage.googleapis.com/v0/b/helping-nexus.appspot.com/o/assets%2Fhelp4.webp?alt=media"  class="animate-jump opacity-40" alt=""/>
          <a href="/about" class="mt-2 text-xs underline">Find out more &rarr;</a>
        </div>
      </div>
    </section>
    <section class="flex items-center justify-center w-full h-screen text-white bg-purple snap-start">
      <div class="grid grid-flow-row grid-cols-12 grid-rows-1 gap-8">
        <div class="col-span-5 col-start-2">
          <img src="https://firebasestorage.googleapis.com/v0/b/helping-nexus.appspot.com/o/assets%2Fhelp3.webp?alt=media" alt="help 3 image" />
        </div>
        <div class="flex flex-col justify-center col-span-3 col-start-8 z-10 text-black">
          <h2>We're a non-profit app</h2>
          <p>We want you to match with local and global volunteers..</p>
          <a href="#" class="mt-2 text-xs underline">Read more &rarr;</a>
        </div>
      </div>
    </section>
    <section class="flex items-center w-full h-screen bg-indigo-200 bg-center bg-cover text-purple snap-start">
      <div class="w-1/12">&nbsp;</div>
      <div class="w-3/12 px-11">
        <div class="relative font-bold"><span class="absolute flex w-full h-0.5 -ml-4 bg-purple -left-full top-1/2 "></span>About us</div>
        <a href="#">
          <h2>Like the offers that match your preferences</h2>
          <p>The biggest, best-known and most prestigious NGOs are here to match with you.</p>
        </a>
        <a href="#" class="mt-2 text-xs underline">Read more &rarr;</a>
      </div>
      <div class="w-full inline-flex flex-nowrap overflow-hidden [mask-image:_linear-gradient(to_right,transparent_0,_black_128px,_black_calc(100%-128px),transparent_100%)]">
        <ul class="flex items-center justify-center md:justify-start [&_li]:mx-8 [&_img]:max-w-none animate-infinite-scroll">
          <template v-for="logo in logos">
            <li>
              <img :src="logo.src" :alt="logo.alt" />
            </li>
          </template>
        </ul>
        <ul class="flex items-center justify-center md:justify-start [&_li]:mx-8 [&_img]:max-w-none animate-infinite-scroll" aria-hidden="true">
          <template v-for="logo in logos">
            <li>
              <img :src="logo.src" :alt="logo.alt" />
            </li>
          </template>
        </ul>
      </div>
    </section>
  </main>
</template>

<script setup lang="ts">
import Care from '../assets/care-1.svg'
import AguilasGuadalupanas from '../assets/logo-aguilas-guadalupanas.svg'
import OMSEurope from '../assets/oms-europe.svg'
import SaveTheChildren from '../assets/save-the-children-3.svg'
import SaveTheDolphins from '../assets/save-the-dolphins.svg'
import Unicef from '../assets/unicef-3.svg'
import WWF from '../assets/wwf.svg'

const logos = [
  { src: Care, alt: 'Care' },
  { src: AguilasGuadalupanas, alt: 'AguilasGuadalupanas' },
  { src: OMSEurope, alt: 'OMSEurope' },
  { src: SaveTheChildren, alt: 'SaveTheChildren' },
  { src: SaveTheDolphins, alt: 'SaveTheDolphins' },
  { src: Unicef, alt: 'Unicef' },
  { src: WWF, alt: 'WWF' },
]
</script>