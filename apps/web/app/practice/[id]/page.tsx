"use client";

import Link from "next/link";
import { Suspense, use, useEffect, useRef, useState } from "react";
import { useSearchParams } from "next/navigation";
import {
  fetchQuestionDetail,
  fetchLatestComprehensiveAttempt,
  fetchQuestions,
  ComprehensiveAttempt,
  QuestionDetail,
  QuestionFeedbackIssueType,
  requestComprehensiveReview,
  saveComprehensiveDraft,
  submitAnswer,
  submitComprehensiveAttempt,
  SubmitAnswerResult,
  submitQuestionFeedback,
  uploadComprehensiveAttachment,
} from "@/app/lib/api";
import { QuestionStemMedia } from "@/app/components/question-stem-media";
import { PageLoadingState } from "@/app/components/page-loading-state";
import { difficultyLabels, subjectLabels, typeLabels } from "@/app/lib/question-labels";
import { formatQuestionText } from "@/app/lib/text-format";

export default function PracticePage({ params }: { params: Promise<{ id: string }> }) {
  return (
    <Suspense fallback={<PageLoadingState label="正在加载题目..." />}>
      <PracticePageContent params={params} />
    </Suspense>
  );
}

function PracticePageContent({ params }: { params: Promise<{ id: string }> }) {
  const { id } = use(params);
  const searchParams = useSearchParams();
  const returnHref = normalizeReturnHref(searchParams.get("from"));
  const [question, setQuestion] = useState<QuestionDetail | null>(null);
  const [selected, setSelected] = useState("");
  const [result, setResult] = useState<SubmitAnswerResult | null>(null);
  const [comprehensiveAnswers, setComprehensiveAnswers] = useState<Record<string, string>>({});
  const [comprehensiveAttachments, setComprehensiveAttachments] = useState<Record<string, string[]>>({});
  const [comprehensiveAttempt, setComprehensiveAttempt] = useState<ComprehensiveAttempt | null>(null);
  const [nextQuestionId, setNextQuestionId] = useState<string | null>(null);
  const [submitting, setSubmitting] = useState(false);
  const [savingDraft, setSavingDraft] = useState(false);
  const [uploadingPartId, setUploadingPartId] = useState<string | null>(null);
  const [reviewMessage, setReviewMessage] = useState("");
  const [reviewing, setReviewing] = useState(false);
  const [error, setError] = useState("");
  const [feedbackOpen, setFeedbackOpen] = useState(false);
  const [feedbackIssueType, setFeedbackIssueType] = useState<QuestionFeedbackIssueType>("ANSWER_INCORRECT");
  const [feedbackDescription, setFeedbackDescription] = useState("");
  const [feedbackSubmitting, setFeedbackSubmitting] = useState(false);
  const [feedbackMessage, setFeedbackMessage] = useState("");
  const [feedbackError, setFeedbackError] = useState("");
  const startedAtRef = useRef<number | null>(null);

  useEffect(() => {
    let cancelled = false;
    startedAtRef.current = Date.now();

    Promise.all([fetchQuestionDetail(id), fetchQuestions()])
      .then(async ([loadedQuestion, questions]) => {
        const latestAttempt = loadedQuestion.type === "COMPREHENSIVE"
          ? await fetchLatestComprehensiveAttempt(loadedQuestion.id)
          : null;
        if (!cancelled) {
          const currentIndex = questions.findIndex((question) => question.id === id);
          const nextQuestion = currentIndex >= 0 ? questions[currentIndex + 1] : null;
          setQuestion(loadedQuestion);
          setNextQuestionId(nextQuestion?.id ?? null);
          setSelected("");
          setResult(null);
          setComprehensiveAttempt(latestAttempt);
          setComprehensiveAnswers(Object.fromEntries((latestAttempt?.responses ?? []).map((response) => [response.partId, response.content])));
          setComprehensiveAttachments(Object.fromEntries((latestAttempt?.responses ?? []).map((response) => [response.partId, response.attachmentUrls])));
          setReviewMessage("");
          setError("");
          setFeedbackOpen(false);
          setFeedbackDescription("");
          setFeedbackMessage("");
          setFeedbackError("");
        }
      })
      .catch((err: Error) => {
        if (!cancelled) {
          setError(err.message);
        }
      });

    return () => {
      cancelled = true;
    };
  }, [id]);

  const handleSubmit = async () => {
    if (!question) {
      return;
    }
    if (question.type === "COMPREHENSIVE") {
      if (question.comprehensiveParts.some((part) => !comprehensiveAnswers[part.id]?.trim() && !(comprehensiveAttachments[part.id]?.length))) {
        setError("请完成每个小问后再提交。");
        return;
      }
      setSubmitting(true);
      setError("");
      try {
        const elapsedSeconds = Math.max(0, Math.round((Date.now() - (startedAtRef.current ?? Date.now())) / 1000));
        const attempt = await submitComprehensiveAttempt({
          questionId: question.id,
          elapsedSeconds,
          responses: question.comprehensiveParts.map((part) => ({
            partId: part.id,
            content: comprehensiveAnswers[part.id] ?? "",
            attachmentUrls: comprehensiveAttachments[part.id] ?? [],
          })),
        });
        setComprehensiveAttempt(attempt);
      } catch (err) {
        setError(err instanceof Error ? err.message : "综合题提交失败");
      } finally {
        setSubmitting(false);
      }
      return;
    }
    if (!selected) {
      return;
    }
    setSubmitting(true);
    setError("");
    try {
      const startedAt = startedAtRef.current ?? Date.now();
      const elapsedSeconds = Math.max(0, Math.round((Date.now() - startedAt) / 1000));
      const submitResult = await submitAnswer({
        questionId: question.id,
        submittedAnswer: selected,
        elapsedSeconds,
      });
      setResult(submitResult);
    } catch (err) {
      setError(err instanceof Error ? err.message : "答案提交失败");
    } finally {
      setSubmitting(false);
    }
  };

  const handleSaveDraft = async () => {
    if (!question || question.type !== "COMPREHENSIVE") {
      return;
    }
    const responses = question.comprehensiveParts
      .filter((part) => comprehensiveAnswers[part.id]?.trim() || comprehensiveAttachments[part.id]?.length)
      .map((part) => ({
        partId: part.id,
        content: comprehensiveAnswers[part.id] ?? "",
        attachmentUrls: comprehensiveAttachments[part.id] ?? [],
      }));
    if (responses.length === 0) {
      setError("请至少填写一个小问后再保存草稿。");
      return;
    }
    setSavingDraft(true);
    setError("");
    try {
      const elapsedSeconds = Math.max(0, Math.round((Date.now() - (startedAtRef.current ?? Date.now())) / 1000));
      setComprehensiveAttempt(await saveComprehensiveDraft({ questionId: question.id, elapsedSeconds, responses }));
    } catch (err) {
      setError(err instanceof Error ? err.message : "综合题草稿保存失败");
    } finally {
      setSavingDraft(false);
    }
  };

  const handleAttachmentUpload = async (partId: string, file: File) => {
    setUploadingPartId(partId);
    setError("");
    try {
      const url = await uploadComprehensiveAttachment(file);
      setComprehensiveAttachments((current) => ({ ...current, [partId]: [...(current[partId] ?? []), url] }));
    } catch (err) {
      setError(err instanceof Error ? err.message : "作答图片上传失败");
    } finally {
      setUploadingPartId(null);
    }
  };

  const handleRequestReview = async () => {
    if (!comprehensiveAttempt || !reviewMessage.trim()) {
      setError("请说明需要复核的原因。");
      return;
    }
    setReviewing(true);
    setError("");
    try {
      await requestComprehensiveReview(comprehensiveAttempt.id, reviewMessage.trim());
      setComprehensiveAttempt((current) => current ? { ...current, status: "REVIEW_REQUESTED" } : current);
      setReviewMessage("");
    } catch (err) {
      setError(err instanceof Error ? err.message : "复核申请提交失败");
    } finally {
      setReviewing(false);
    }
  };

  const handleSubmitFeedback = async () => {
    if (!question || !feedbackDescription.trim()) {
      setFeedbackError("请简单说明你觉得哪里有问题。");
      return;
    }
    setFeedbackSubmitting(true);
    setFeedbackError("");
    setFeedbackMessage("");
    try {
      await submitQuestionFeedback({
        questionId: question.id,
        issueType: feedbackIssueType,
        description: feedbackDescription.trim(),
      });
      setFeedbackDescription("");
      setFeedbackOpen(false);
      setFeedbackMessage("反馈已提交，管理员会在后台查看。");
    } catch (err) {
      setFeedbackError(err instanceof Error ? err.message : "反馈提交失败");
    } finally {
      setFeedbackSubmitting(false);
    }
  };

  return (
    <main className="app-bg">
      <div className="app-container grid gap-5 xl:grid-cols-[minmax(0,1fr)_320px]">
        <section className="app-panel overflow-hidden">
          <div className="border-b border-slate-200 px-5 py-4">
            <Link className="text-sm font-medium text-teal-700" href={returnHref}>
              返回题库
            </Link>
          </div>

          {error && <div className="px-5 py-10 text-sm text-red-700">{error}</div>}
          {!error && !question && <div className="px-5 py-10 text-sm text-slate-500">正在加载题目...</div>}

          {question && (
            <div className="p-5">
              <div className="flex flex-wrap gap-2 text-xs">
                <Badge>{subjectLabels[question.subjectCode] ?? question.subjectName}</Badge>
                <Badge>{question.chapterName}</Badge>
                <Badge>{typeLabels[question.type] ?? question.type}</Badge>
                <Badge>{difficultyLabels[question.difficulty] ?? question.difficulty}</Badge>
              </div>

              <div className="mt-5">
                <QuestionStemMedia
                  className="whitespace-pre-wrap text-xl font-semibold leading-8 text-slate-950"
                  stem={question.stem}
                  stemFormat={question.stemFormat}
                  stemImageUrl={question.stemImageUrl}
                />
              </div>

              {question.type === "COMPREHENSIVE" ? (
                <ComprehensiveAnswerForm
                  answers={comprehensiveAnswers}
                  attachments={comprehensiveAttachments}
                  attempt={comprehensiveAttempt}
                  disabled={Boolean(comprehensiveAttempt?.submittedAt)}
                  onChange={(partId, value) => setComprehensiveAnswers((current) => ({ ...current, [partId]: value }))}
                  onRemoveAttachment={(partId, url) => setComprehensiveAttachments((current) => ({ ...current, [partId]: (current[partId] ?? []).filter((item) => item !== url) }))}
                  onUpload={(partId, file) => void handleAttachmentUpload(partId, file)}
                  parts={question.comprehensiveParts}
                  uploadingPartId={uploadingPartId}
                />
              ) : (
              <div className="mt-6 space-y-3">
                {question.options.map((option) => {
                  const isSelected = selected === option.label;
                  const isAnswer = result && option.label === result.correctAnswer;
                  const isWrongPick = result && isSelected && option.label !== result.correctAnswer;
                  return (
                    <button
                    className={`flex w-full gap-3 rounded-md border px-4 py-3 text-left text-sm leading-6 transition ${
                        isAnswer
                          ? "border-green-600 bg-green-50 text-green-800"
                          : isWrongPick
                            ? "border-red-600 bg-red-50 text-red-800"
                            : isSelected
                              ? "border-teal-700 bg-teal-50 text-teal-900"
                              : "border-slate-200 hover:border-teal-600"
                      }`}
                      disabled={Boolean(result)}
                      key={option.id}
                      onClick={() => setSelected(option.label)}
                      type="button"
                    >
                      <span className="font-semibold">{option.label}</span>
                      <span className="whitespace-pre-wrap">{formatQuestionText(option.content)}</span>
                    </button>
                  );
                })}
              </div>
              )}

              <div className="mt-6 flex flex-wrap items-center gap-3">
                {question.type === "COMPREHENSIVE" && !comprehensiveAttempt?.submittedAt && (
                  <button
                    className="app-button-secondary"
                    disabled={savingDraft || submitting}
                    onClick={handleSaveDraft}
                    type="button"
                  >
                    {savingDraft ? "保存中..." : "保存草稿"}
                  </button>
                )}
                <button
                  className="app-button-primary"
                  disabled={question.type === "COMPREHENSIVE" ? Boolean(comprehensiveAttempt?.submittedAt) || submitting : !selected || Boolean(result) || submitting}
                  onClick={handleSubmit}
                  type="button"
                >
                  {submitting ? "提交中..." : question.type === "COMPREHENSIVE" ? "提交综合题" : "提交答案"}
                </button>
                <button
                  className="app-button-secondary"
                  onClick={() => {
                    setFeedbackOpen(true);
                    setFeedbackError("");
                    setFeedbackMessage("");
                  }}
                  type="button"
                >
                  反馈题目问题
                </button>
                {result && (
                  <span className={`text-sm font-medium ${result.correct ? "text-green-700" : "text-red-700"}`}>
                    {result.correct ? "回答正确" : `回答错误，正确答案是 ${result.correctAnswer}`}
                  </span>
                )}
                {comprehensiveAttempt && (
                  <span className="text-sm font-medium text-amber-700">
                    {comprehensiveAttempt.status === "DRAFT" ? "草稿已保存" : comprehensiveAttempt.status === "FINALIZED" ? "人工评分已定稿" : comprehensiveAttempt.status === "REVIEW_REQUESTED" ? "已申请复核" : "已提交，等待人工评分"}
                  </span>
                )}
                {feedbackMessage && <span className="text-sm font-medium text-teal-700">{feedbackMessage}</span>}
              </div>

              {result && (
                <section className="mt-6 rounded-md border border-teal-100 bg-teal-50/40 p-4">
                  <h2 className="font-semibold">解析</h2>
                  <p className="mt-2 whitespace-pre-wrap text-sm leading-7 text-slate-700">{formatQuestionText(result.explanation)}</p>
                  {result.enteredMistakeBook && (
                    <p className="mt-3 text-sm font-medium text-red-700">
                      已加入错题本，累计做错 {result.wrongCount} 次。
                    </p>
                  )}
                  <div className="mt-4 flex flex-wrap gap-2">
                    <Link
                      className="rounded-md border border-slate-200 bg-white px-3 py-2 text-sm font-medium text-slate-700 hover:border-teal-700 hover:text-teal-800"
                      href="/"
                    >
                      返回仪表盘
                    </Link>
                    <Link
                      className="rounded-md bg-teal-700 px-3 py-2 text-sm font-medium text-white hover:bg-teal-800"
                      href={nextQuestionId ? `/practice/${nextQuestionId}?from=${encodeURIComponent(returnHref)}` : returnHref}
                    >
                      {nextQuestionId ? "继续下一题" : "返回题库"}
                    </Link>
                  </div>
                </section>
              )}
              {comprehensiveAttempt?.submittedAt && (
                <section className="mt-6 rounded-md border border-amber-100 bg-amber-50/40 p-4">
                  <h2 className="font-semibold">评分状态</h2>
                  <p className="mt-2 text-sm leading-7 text-slate-700">AI 阅卷服务尚未配置，本次作答已进入人工评分队列。</p>
                  {comprehensiveAttempt.status !== "FINALIZED" && comprehensiveAttempt.status !== "REVIEW_REQUESTED" && (
                    <div className="mt-4 grid gap-2">
                      <label className="grid gap-2 text-sm font-medium text-slate-700">
                        申请复核
                        <textarea
                          className="field min-h-20 font-normal"
                          onChange={(event) => setReviewMessage(event.target.value)}
                          placeholder="请说明希望复核的评分点或原因"
                          value={reviewMessage}
                        />
                      </label>
                      <button className="app-button-secondary w-fit" disabled={reviewing} onClick={handleRequestReview} type="button">
                        {reviewing ? "提交中..." : "提交复核申请"}
                      </button>
                    </div>
                  )}
                </section>
              )}
            </div>
          )}
        </section>

        {question && (
          <aside className="space-y-5 xl:sticky xl:top-6 xl:h-fit">
            <section className="app-panel p-5">
              <h2 className="text-base font-semibold">知识点</h2>
              <div className="mt-4 flex flex-wrap gap-2">
                {question.knowledgePoints.map((point) => (
                  <span className="rounded-md bg-teal-50 px-2.5 py-1 text-xs font-medium text-teal-800" key={point.id}>
                    {point.name}
                  </span>
                ))}
              </div>
            </section>

            <section className="app-panel p-5">
              <h2 className="text-base font-semibold">作答状态</h2>
              <dl className="mt-4 space-y-3 text-sm">
                <Row label="来源" value={question.sourceYear ? `${question.sourceYear} 真题` : "原创题"} />
                <Row label="分值" value={`${question.score} 分`} />
                {question.type === "COMPREHENSIVE" ? (
                  <>
                    <Row label="小问" value={`${question.comprehensiveParts.length} 问`} />
                    <Row label="状态" value={comprehensiveAttempt ? comprehensiveAttempt.status === "FINALIZED" ? "已评分" : comprehensiveAttempt.status === "DRAFT" ? "草稿" : "待人工评分" : "未提交"} />
                  </>
                ) : (
                  <>
                    <Row label="选择" value={selected || "未选择"} />
                    <Row label="状态" value={result ? (result.correct ? "正确" : "已归档错题") : "未提交"} />
                  </>
                )}
              </dl>
            </section>
          </aside>
        )}
      </div>
      {question && feedbackOpen && (
        <FeedbackModal
          description={feedbackDescription}
          error={feedbackError}
          issueType={feedbackIssueType}
          onClose={() => {
            if (!feedbackSubmitting) {
              setFeedbackOpen(false);
              setFeedbackError("");
            }
          }}
          onDescriptionChange={setFeedbackDescription}
          onIssueTypeChange={setFeedbackIssueType}
          onSubmit={() => void handleSubmitFeedback()}
          submitting={feedbackSubmitting}
        />
      )}
    </main>
  );
}

