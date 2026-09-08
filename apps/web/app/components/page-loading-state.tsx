export function PageLoadingState({ label }: { label: string }) {
  return (
    <main aria-busy="true" className="app-bg">
      <section className="app-container max-w-3xl">
        <div className="app-panel-flat p-5 sm:p-6">
          <div aria-hidden="true" className="animate-pulse space-y-3">
            <div className="h-5 w-32 rounded bg-slate-200" />
            <div className="h-4 w-full max-w-xl rounded bg-slate-100" />
            <div className="h-4 w-4/5 max-w-lg rounded bg-slate-100" />
          </div>
          <p aria-live="polite" className="mt-5 text-sm text-slate-500">{label}</p>
        </div>
      </section>
    </main>
  );
}
