export default function GreyCard({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <div className="bg-gray-50 border-gray-50 dark:bg-gray-800 dark:border-gray-800 rounded-xl p-4">
      {children}
    </div>
  )
}
  