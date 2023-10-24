import Link from 'next/link';
import BottomNav from '../../components/BottomNav';

export default function Contact() {
  const leftLink = "/data";

  return (
    <main className="overflow-hidden mx-auto p-8 max-w-xl">
      <h1 className="text-3xl">Contact</h1>
      <br />
      <div className="flex justify-center mt-72">
        <Link href="https://www.linkedin.com/in/lewis-torrington/">
          <button className="bg-blue-700 w-40 h-12 text-blue-300 rounded-md font-semibold text-lg font-sans">Get in touch</button>
        </Link>
      </div>

      <BottomNav leftLink={leftLink} rightLink={null} />
    </main>
  );
}
