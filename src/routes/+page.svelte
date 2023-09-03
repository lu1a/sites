<script>
  import GlassCard from "../components/GlassCard.svelte";
  import SwipeWrapper from "../components/SwipeWrapper.svelte";

  let leftLink = "/contact";
  let rightLink = "/about";
</script>

<SwipeWrapper leftLink={leftLink} rightLink={rightLink}>
  <h1 class="name-title">Lewis Torrington</h1>
  <br />

  <div style="padding: 1rem;">
    <img
      class="image-card image-headshot"
      src="/images/lewis-headshot.png"
      alt="A headshot of me"
    />

    <GlassCard bounceSpeed={2} style="margin-top: -1rem;margin-left: 8rem;">
      <p class="no-padding">
        <span style="display: inline-block;transform: rotate(45deg);">👈</span> me!
      </p>
    </GlassCard>

    <p>
      Hello, my name is Lewis and this is my page.<br />
      I've got an about-me section and a contact section,
      and in this iteration of my site I'm focusing entirely 
      mobile-first because my (from-scratch) statistics 
      tell me that literally everyone who visited here  
      has been on a phone lol
    </p>
  </div>
  
  <GlassCard style="margin-top: 1rem;margin-left: 2rem;">
    <p class="no-padding">
      Work in progress 👷<br/>
      Swipe to see more..
    </p>
  </GlassCard>
</SwipeWrapper>

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
  }

  .no-padding {
    margin: 0;
  }
</style>
