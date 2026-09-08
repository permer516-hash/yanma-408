"use client";

import { useEffect, useRef } from "react";

export function ConfirmDialog({
  confirmLabel,
  description,
  onClose,
  onConfirm,
  open,
  title,
}: {
  confirmLabel: string;
  description: string;
  onClose: () => void;
  onConfirm: () => void;
  open: boolean;
  title: string;
}) {
  const cancelButtonRef = useRef<HTMLButtonElement>(null);

  useEffect(() => {
    if (!open) {
      return;
    }
    cancelButtonRef.current?.focus();
    function handleKeyDown(event: KeyboardEvent) {
      if (event.key === "Escape") {
        onClose();
      }
    }
    window.addEventListener("keydown", handleKeyDown);
    return () => window.removeEventListener("keydown", handleKeyDown);
  }, [onClose, open]);

  if (!open) {
    return null;
  }

  return (
    <div className="fixed inset-0 z-[60] flex items-center justify-center bg-slate-950/45 p-4 backdrop-blur-sm" onClick={onClose} role="presentation">
      <section aria-describedby="confirm-dialog-description" aria-labelledby="confirm-dialog-title" aria-modal="true" className="w-full max-w-md rounded-lg border border-slate-200 bg-white p-5 shadow-xl shadow-slate-950/20 sm:p-6" onClick={(event) => event.stopPropagation()} role="dialog">
        <h2 className="text-lg font-semibold text-slate-950" id="confirm-dialog-title">{title}</h2>
        <p className="mt-2 text-sm leading-6 text-slate-600" id="confirm-dialog-description">{description}</p>
        <div className="mt-6 flex flex-wrap justify-end gap-3">
          <button className="app-button-secondary" onClick={onClose} ref={cancelButtonRef} type="button">取消</button>
          <button className="rounded-md bg-red-700 px-4 py-2 text-sm font-medium text-white hover:bg-red-800 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-red-700" onClick={onConfirm} type="button">{confirmLabel}</button>
        </div>
      </section>
    </div>
  );
}
