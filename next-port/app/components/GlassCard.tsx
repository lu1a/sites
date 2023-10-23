export default function GlassCard({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <div className="relative inline-block z-10 bg-opacity-20 bg-white backdrop-blur-sm rounded-xl shadow-card border border-white/30 p-4 animate-moveTopBottom">
      {children}
    </div>
  )
}
