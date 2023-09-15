<script lang="ts">
  import GreyCard from "../../components/GreyCard.svelte";
  import BottomNav from "../../components/BottomNav.svelte";
  import MobileWrapper from "../../components/MobileWrapper.svelte";

  let leftLink = "/";
  let rightLink = "/data";

</script>

<MobileWrapper>
  <h1>About me</h1>
  <GreyCard>
    <ul class="no-bullets">
      <li>From Australia; living in Finland since 2019.</li>
      <li>
      BCompSc (m.: Cyber Security),
      <a
        style="color: white"
        href="https://www.uow.edu.au/"
        target="_blank"
        >UoW</a
      >, 2016-2018.
      </li>
      <li>
      Working at
      <a
        style="color: white"
        href="https://www.upcloud.com/"
        target="_blank"
        >UpCloud</a
      >.
      </li>
      <li>Software engineer:</li>
      <ul>
        <li>Most interested in: Data science</li>
        <li>Current lang specialties: Go, Python, JS/TS</li>
      </ul>
    </ul>
  </GreyCard>
  <br />
  <GreyCard>
    <p>
      Instead of a CV, just go look at 
      <a
        style="color: white"
        href="https://www.linkedin.com/in/lewis-torrington/"
        target="_blank"
      >
        My LinkedIn
      </a>. 😇
      <br />
      Ping me if you want me to contribute to your git project!
      (<a
          style="color: white"
          href="https://github.com/lu1a"
          target="_blank"
        >
            My GitHub
        </a>)
    </p>
  </GreyCard>

  <BottomNav leftLink={leftLink} rightLink={rightLink} />
</MobileWrapper>

<style>
  p, ul {
    margin: 0;
  }

  .no-bullets {
    list-style-type: none;
    padding: 0;
    margin: 0;
  }
</style>
