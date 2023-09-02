<script>

  import Arrow from "../../components/Arrow.svelte";
  import SwipeWrapper from "../../components/SwipeWrapper.svelte";

  let leftLink = "/about";
  let rightLink = "/";
</script>

<SwipeWrapper leftLink={leftLink} rightLink={rightLink}>
  <h1>Contact</h1>
  <Arrow direction="left" link={leftLink}/>
  <Arrow direction="right" link={rightLink}/>

  <p>Work in progress 👷</p>
</SwipeWrapper>
