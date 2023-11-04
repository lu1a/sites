<script>
	import BottomNav from "../lib/BottomNav.svelte";
	import GlassCard from "../lib/GlassCard.svelte";

    let rightLink = "/about";
</script>

<svelte:head>
  <title>Lewis' portfolio site: home</title> 
</svelte:head>

<main class="overflow-hidden mx-auto p-8 max-w-xl">
  <img
    class="rounded-full m-0 w-40 h-40"
    src="/lewis-headshot.png"
    alt="A headshot of Lewis"
    aria-hidden="true"
  />

  <aside class="animate-bounce" style="margin-top: -3rem; margin-left: 8rem;" aria-hidden="true">
    <GlassCard>
      <p class="m-0">
        <span style="display: inline-block; transform: rotate(45deg);">👈</span>
        &nbsp;me!
      </p>
    </GlassCard>
  </aside>

  <article>
    <h1 class="text-6xl m-0">Lewis Torrington</h1>

    <p class="text-gray-400 text-lg mt-5">
        Hello, my name is Lewis and this is my page.
        In this iteration of my site, I&apos;m focusing entirely 
        mobile-first because my stats
        tell me that almost every non-bot who visited here 
        has been on a phone!
    </p>
  </article>

</main>
<footer>
  <BottomNav leftLink={null} rightLink={rightLink} />
</footer>