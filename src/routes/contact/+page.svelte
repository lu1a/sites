<script>

  import GlassCard from "../../components/GlassCard.svelte";
  import SwipeWrapper from "../../components/SwipeWrapper.svelte";

  let leftLink = "/data";
  let rightLink = "/";
</script>

<SwipeWrapper leftLink={leftLink} rightLink={rightLink}>
  <div style="padding: 1rem;">
    <h1>Contact</h1>

    <!-- TODO -->
  </div>
  <GlassCard style="margin-left: 1rem;">
    <p class="no-padding">
      Work in progress 👷
    </p>
  </GlassCard>
</SwipeWrapper>

<style>
  .no-padding {
    margin: 0;
  }
</style>
