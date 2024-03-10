<template>
  <header class="container mx-auto flex items-center justify-center gap-32 py-4">
    <a href="/" class="flex items-center">
      <img
          src="https://firebasestorage.googleapis.com/v0/b/helping-nexus.appspot.com/o/assets%2Flogo_header_v2.png?alt=media"
          alt="HelpingNexus Logo" class="w-36"
      >
    </a>
    <button class="font-bold" @click="scrollTo('partners')">
      Partners
    </button>
    <button class="font-bold" @click="scrollTo('taipy-analytics')">
      Analytics
    </button>
    <button class="bg-[#7e5bf6] hover:bg-[#b7a4fa] text-white font-bold py-2 px-4 rounded-md">
      Try Now!
    </button>
  </header>
</template>

<script setup>

const scrollTo = (elementId) => {
  const element = document.getElementById(elementId);
  element.scrollIntoView({ behavior: "smooth", block: "start", inline: "nearest" });
  // also add a hash to the URL
  setTimeout(() => {
    window.location.hash = elementId;
  }, 500);
};
</script>