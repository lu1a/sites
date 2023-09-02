<script>
  /** @type {String} */
  export let direction;
  /** @type {String} */
  export let link;
</script>

<a href={link}>
  {direction === 'left' ? '👈' : direction === 'right' ? '👉' : ''}
</a>