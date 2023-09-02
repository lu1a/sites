<script>
  import Arrow from "../components/Arrow.svelte";
  import SwipeWrapper from "../components/SwipeWrapper.svelte";

  let leftLink = "/contact";
  let rightLink = "/about";
</script>

<SwipeWrapper leftLink={leftLink} rightLink={rightLink}>
  <h1>Lewis Torrington</h1>
  <Arrow direction="left" link={leftLink}/>
  <Arrow direction="right" link={rightLink}/>
  
  <p>Work in progress 👷</p>
</SwipeWrapper>
