<script>
  import SwipeWrapper from "../components/SwipeWrapper.svelte";

  let leftLink = "/contact";
  let rightLink = "/about";
</script>

<style>
  .name-title {
    font-weight: bolder;
    font-size: 5rem;

    margin: 0;
  }

  .image-card {
    border-radius: 4px;
  }

  .image-headshot {
    width: 10rem;
    height: 10rem;

    margin-left: 2rem;
  }
</style>

<SwipeWrapper leftLink={leftLink} rightLink={rightLink}>
  <h1 class="name-title">Lewis Torrington</h1>
  <br />
  <img
    class="image-card image-headshot"
    src="/images/lewis-headshot.png"
    alt="A headshot of me"
  />
  
  <p>Work in progress 👷</p>
  <p>Swipe to see more..</p>
</SwipeWrapper>
