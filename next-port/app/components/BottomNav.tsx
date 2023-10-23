import Arrow from "./Arrow";

export default function BottomNav({
  rightLink,
  leftLink,
}: {
  rightLink: string | null,
  leftLink: string | null,
}) {
  return (
    <div className="overflow-hidden w-full h-full">
      {leftLink && <Arrow direction="left" link={leftLink} />}
      {rightLink && <Arrow direction="right" link={rightLink} />}
    </div>
  )
}
