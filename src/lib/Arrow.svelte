<script>
  export let direction;
  export let link;
</script>

<a class={`absolute bottom-10 z-10 text-white text-base no-underline ${direction === 'left' ? 'left left-10' : 'right right-10'}`} href={link}>
  {direction === 'left' ? '← Back' : 'Next →'}
</a>


