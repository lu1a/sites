<script>
  import Arrow from "./Arrow.svelte"

  /** @type {?String} */
  export let rightLink
  /** @type {?String} */
  export let leftLink
</script>
  
<div class="fullscreen-wrapper">
    <slot />

  {#if leftLink}
    <Arrow direction="left" link={leftLink}/>
  {/if}
  {#if rightLink}
    <Arrow direction="right" link={rightLink}/>
  {/if}
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
