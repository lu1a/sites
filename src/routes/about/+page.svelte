<script>

  import Arrow from "../../components/Arrow.svelte";
  import SwipeWrapper from "../../components/SwipeWrapper.svelte";

  let leftLink = "/";
  let rightLink = "/contact";
</script>

<SwipeWrapper leftLink={leftLink} rightLink={rightLink}>
  <h1>About</h1>
  <Arrow direction="left" link={leftLink}/>
  <Arrow direction="right" link={rightLink}/>

  <div>
  Hello, my name is Lewis Torrington and this is my page.
  <br />
  About me:
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
  <br />
  <div>
  <b>GitHub:</b>
  <a
      style="color: white"
      href="https://github.com/lu1a"
      target="_blank"
      >https://github.com/lu1a</a
  >
  </div>
  <div>
  LinkedIn:
  <a
      style="color: white"
      href="https://www.linkedin.com/in/lewis-torrington/"
      target="_blank"
      >https://www.linkedin.com/in/lewis-torrington</a
  >
  </div>
  <div>
  Instead of a CV, just go look at my LinkedIn. :P
  </div>
  <br />
  <div>
  Countries of unique visitors to this site (via my Golang API -> kakfa -> Timescale):
  <ol>
      <li>Finland: 79%</li>
      <li>Australia: 16%</li>
      <li>Germany: 4%</li>
      <li><i>Other: 1%</i></li>
  </ol>
  </div>
  <br />
  <div>
  Ping me if you want me to contribute to your git project!
  </div>
  <br />
  <div>
  Note: This site was written in Svelte by me. You can find the
  <a
      style="color: white"
      href="https://github.com/lu1a/portfolio-site"
      target="_blank"
      >source code</a
  >
  on my GitHub. As you'll be able to see there, I have no code for
  cookies or other nasties.
  </div>
</SwipeWrapper>
