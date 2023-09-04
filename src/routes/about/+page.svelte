<script>
  import SwipeWrapper from "../../components/SwipeWrapper.svelte"

  let leftLink = "/"
  let rightLink = "/data"

</script>

<SwipeWrapper leftLink={leftLink} rightLink={rightLink}>
  <div style="padding: 1rem;">
    <h1>About me</h1>

    <div>
      <ul style="margin: 0; padding-inline-start: 20px">
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
          <li>Most interested in: Data science, Rust</li>
          <li>Current specialties: Go, Python, C++, JS/TS</li>
        </ul>
      </ul>
    </div>
    <p>
      <a
        style="color: white"
        href="https://github.com/lu1a"
        target="_blank"
      >
          My GitHub
      </a>
      <br />
      <a
        style="color: white"
        href="https://www.linkedin.com/in/lewis-torrington/"
        target="_blank"
      >
        My LinkedIn
      </a>
    </p>
    <div>
      Instead of a CV, just go look at my LinkedIn. 😇
    </div>
    <br />
    <div>
      Ping me if you want me to contribute to your git project!
    </div>
  </div>
</SwipeWrapper>
