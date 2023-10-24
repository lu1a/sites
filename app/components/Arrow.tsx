import Link from "next/link";

export default function Arrow({
  direction,
  link,
}: {
  direction: string,
  link: string,
}) {
  return (
    <Link className={`absolute bottom-10 z-10 text-white text-base no-underline ${direction === 'left' ? 'left left-10' : 'right right-10'}`} href={link}>
      {direction === 'left' ? '← Back' : 'Next →'}
    </Link>
  )
}

// text-shadow: 0 0 10px #fff, 0 0 21px #fff;
