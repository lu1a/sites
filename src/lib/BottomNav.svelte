<script>
	import Arrow from "./Arrow.svelte";

  export let rightLink;
  export let leftLink;
</script>

<div class="overflow-hidden w-full h-full">
  {#if leftLink}
    <Arrow direction="left" link={leftLink} />
  {/if}

  {#if rightLink}
    <Arrow direction="right" link={rightLink} />
  {/if}
</div>
