<script>
	import GlassCard from "../lib/GlassCard.svelte";
	import GreyCard from "../lib/GreyCard.svelte";

</script>

<svelte:head>
  <title>Lewis' portfolio site</title> 
</svelte:head>

<main class="overflow-hidden mx-auto p-8 max-w-2xl">
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

    <p class="text-gray-400 text-lg mt-5 hidden">
      This is an audio-only test intro for anyone listening.
      Hello, my name is Lewis and this is my page.
      In this iteration of my site, I&apos;m focusing entirely 
      mobile-first because my stats
      tell me that almost every non-bot who visited here 
      has been on a phone!
    </p>

    <p class="text-gray-400 text-lg mt-5" aria-hidden="true">
        Hello, my name is Lewis and this is my page.
        In this iteration of my site, I&apos;m focusing entirely 
        mobile-first because my stats
        tell me that almost every non-bot who visited here 
        has been on a phone!
    </p>

    <br /><br /><br />

    <h2 class="text-3xl">About me</h2>
    <br />
    <GreyCard>
      <ul class="list-none">
        <li>From Australia; living in Finland since 2019.</li>
        <li>
          Working at&nbsp;
          <a
            class="underline"
            href="https://www.upcloud.com/"
            target="_blank"
            >UpCloud</a>.
        </li>
        <li>Software engineer:</li>
        <ul class="list-disc ml-4">
          <li>Specialties: cloud backend, data engineering</li>
          <li>Best langs right now: Go, Python, JS/TS</li>
          <li>Getting better at: data science, k8s</li>
        </ul>
        <li class="mt-2">
        BCompSc (m.: Cyber Security),&nbsp;
        <a
          class="underline"
          href="https://www.uow.edu.au/"
          target="_blank"
          >UoW</a>, 2016-2018.
        </li>
      </ul>
    </GreyCard>
    <br />
    <GreyCard>
      <p>
        Instead of a CV, just go look at my&nbsp;
        <a
          class="underline"
          href="https://www.linkedin.com/in/lewis-torrington/"
          target="_blank"
        >
          LinkedIn</a>. 😇
        <br />
        Ping me if you want me to contribute to your git project!
        (<a
          class="underline"
          href="https://github.com/lu1a"
          target="_blank"
        >
          My GitHub</a>.)
      </p>
    </GreyCard>

    <br /><br /><br />

    <h2 class="text-3xl">Some projects</h2>
    <br />
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

    <br /><br /><br />

    <h2 class="text-3xl">Data</h2>
    <br />
    <GreyCard>
      <p class="m-0">This site was written in Svelte by me.<br />You can find the&nbsp;
        <a
          class="underline"
          href="https://github.com/lu1a/portfolio-site"
          target="_blank"
        >
          source code
        </a>
        &nbsp;on my GitHub.<br />As you&apos;ll be able to see there, I have no code for
        cookies or nasty things - though I do log my visitors to a TimeScale instance for fun.
        The only fruitful thing that&apos;s gotten me so far is the knowledge of how many
        US-based bots there are out there.
      </p>
    </GreyCard>

    <br />

    <p class="m-0 text-gray-400 text-lg">
      <i>// TODO: link here to a beautiful grafana page about my website stats!</i></p>


    <div class="flex justify-center mt-48">
      <a href="https://www.linkedin.com/in/lewis-torrington/">
        <button class="animate-ping absolute inline-flex w-52 h-16 rounded-full bg-blue-600 opacity-60" aria-hidden="true"></button>
        <button class="bg-blue-700 w-52 h-16 text-blue-300 rounded-md font-semibold text-2xl font-sans">
          <span>Get in touch</span>
        </button>
      </a>
    </div>

  </article>
</main>