function normalizeReturnHref(value: string | null) {
  if (!value || !value.startsWith("/question-bank")) {
    return "/question-bank";
  }
  return value;
}

function ComprehensiveAnswerForm({
  answers,
  attachments,
  attempt,
  disabled,
  onChange,
  onRemoveAttachment,
  onUpload,
  parts,
  uploadingPartId,
}: {
  answers: Record<string, string>;
  attachments: Record<string, string[]>;
  attempt: ComprehensiveAttempt | null;
  disabled: boolean;
  onChange: (partId: string, value: string) => void;
  onRemoveAttachment: (partId: string, url: string) => void;
  onUpload: (partId: string, file: File) => void;
  parts: QuestionDetail["comprehensiveParts"];
  uploadingPartId: string | null;
}) {
  return (
    <div className="mt-6 space-y-5">
      {parts.map((part) => {
        const grade = attempt?.responses.find((response) => response.partId === part.id);
        return (
          <section className="rounded-md border border-slate-200 p-4" key={part.id}>
            <div className="flex flex-wrap items-start justify-between gap-3">
              <div>
                <h2 className="font-semibold">第 {part.sortOrder} 问</h2>
                <p className="mt-2 whitespace-pre-wrap text-sm leading-7 text-slate-800">{part.prompt}</p>
              </div>
              <span className="rounded-md bg-slate-100 px-2.5 py-1 text-xs font-medium text-slate-600">{part.score} 分</span>
            </div>
            {part.imageUrl && <img alt={`第 ${part.sortOrder} 问配图`} className="mt-3 max-h-80 rounded-md border border-slate-200" src={part.imageUrl} />}
            <label className="mt-4 grid gap-2 text-sm font-medium text-slate-700">
              {part.responseMode === "PSEUDOCODE" ? "C/C++ 伪代码或文字说明" : part.responseMode === "CALCULATION" ? "计算过程与结论" : "作答内容"}
              <textarea
                className="field min-h-32 font-normal"
                disabled={disabled}
                onChange={(event) => onChange(part.id, event.target.value)}
                placeholder={part.responseMode === "CALCULATION" ? "写下计算过程与结论" : "请输入答案"}
                value={answers[part.id] ?? ""}
              />
            </label>
            <div className="mt-3 flex flex-wrap items-center gap-2">
              <label className={`inline-flex cursor-pointer rounded-md border border-teal-700 px-3 py-2 text-xs font-medium text-teal-800 ${disabled || uploadingPartId === part.id ? "pointer-events-none opacity-50" : ""}`}>
                {uploadingPartId === part.id ? "图片上传中..." : "上传作答图片"}
                <input
                  accept="image/*"
                  className="sr-only"
                  disabled={disabled || uploadingPartId === part.id}
                  onChange={(event) => {
                    const file = event.target.files?.[0];
                    if (file) {
                      onUpload(part.id, file);
                    }
                    event.target.value = "";
                  }}
                  type="file"
                />
              </label>
              {(attachments[part.id] ?? []).map((url, index) => (
                <span className="inline-flex items-center gap-2 rounded-md bg-slate-100 px-2.5 py-1.5 text-xs text-slate-700" key={url}>
                  <a className="text-teal-700" href={url} rel="noreferrer" target="_blank">图片 {index + 1}</a>
                  {!disabled && <button className="font-medium text-slate-500 hover:text-red-700" onClick={() => onRemoveAttachment(part.id, url)} type="button">移除</button>}
                </span>
              ))}
              {part.responseMode === "IMAGE" && <span className="text-xs text-slate-500">图片作答可不填写文字说明。</span>}
            </div>
            {grade?.latestScore !== null && grade?.latestScore !== undefined && (
              <div className="mt-4 rounded-md bg-teal-50 p-3 text-sm text-teal-900">
                得分 {grade.latestScore} / {part.score} {grade.latestFeedback ? `· ${grade.latestFeedback}` : ""}
              </div>
            )}
          </section>
        );
      })}
    </div>
  );
}

