<script>
    import BottomNav from "../../lib/BottomNav.svelte";

    const leftLink = "/data";
</script>

<main class="overflow-hidden mx-auto p-8 max-w-xl">
    <h1 class="text-3xl">Contact</h1>
    <br />
    <div class="flex justify-center mt-72">
      <a href="https://www.linkedin.com/in/lewis-torrington/">
        <button class="bg-blue-700 w-40 h-12 text-blue-300 rounded-md font-semibold text-lg font-sans">Get in touch</button>
      </a>
    </div>

    <BottomNav leftLink={leftLink} rightLink={null} />
</main>