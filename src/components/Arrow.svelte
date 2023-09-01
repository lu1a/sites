<script>
    export let direction;
    export let link;
</script>

<a href={link}>
    {direction === 'left' ? '👈' : direction === 'right' ? '👉' : ''}
</a>