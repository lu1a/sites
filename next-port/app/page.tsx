import Image from 'next/image'
import MobileWrapper from './components/MobileWrapper'
import GlassCard from './components/GlassCard'
import BottomNav from './components/BottomNav'

export default function Home() {
  const rightLink = "/about"
  return (
    <main className="overflow-hidden mx-auto p-8 max-w-xl">
      <Image
        className="rounded-full w-40 h-40"
        src="/lewis-headshot.png"
        alt="A headshot of me"
        width={200}
        height={200}
      />

      <GlassCard>
        <p className="m-0">
          <span style={{display: "inline-block", transform: "rotate(45deg)"}}>👈</span> me!
        </p>
      </GlassCard>

      <h1 className="font-thin mt-0 text-6xl m-0">Lewis Torrington</h1>

      <p className="text-gray-400 text-lg mt-5">
        Hello, my name is Lewis and this is my page.
        I&apos;ve got an about-me section and a contact section - 
        and in this iteration of my site, I&apos;m focusing entirely 
        mobile-first because my (from-scratch) statistics 
        tell me that literally everyone who visited here 
        has been on a phone!
      </p>

      <BottomNav leftLink={null} rightLink={rightLink} />
    </main>
  )
}