function Badge({ children }: { children: React.ReactNode }) {
  return <span className="rounded-md bg-slate-100 px-2.5 py-1 font-medium text-slate-700">{children}</span>;
}

function Row({ label, value }: { label: string; value: string }) {
  return (
    <div className="flex justify-between gap-4">
      <dt className="text-slate-500">{label}</dt>
      <dd className="font-medium">{value}</dd>
    </div>
  );
}

const feedbackIssueOptions: Array<{ value: QuestionFeedbackIssueType; label: string }> = [
  { value: "ANSWER_INCORRECT", label: "答案错误" },
  { value: "EXPLANATION_UNCLEAR", label: "解析不清" },
  { value: "STEM_ERROR", label: "题干有错" },
  { value: "OPTION_ERROR", label: "选项有错" },
  { value: "IMAGE_DISPLAY_ERROR", label: "图片显示异常" },
  { value: "OTHER", label: "其他" },
];

function FeedbackModal({
  description,
  error,
  issueType,
  onClose,
  onDescriptionChange,
  onIssueTypeChange,
  onSubmit,
  submitting,
}: {
  description: string;
  error: string;
  issueType: QuestionFeedbackIssueType;
  onClose: () => void;
  onDescriptionChange: (value: string) => void;
  onIssueTypeChange: (value: QuestionFeedbackIssueType) => void;
  onSubmit: () => void;
  submitting: boolean;
}) {
  return (
    <div
      aria-label="关闭反馈弹窗"
      className="fixed inset-0 z-50 flex items-center justify-center bg-slate-950/45 p-4"
      onClick={onClose}
      role="presentation"
    >
      <section
        aria-labelledby="question-feedback-title"
        aria-modal="true"
        className="w-full max-w-lg rounded-lg bg-white p-5 shadow-xl"
        onClick={(event) => event.stopPropagation()}
        role="dialog"
      >
        <div className="flex items-start justify-between gap-4">
          <div>
            <h2 className="text-lg font-semibold" id="question-feedback-title">反馈题目问题</h2>
            <p className="mt-1 text-sm text-slate-500">请选择问题类型，并简单说明你发现的问题。</p>
          </div>
          <button className="rounded-md border border-slate-200 px-3 py-1.5 text-sm font-medium text-slate-600" disabled={submitting} onClick={onClose} type="button">
            关闭
          </button>
        </div>
        <div className="mt-5 grid gap-4">
          <label className="grid gap-2 text-sm font-medium text-slate-700">
            问题类型
            <select
              className="rounded-md border border-slate-200 px-3 py-2 text-sm font-normal text-slate-950 outline-none focus:border-teal-700"
              onChange={(event) => onIssueTypeChange(event.target.value as QuestionFeedbackIssueType)}
              value={issueType}
            >
              {feedbackIssueOptions.map((option) => (
                <option key={option.value} value={option.value}>{option.label}</option>
              ))}
            </select>
          </label>
          <label className="grid gap-2 text-sm font-medium text-slate-700">
            问题说明
            <textarea
              className="min-h-28 rounded-md border border-slate-200 px-3 py-2 text-sm font-normal leading-6 text-slate-950 outline-none focus:border-teal-700"
              maxLength={1000}
              onChange={(event) => onDescriptionChange(event.target.value)}
              placeholder="例如：解析里说答案是 B，但选项解释更像 C。"
              value={description}
            />
          </label>
          {error && <p className="text-sm font-medium text-red-700">{error}</p>}
          <div className="flex justify-end gap-2">
            <button className="rounded-md border border-slate-200 px-4 py-2 text-sm font-medium text-slate-700" disabled={submitting} onClick={onClose} type="button">
              取消
            </button>
            <button className="rounded-md bg-teal-700 px-4 py-2 text-sm font-medium text-white disabled:bg-slate-300" disabled={submitting} onClick={onSubmit} type="button">
              {submitting ? "提交中..." : "提交反馈"}
            </button>
          </div>
        </div>
      </section>
    </div>
  );
}
