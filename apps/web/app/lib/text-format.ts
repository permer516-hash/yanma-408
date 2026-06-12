export function formatQuestionText(value: string | null | undefined) {
  return (value ?? "").replace(/\\r\\n/g, "\n").replace(/\\n/g, "\n").replace(/\\"/g, '"');
}
