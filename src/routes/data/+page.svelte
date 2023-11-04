<script>
	import BottomNav from "../../lib/BottomNav.svelte";
	import GreyCard from "../../lib/GreyCard.svelte";

    let rightLink = "/contact";
    let leftLink = "/projects";
</script>

<svelte:head>
  <title>Lewis' portfolio site: data</title> 
</svelte:head>

<div class="overflow-hidden mx-auto p-8 max-w-xl">
  <header>
    <h1 class="text-3xl">Data</h1>
  </header>
  <br />
  <main>
    <article>
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

      <!-- <div>
        <div style={{width: "300px"}}>
          <VisitorsGraph />
        </div>
        <p class="m-0 text-gray-400 text-lg">Countries of unique visitors to this site<br />(via my Golang API → <s>Kafka</s> → Timescale)</p>
      </div> -->
    </article>
  </main>
  <footer>
    <BottomNav leftLink={leftLink} rightLink={rightLink} />
  </footer>
</div>