<script>
  /** @type {String} */
  export let direction;
  /** @type {String} */
  export let link;
</script>

<style>
  .arrow {
    position: absolute;
    top: 90%;
    z-index: 1;

    font-size: 2rem;
  }

  .left {
    left: 5%;
  }

  .right {
    right: 5%;
  }
</style>

<a class="arrow {direction}" href={link}>
  {direction === 'left' ? '👈' : direction === 'right' ? '👉' : ''}
</a>