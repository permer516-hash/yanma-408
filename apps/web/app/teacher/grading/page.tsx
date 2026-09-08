"use client";

import Link from "next/link";
import { useCallback, useEffect, useState } from "react";
import {
  ComprehensiveGradingQueueItem,
  CurrentUser,
  fetchCurrentUser,
  fetchPendingComprehensiveGrading,
  gradeComprehensiveAttempt,
} from "@/app/lib/api";
import { QuestionStemMedia } from "@/app/components/question-stem-media";

type GradeDraft = Record<string, { score: string; feedback: string }>;

export default function TeacherComprehensiveGradingPage() {
  const [access, setAccess] = useState<"checking" | "login" | "denied" | "allowed">("checking");
  const [queue, setQueue] = useState<ComprehensiveGradingQueueItem[]>([]);
  const [selectedAttemptId, setSelectedAttemptId] = useState<string | null>(null);
  const [grades, setGrades] = useState<GradeDraft>({});
  const [note, setNote] = useState("");
  const [loading, setLoading] = useState(true);
  const [submitting, setSubmitting] = useState(false);
  const [message, setMessage] = useState("");

  const loadQueue = useCallback(async () => {
    setLoading(true);
    try {
      const items = await fetchPendingComprehensiveGrading();
      setQueue(items);
      const next = items[0] ?? null;
      setSelectedAttemptId(next?.attemptId ?? null);
      setGrades(next ? createGradeDraft(next) : {});
      setNote("");
    } catch (error) {
      setMessage(error instanceof Error ? error.message : "综合题评分队列加载失败");
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    fetchCurrentUser()
      .then(async (user) => {
        if (!canGrade(user)) {
          setAccess("denied");
          return;
        }
        setAccess("allowed");
        await loadQueue();
      })
      .catch(() => setAccess("login"));
  }, [loadQueue]);

  const selected = queue.find((item) => item.attemptId === selectedAttemptId) ?? null;

  function selectAttempt(item: ComprehensiveGradingQueueItem) {
    setSelectedAttemptId(item.attemptId);
    setGrades(createGradeDraft(item));
    setNote("");
  }

  async function handleGrade() {
    if (!selected) {
      return;
    }
    const gradeEntries = selected.question.comprehensiveParts.map((part) => ({
      partId: part.id,
      score: Number(grades[part.id]?.score),
      feedback: grades[part.id]?.feedback ?? "",
    }));
    if (gradeEntries.some((grade) => !Number.isFinite(grade.score) || grade.score < 0)) {
      setMessage("请为每个小问填写 0 到该小问满分之间的得分。");
      return;
    }
    setSubmitting(true);
    setMessage("");
    try {
      await gradeComprehensiveAttempt({ attemptId: selected.attemptId, grades: gradeEntries, note });
      setMessage("人工评分已定稿，学生可以查看结果。");
      await loadQueue();
    } catch (error) {
      setMessage(error instanceof Error ? error.message : "综合题人工评分失败");
    } finally {
      setSubmitting(false);
    }
  }

  if (access === "checking") {
    return <StatePage text="正在校验评分权限..." title="综合题评分" />;
  }
  if (access === "login") {
    return <StatePage actionHref="/login" actionLabel="去登录" text="登录后可以处理综合题人工评分。" title="综合题评分" />;
  }
  if (access === "denied") {
    return <StatePage actionHref="/" actionLabel="返回仪表盘" text="当前账号没有综合题评分权限。" title="综合题评分" />;
  }

  return (
    <main className="app-bg text-slate-950">
      <div className="app-container">
        <header className="app-page-header">
          <Link className="text-sm font-medium text-teal-700" href="/teacher/students">返回学生学情</Link>
          <div className="mt-3 flex flex-wrap items-center justify-between gap-4">
            <div>
              <h1 className="app-page-title text-2xl sm:text-3xl">综合题评分</h1>
              <p className="app-page-description">仅展示自己班级学生待人工评分或申请复核的作答。</p>
            </div>
            <button className="app-button-secondary" onClick={() => void loadQueue()} type="button">刷新队列</button>
          </div>
        </header>

        {message && <p aria-live="polite" className="mt-5 rounded-md border border-slate-200 bg-white px-4 py-3 text-sm font-medium text-slate-700">{message}</p>}
        {loading ? (
          <section className="app-panel-flat mt-5 p-6 text-sm text-slate-500">正在加载评分队列...</section>
        ) : queue.length === 0 ? (
          <section className="app-panel-flat mt-5 p-6 text-sm text-slate-500">当前没有待评分的综合题。</section>
        ) : (
          <div className="mt-5 grid items-start gap-5 xl:grid-cols-[300px_minmax(0,1fr)]">
            <aside className="app-panel h-fit overflow-hidden xl:sticky xl:top-6">
              <div className="flex items-center justify-between border-b border-slate-200 px-4 py-3">
                <h2 className="text-sm font-semibold text-slate-800">待评分作答</h2>
                <span className="text-xs text-slate-500">{queue.length} 份</span>
              </div>
              <div className="xl:max-h-[calc(100vh-180px)] xl:overflow-y-auto">
              {queue.map((item) => {
                const isSelected = item.attemptId === selectedAttemptId;
                return (
                <button
                  aria-current={isSelected ? "true" : undefined}
                  className={`w-full border-b border-l-2 border-l-transparent border-slate-100 px-4 py-4 text-left last:border-b-0 ${isSelected ? "border-l-teal-700 bg-teal-50" : "hover:bg-slate-50"}`}
                  key={item.attemptId}
                  onClick={() => selectAttempt(item)}
                  type="button"
                >
                  <p className="font-medium text-slate-900">{item.studentDisplayName}</p>
                  <p className="mt-1 text-xs text-slate-500">@{item.studentUsername} · {item.attempt.status === "REVIEW_REQUESTED" ? "申请复核" : "待人工评分"}</p>
                  <p className="mt-2 line-clamp-2 text-sm text-slate-700">{item.question.stem}</p>
                </button>
                );
              })}
              </div>
            </aside>

            {selected && (
              <section className="app-panel p-5 sm:p-6">
                <div className="flex flex-wrap items-start justify-between gap-3 border-b border-slate-200 pb-4">
                  <div>
                    <h2 className="text-lg font-semibold">{selected.studentDisplayName} 的作答</h2>
                    <p className="mt-1 text-sm text-slate-500">@{selected.studentUsername} · {selected.question.score} 分 · 用时 {Math.ceil(selected.attempt.elapsedSeconds / 60)} 分钟</p>
                  </div>
                  <span className="rounded-md bg-amber-50 px-2.5 py-1 text-xs font-medium text-amber-800">{selected.attempt.status === "REVIEW_REQUESTED" ? "申请复核" : "待人工评分"}</span>
                </div>
                <QuestionStemMedia
                  className="mt-5 whitespace-pre-wrap text-base font-semibold leading-7"
                  stem={selected.question.stem}
                  stemFormat={selected.question.stemFormat}
                  stemImageUrl={selected.question.stemImageUrl}
                />
                <div className="mt-6 space-y-5">
                  {selected.question.comprehensiveParts.map((part) => {
                    const response = selected.attempt.responses.find((item) => item.partId === part.id);
                    const draft = grades[part.id] ?? { score: "", feedback: "" };
                    return (
                      <section className="rounded-md border border-slate-200 bg-white p-4" key={part.id}>
                        <div className="flex flex-wrap items-start justify-between gap-3">
                          <div>
                            <h3 className="font-semibold">第 {part.sortOrder} 问</h3>
                            <p className="mt-2 whitespace-pre-wrap text-sm leading-7 text-slate-800">{part.prompt}</p>
                          </div>
                          <span className="rounded-md bg-slate-100 px-2 py-1 text-xs font-medium text-slate-600">满分 {part.score}</span>
                        </div>
                        <div className="mt-4 grid gap-4 lg:grid-cols-2">
                          <div className="rounded-md border border-slate-100 bg-slate-50/80 p-3">
                            <p className="text-xs font-semibold text-slate-600">学生作答</p>
                            <p className="mt-2 whitespace-pre-wrap text-sm leading-7 text-slate-800">{response?.content || "未填写文字答案"}</p>
                            {response?.attachmentUrls.map((url) => <a className="mt-2 block text-xs text-teal-700" href={url} key={url} rel="noreferrer" target="_blank">查看作答附件</a>)}
                          </div>
                          <div className="rounded-md border border-teal-100 bg-teal-50/50 p-3">
                            <p className="text-xs font-semibold text-teal-800">标准答案与评分点</p>
                            <p className="mt-2 whitespace-pre-wrap text-sm leading-7 text-slate-800">{part.referenceAnswer}</p>
                            <ul className="mt-3 space-y-1 text-xs text-slate-600">
                              {part.rubrics.map((rubric) => <li key={rubric.id}>{rubric.criterion} · {rubric.score} 分</li>)}
                            </ul>
                          </div>
                        </div>
                        <div className="mt-4 grid gap-3 md:grid-cols-[120px_1fr]">
                          <label className="grid gap-1 text-xs font-medium text-slate-600">得分
                            <input
                              className="field h-10 text-right"
                              max={part.score}
                              min={0}
                              onChange={(event) => setGrades((current) => ({ ...current, [part.id]: { ...draft, score: event.target.value } }))}
                              type="number"
                              value={draft.score}
                            />
                          </label>
                          <label className="grid gap-1 text-xs font-medium text-slate-600">评分反馈
                            <textarea
                              className="field min-h-20 text-sm"
                              onChange={(event) => setGrades((current) => ({ ...current, [part.id]: { ...draft, feedback: event.target.value } }))}
                              placeholder="说明得分依据、遗漏点和改进建议"
                              value={draft.feedback}
                            />
                          </label>
                        </div>
                      </section>
                    );
                  })}
                </div>
                <label className="mt-5 grid gap-2 border-t border-slate-100 pt-5 text-sm font-medium text-slate-700">整体评语或复核回复（可选）
                  <textarea className="field min-h-24 font-normal" onChange={(event) => setNote(event.target.value)} value={note} />
                </label>
                <button className="app-button-primary mt-4" disabled={submitting} onClick={() => void handleGrade()} type="button">
                  {submitting ? "定稿中..." : "提交人工评分并定稿"}
                </button>
              </section>
            )}
          </div>
        )}
      </div>
    </main>
  );
}

function canGrade(user: CurrentUser) {
  return user.roles.includes("ADMIN") || user.roles.includes("TEACHER");
}

function createGradeDraft(item: ComprehensiveGradingQueueItem): GradeDraft {
  return Object.fromEntries(item.question.comprehensiveParts.map((part) => [part.id, { score: "", feedback: "" }]));
}

function StatePage({ title, text, actionHref, actionLabel }: { title: string; text: string; actionHref?: string; actionLabel?: string }) {
  return (
    <main className="app-bg">
      <section className="app-container max-w-3xl">
        <div className="app-page-header">
        <h1 className="app-page-title text-xl sm:text-xl">{title}</h1>
        <p className="mt-2 text-sm text-slate-500">{text}</p>
        {actionHref && actionLabel && <Link className="mt-5 inline-flex app-button-primary" href={actionHref}>{actionLabel}</Link>}
        </div>
      </section>
    </main>
  );
}
