export default function MobileWrapper({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <div className="content-wrapper">
      {children}
  </div>
  )
}
  
<style>
  .content-wrapper {
    overflow: hidden;

    margin: auto;
    padding: 2rem;
    max-width: 30rem;
  }
</style>