export default function Arrow({
  direction,
  link,
}: {
  direction: string,
  link: string,
}) {
  return (
    <a className={`absolute bottom-10 z-10 text-white text-base no-underline ${direction === 'left' ? 'left left-10' : 'right right-10'}`} href={link}>
      {direction === 'left' ? '← Back' : 'Next →'}
    </a>
  )
}

// text-shadow: 0 0 10px #fff, 0 0 21px #fff;
