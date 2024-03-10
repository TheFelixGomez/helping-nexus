<template>
  <main class="scroll-smooth">
    <section class="flex items-center justify-center w-full bg-center bg-cover snap-start bg-home-1">
      <img alt="" title=""
           src="https://firebasestorage.googleapis.com/v0/b/helping-nexus.appspot.com/o/assets%2Fhelp1.webp?alt=media"
           class="opacity-50 z-10">
    </section>
    <section class="flex items-center justify-center w-full h-screen snap-start">
      <div class="grid grid-flow-row grid-cols-12 grid-rows-1">
        <div class="z-10 flex flex-col justify-center col-span-3 col-start-2 row-start-1 ">
          <h1 class="font-black text-purple ">About HelpingNex.us</h1>
          <h3 class="text-pink">Try to match with the help you want to make!</h3>
        </div>
        <div class="flex flex-col items-end col-span-6 col-start-3 row-start-1 z-0">
          <img
              src="https://firebasestorage.googleapis.com/v0/b/helping-nexus.appspot.com/o/assets%2Fhelp4.webp?alt=media"
              class="animate-jump opacity-40" alt=""/>
          <a href="/about" class="mt-2 text-xs underline">Find out more &rarr;</a>
        </div>
      </div>
    </section>
    <section class="flex items-center justify-center w-full h-screen text-white bg-purple snap-start">
      <div class="grid grid-flow-row grid-cols-12 grid-rows-1 gap-8">
        <div class="col-span-5 col-start-2">
          <img
              src="https://firebasestorage.googleapis.com/v0/b/helping-nexus.appspot.com/o/assets%2Fhelp3.webp?alt=media"
              alt="help 3 image"/>
        </div>
        <div class="flex flex-col justify-center col-span-3 col-start-8 z-10 text-black">
          <h2>We're a non-profit app</h2>
          <p>We want you to match with local and global volunteers..</p>
          <a href="#" class="mt-2 text-xs underline">Read more &rarr;</a>
        </div>
      </div>
    </section>

    <div id="taipy-analytics" class="w-full h-0.5"></div>
    <embed src="https://helpingnexus.taipy.cloud/" class="mx-auto h-full" style="width:100%; height: 700px;">
  </main>
</template>

<script setup>
</script>