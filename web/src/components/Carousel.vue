<template>
  <section id="partners" class="px-4 lg:px-32 flex flex-col items-center justify-center gap-32 w-full h-screen bg-indigo-200">
    <h2 class="text-6xl font-bold text-center">
      Our Partners<br>
      <span class="text-base italic text-center">*desired partners</span>
    </h2>
    <p class="text-xl w-full lg:w-1/2 text-center">
      Like the offers that match your preferences
      The biggest, best-known and most prestigious NGOs are here to match with you.
    </p>
    <div
        class="w-full lg:w-3/4 inline-flex flex-nowrap overflow-hidden [mask-image:_linear-gradient(to_right,transparent_0,_black_128px,_black_calc(100%-128px),transparent_100%)]">
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