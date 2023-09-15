<script lang="ts">
  import SwipeWrapper from "../../components/SwipeWrapper.svelte";

  let leftLink = "/data"
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
  <div style="padding: 2rem;">
    <h1>Contact</h1>

    <form on:submit={handleSubmit}>
      <input type="email" id="sender_address" class="input" bind:value={sender_address} required placeholder="Email address" style="border-radius: 8px" />

      <br />
      <br />

      <input type="text" id="subject" class="input" bind:value={subject} required placeholder="Subject" style="border-radius: 8px" />

      <br />
      <br />

      <textarea id="content" class="input" bind:value={content} required placeholder="Your message" style="width: 94%; max-width: 25rem; height: 10rem;" />

      <br />
      <br />

      <button class="contact-CTA" type="submit">Send Message</button>
    </form>
  
    {#if responseMessage}
      <p>{responseMessage}</p>
    {/if}
  </div>
</SwipeWrapper>

<style>
  .input {
    width: 14rem;
    font-family: helvetica;
    padding: 0.6rem;
    border: none;
    border-radius: 16px;

    background-color: rgb(50,50,50);
    color: white;
  }

  .contact-CTA {
    background-color: rgb(0 37 51);
    border: none;
    width: 10rem;
    height: 3rem;
    color: rgb(2 183 255);
    border-radius: 6px;
    font-weight: 600;
    font-size: 1rem;
    font-family: system-ui;
  }
</style>
