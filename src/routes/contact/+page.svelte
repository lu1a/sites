<script>
    import BottomNav from "../../lib/BottomNav.svelte";

    const leftLink = "/data";
</script>

<div class="overflow-hidden mx-auto p-8 max-w-xl">
  <header>
    <h1 class="text-3xl">Contact</h1>
  </header>
  <br />
  <main>
    <div class="flex justify-center mt-72">
      <a href="https://www.linkedin.com/in/lewis-torrington/">
        <button class="animate-ping absolute inline-flex w-52 h-16 rounded-full bg-blue-600 opacity-60" aria-hidden="true"></button>
        <button class="bg-blue-700 w-52 h-16 text-blue-300 rounded-md font-semibold text-2xl font-sans">
          <span>Get in touch</span>
        </button>
      </a>
    </div>
  </main>
  <footer>
    <BottomNav leftLink={leftLink} rightLink={null} />
  </footer>
</div>