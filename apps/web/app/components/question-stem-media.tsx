import { formatQuestionText } from "@/app/lib/text-format";

type QuestionStemMediaProps = {
  stem: string | null | undefined;
  stemFormat?: string | null;
  stemImageUrl?: string | null;
  className?: string;
  imageClassName?: string;
  compact?: boolean;
  linkImage?: boolean;
};

export function QuestionStemMedia({
  stem,
  stemFormat,
  stemImageUrl,
  className = "whitespace-pre-wrap text-sm font-medium",
  imageClassName = "",
  compact = false,
  linkImage = true,
}: QuestionStemMediaProps) {
  const hasImage = Boolean(stemImageUrl && stemImageUrl.trim());
  const formatLabel = stemFormat === "IMAGE" ? "题干图片" : stemFormat === "DIAGRAM" ? "结构图表" : "题干配图";

  return (
    <div className="min-w-0">
      <p className={className}>{formatQuestionText(stem)}</p>
      {hasImage && (
        <figure className={compact ? "mt-2" : "mt-4"}>
          {linkImage ? (
            <a href={stemImageUrl ?? ""} rel="noreferrer" target="_blank">
              <QuestionImage alt={formatLabel} className={imageClassName} src={stemImageUrl ?? ""} />
            </a>
          ) : (
            <QuestionImage alt={formatLabel} className={imageClassName} src={stemImageUrl ?? ""} />
          )}
          {!compact && <figcaption className="mt-2 text-xs text-slate-500">点击图片可在新窗口查看原图。</figcaption>}
        </figure>
      )}
    </div>
  );
}

function QuestionImage({ alt, className, src }: { alt: string; className: string; src: string }) {
  return (
    // eslint-disable-next-line @next/next/no-img-element -- Question images can be MinIO presigned URLs or external archival links.
    <img
      alt={alt}
      className={`max-h-[520px] w-full max-w-3xl rounded-md border border-slate-200 bg-white object-contain ${className}`}
      loading="lazy"
      src={src}
    />
  );
}

export function QuestionStemThumbnail({ stemImageUrl }: { stemImageUrl?: string | null }) {
  if (!stemImageUrl) {
    return null;
  }

  return (
    <span className="mt-2 inline-flex items-center rounded-md border border-slate-200 bg-slate-50 px-2 py-1 text-xs font-medium text-slate-600">
      含题图
    </span>
  );
}
