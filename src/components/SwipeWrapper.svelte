<script lang="ts">
  import Arrow from "./Arrow.svelte";

  export let rightLink: string | null;
  export let leftLink: string | null;
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
