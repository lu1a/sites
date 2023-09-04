<script>
  import SwipeWrapper from "../../components/SwipeWrapper.svelte"

  let leftLink = "/data"
  let rightLink = "/"

  let sender_address = ''
  let subject = ''
  let content = ''
  let responseMessage = ''

  async function handleSubmit() {
    const response = await fetch('/contact', {
      method: 'POST',
      body: JSON.stringify({ sender_address, subject, content }),
      headers: {
        'content-type': 'application/json'
      }
    })

    responseMessage = await response.json()
  }
</script>

<SwipeWrapper leftLink={leftLink} rightLink={rightLink}>
  <div style="padding: 1rem;">
    <h1>Contact</h1>

    <form on:submit={handleSubmit}>
      <div class="input-wrapper">
        <label for="sender_address">Sender Address:</label>
        <input type="email" id="sender_address" bind:value={sender_address} required />
      </div>

      <br />

      <div class="input-wrapper">
        <label for="subject">Subject:</label>
        <input type="text" id="subject" bind:value={subject} required />
      </div>

      <br />

      <div class="input-wrapper">
        <label for="content">Content:</label>
        <textarea id="content" bind:value={content} required />
      </div>

      <br />

      <button type="submit">Send Message</button>
    </form>
  
    {#if responseMessage}
      <p>{responseMessage}</p>
    {/if}
  </div>
</SwipeWrapper>

<style>
  .input-wrapper {
    display: flex;
    width: 17rem;
    justify-content: space-between;
  }
</style>
