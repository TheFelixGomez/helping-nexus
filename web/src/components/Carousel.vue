<template>
    <section class="flex items-center w-full h-screen bg-indigo-200 bg-center bg-cover text-purple snap-start">
      <div class="w-1/12">&nbsp;</div>
      <div class="w-3/12 px-11">
        <div class="relative font-bold"><span
            class="absolute flex w-full h-0.5 -ml-4 bg-purple -left-full top-1/2 "></span>About us
        </div>
        <a href="#">
          <h2>Like the offers that match your preferences</h2>
          <p>The biggest, best-known and most prestigious NGOs are here to match with you.</p>
        </a>
        <a href="#" class="mt-2 text-xs underline">Read more &rarr;</a>
      </div>
      <div
          class="w-full inline-flex flex-nowrap overflow-hidden [mask-image:_linear-gradient(to_right,transparent_0,_black_128px,_black_calc(100%-128px),transparent_100%)]">
        <ul class="flex items-center justify-center md:justify-start [&_li]:mx-8 [&_img]:max-w-none animate-infinite-scroll">
          <template v-for="logo in logos">
            <li>
              <img :src="logo.src" :alt="logo.alt"/>
            </li>
          </template>
        </ul>
        <ul class="flex items-center justify-center md:justify-start [&_li]:mx-8 [&_img]:max-w-none animate-infinite-scroll"
            aria-hidden="true">
          <template v-for="logo in logos">
            <li>
              <img :src="logo.src" :alt="logo.alt"/>
            </li>
          </template>
        </ul>
      </div>
    </section>
</template>

<script setup>
import Care from '../assets/care-1.svg'
import AguilasGuadalupanas from '../assets/logo-aguilas-guadalupanas.svg'
import OMSEurope from '../assets/oms-europe.svg'
import SaveTheChildren from '../assets/save-the-children-3.svg'
import SaveTheDolphins from '../assets/save-the-dolphins.svg'
import Unicef from '../assets/unicef-3.svg'
import WWF from '../assets/wwf.svg'

const logos = [
  {src: Care, alt: 'Care'},
  {src: AguilasGuadalupanas, alt: 'AguilasGuadalupanas'},
  {src: OMSEurope, alt: 'OMSEurope'},
  {src: SaveTheChildren, alt: 'SaveTheChildren'},
  {src: SaveTheDolphins, alt: 'SaveTheDolphins'},
  {src: Unicef, alt: 'Unicef'},
  {src: WWF, alt: 'WWF'},
]
</script>