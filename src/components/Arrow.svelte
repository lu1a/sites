<script lang="ts">
  export let direction: string;
  export let link: string;
</script>

<a class="arrow {direction}" href={link}>
  {direction === 'left' ? '← Back' : direction === 'right' ? 'Next →' : ''}
</a>

<style>
  .arrow {
    position: absolute;
    top: 90%;
    z-index: 1;

    font-size: 1.2rem;
    color: white;
    text-decoration: none;
    text-shadow: 0 0 10px #fff, 0 0 21px #fff;
  }

  .left {
    left: 10%;

    color: white;
    text-shadow: 0 0 10px #fff, 0 0 21px #fff;
  }

  .right {
    right: 10%;
  }
</style>
