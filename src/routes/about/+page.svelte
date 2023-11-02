<script>
    import GreyCard from "../../lib/GreyCard.svelte";
    import BottomNav from "../../lib/BottomNav.svelte";

    const rightLink = "/projects";
    const leftLink = "/";
</script>

<main class="overflow-hidden mx-auto p-8 max-w-xl">
    <h1 class="text-3xl">About me</h1>
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

    <BottomNav leftLink={leftLink} rightLink={rightLink} />
</main>