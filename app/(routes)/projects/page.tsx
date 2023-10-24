import Link from 'next/link';
import BottomNav from '../../components/BottomNav';
import GreyCard from '../../components/GreyCard';

export default function Projects() {
  const rightLink = "/data";
  const leftLink = "/about";

  return (
    <main className="overflow-hidden mx-auto p-8 max-w-xl">
      <h1 className="text-3xl">Some projects</h1>
      <br />

      <GreyCard>
        <p className="m-0">
          <Link
            className="underline"
            href="https://github.com/lu1a/cosmas-api"
            target="_blank"
          >
            COSMAS
          </Link>
          <br />
          An API in Rust to allow for an automated social peer-to-peer sharing system.
          <br />
          Designed for my future farm in mind. 🧑‍🌾🌾
        </p>
      </GreyCard>
      <br />

      <GreyCard>
        <p className="m-0">
          <Link
            className="underline"
            href="https://github.com/lu1a/kasu"
            target="_blank"
          >
            KASU
          </Link>
          <br />
          A little script for installing Kubernetes on a blank Ubuntu machine!
          <br />
          Either for becoming a control plane or worker node.
        </p>
      </GreyCard>
      <br />

      <p className="m-0 text-gray-400 text-lg">
        <i>...and more! Though not that much more that I wanna show publicly.
        Check out my GitHub anyhow if you&apos;re interested.</i></p>

      <BottomNav leftLink={leftLink} rightLink={rightLink} />
    </main>
  );
}
