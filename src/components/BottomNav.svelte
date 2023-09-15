<script lang="ts">
  import { onNavigate } from '$app/navigation';
  import Arrow from "./Arrow.svelte";

  export let rightLink: string | null;
  export let leftLink: string | null;

  onNavigate((navigation) => {
    //@ts-ignore
    if (!document.startViewTransition) return;

    return new Promise((resolve) => {
      //@ts-ignore
      document.startViewTransition(async () => {
        resolve();
        await navigation.complete;
      });
    });
  });
</script>
  
<div class="nav-wrapper">
  {#if leftLink}
    <Arrow direction="left" link={leftLink}/>
  {/if}
  {#if rightLink}
    <Arrow direction="right" link={rightLink}/>
  {/if}
</div>

<style>
  .nav-wrapper {
    overflow: hidden;
    width: 100%;
    height: 100%;
  }
</style>
