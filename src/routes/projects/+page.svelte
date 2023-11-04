<script>
	import BottomNav from "../../lib/BottomNav.svelte";
	import GreyCard from "../../lib/GreyCard.svelte";

    const rightLink = "/data";
    const leftLink = "/about";
</script>

<div class="overflow-hidden mx-auto p-8 max-w-xl">
  <header>
    <h1 class="text-3xl">Some projects</h1>
  </header>
  <br />
  <main>
    <article>
      <GreyCard>
        <p class="m-0">
          <a
            class="underline"
            href="https://github.com/lu1a/cosmas-api"
            target="_blank"
          >
            COSMAS
          </a>
          <br />
          An API in Rust to allow for an automated social peer-to-peer sharing system.
          <br />
          Designed for my future farm in mind. 🧑‍🌾🌾
        </p>
      </GreyCard>
      <br />

      <GreyCard>
        <p class="m-0">
          <a
            class="underline"
            href="https://github.com/lu1a/kasu"
            target="_blank"
          >
            KASU
          </a>
          <br />
          A little script for installing Kubernetes on a blank Ubuntu machine!
          <br />
          Either for becoming a control plane or worker node.
        </p>
      </GreyCard>
      <br />

      <p class="m-0 text-gray-400 text-lg">
        <i>...and more! Though not that much more that I wanna show publicly.
        Check out my GitHub anyhow if you&apos;re interested.</i></p>
    </article>
  </main>
  <footer>
    <BottomNav leftLink={leftLink} rightLink={rightLink} />
  </footer>
</div>