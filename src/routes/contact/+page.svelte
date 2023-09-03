<script>
  import GlassCard from "../../components/GlassCard.svelte";
  import SwipeWrapper from "../../components/SwipeWrapper.svelte";

  let leftLink = "/data";
  let rightLink = "/";

  let sender_address = '';
  let subject = '';
  let content = '';
  let responseMessage = '';

  async function handleSubmit() {
    const response = await fetch('/contact', {
      method: 'POST',
      body: JSON.stringify({ sender_address, subject, content }),
      headers: {
        'content-type': 'application/json'
      }
    });

    responseMessage = await response.json();
  }
</script>

<SwipeWrapper leftLink={leftLink} rightLink={rightLink}>
  <div style="padding: 1rem;">
    <h1>Contact</h1>

    <form on:submit={handleSubmit}>
      <label for="sender_address">Sender Address:</label>
      <input type="email" id="sender_address" bind:value={sender_address} required />

      <br />

      <label for="subject">Subject:</label>
      <input type="text" id="subject" bind:value={subject} required />

      <br />

      <label for="content">Content:</label>
      <textarea id="content" bind:value={content} required />

      <br />

      <button type="submit">Send Message</button>
    </form>
  
    {#if responseMessage}
      <p>{responseMessage}</p>
    {/if}
  </div>
  <GlassCard style="margin-left: 1rem;">
    <p class="no-padding">
      Work in progress 👷
    </p>
  </GlassCard>
</SwipeWrapper>

<style>
  .no-padding {
    margin: 0;
  }
</style>
