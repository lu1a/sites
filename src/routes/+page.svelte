<script>
  import GlassCard from "../components/GlassCard.svelte";
  import SwipeWrapper from "../components/SwipeWrapper.svelte";

  let rightLink = "/about";
</script>

<SwipeWrapper leftLink={null} rightLink={rightLink}>
  <div style="padding: 2rem;">
    <img
      class="image-card image-headshot"
      src="/images/lewis-headshot.png"
      alt="A headshot of me"
    />

    <GlassCard bounceSpeed={2} style="margin-top: -3rem;margin-left: 8rem;">
      <p class="no-padding">
        <span style="display: inline-block;transform: rotate(45deg);">👈</span> me!
      </p>
    </GlassCard>

    <h1 class="name-title">Lewis Torrington</h1>

    <p class="p-over-pure-black">
      Hello, my name is Lewis and this is my page.
      I've got an about-me section and a contact section - 
      and in this iteration of my site, I'm focusing entirely 
      mobile-first because my (from-scratch) statistics 
      tell me that literally everyone who visited here 
      has been on a phone!
    </p>
  </div>
</SwipeWrapper>

<style>
  .name-title {
    font-size: 4rem;

    margin: 0;
  }

  .image-card {
    border-radius: 50%;
  }

  .image-headshot {
    width: 10rem;
    height: 10rem;
  }

  .p-over-pure-black {
    color: rgb(132 132 135);
    font-size: 1.2rem;
  }

  .no-padding {
    margin: 0;
  }
</style>
