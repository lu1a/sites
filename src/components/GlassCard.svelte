<script>
  /** @type {String} */
  export let style
  /** @type {Number} */
  export let bounceSpeed = 3
</script>
  
<div class="glass-card" style="{style} animation-duration: {bounceSpeed}s;">
    <slot />
</div>

<style>
  .glass-card {
    z-index: 1;
    width: fit-content;

    background: rgba(255, 255, 255, 0.2);
    border-radius: 16px;
    box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
    backdrop-filter: blur(5px);
    -webkit-backdrop-filter: blur(5px);
    border: 1px solid rgba(255, 255, 255, 0.3);

    padding: 1rem;

    animation: moveTopBottom ease-in-out infinite alternate;
  }

  @keyframes moveTopBottom {
    0%, 100% {
        transform: translate(0%, 0%);
    }
    50% {
        transform: translate(0%, 7%);
    }
  }
</style>
