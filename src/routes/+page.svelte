<script>
	import BottomNav from "../lib/BottomNav.svelte";
	import GlassCard from "../lib/GlassCard.svelte";

    let rightLink = "/about";
</script>

<main class="overflow-hidden mx-auto p-8 max-w-xl">
    <img
        class="rounded-full m-0 w-40 h-40"
        src="/lewis-headshot.png"
        alt="A headshot of me"
    />

    <div class="animate-bounce" style="margin-top: -3rem; margin-left: 8rem;">
        <GlassCard>
            <p class="m-0">
                <span style="display: inline-block; transform: rotate(45deg);">👈</span> me!
            </p>
        </GlassCard>
    </div>

    <h1 class="text-6xl m-0">Lewis Torrington</h1>

    <p class="text-gray-400 text-lg mt-5">
        Hello, my name is Lewis and this is my page.
        I&apos;ve got an about-me section and a data section - 
        and in this iteration of my site, I&apos;m focusing entirely 
        mobile-first because my stats
        tell me that almost every non-bot who visited here 
        has been on a phone!
    </p>

    <BottomNav leftLink={null} rightLink={rightLink} />
</main>