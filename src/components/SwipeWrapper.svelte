<script>
  import Arrow from "./Arrow.svelte"

  /** @type {String} */
  export let rightLink
  /** @type {String} */
  export let leftLink

  let touchStartX = 0
  let touchEndX = 0
  let threshold = 50 // Minimum swipe distance to trigger navigation

  // @ts-ignore
  function handleTouchStart(event) {
    touchStartX = event.touches[0].clientX
  }

  // @ts-ignore
  function handleTouchEnd(event) {
    touchEndX = event.changedTouches[0].clientX
    let swipeDistance = touchStartX - touchEndX

    if (swipeDistance > threshold) {
      // Swipe right, navigate to the next link/page
      window.location.pathname = rightLink
    } else if (swipeDistance < -threshold) {
      // Swipe left, navigate to the previous link/page
      window.location.pathname = leftLink
    }
  }
</script>
  
<div
  class="fullscreen-wrapper"
  on:touchstart={handleTouchStart}
  on:touchend={handleTouchEnd}
  >
    <slot />

  <Arrow direction="left" link={leftLink}/>
  <Arrow direction="right" link={rightLink}/>
</div>

<style>
  .fullscreen-wrapper {
    overflow: hidden;

    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
  }
</style>
