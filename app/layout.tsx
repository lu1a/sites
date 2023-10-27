import type { Metadata } from 'next'
import './globals.css'

export const metadata: Metadata = {
  title: 'Lewis Torrington',
  description: 'Lewis\'s portfolio site',
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="en">
      <body className="bg-black text-white font-helvetica font-light m-0">{children}</body>
    </html>
  )
}
