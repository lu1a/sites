<script>
  /** @type {String} */
  export let direction
  /** @type {String} */
  export let link
</script>

<a class="arrow {direction}" href={link}>
  {direction === 'left' ? '👈' : direction === 'right' ? '👉' : ''}
</a>

<style>
  .arrow {
    position: absolute;
    top: 90%;
    z-index: 1;

    font-size: 1.5rem;
  }

  .left {
    left: 5%;
  }

  .right {
    right: 5%;
  }
</style>
