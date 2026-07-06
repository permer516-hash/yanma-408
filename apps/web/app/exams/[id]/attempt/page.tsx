"use client";

import Link from "next/link";
import { useSearchParams } from "next/navigation";
import { Suspense, use, useCallback, useEffect, useMemo, useState } from "react";
import {
  ExamAttemptReport,
  ExamAttemptView,
  backfillExamAttemptMistakes,
  fetchExamAttemptReport,
  getAuth,
  startExamAttempt,
  submitExamAttempt,
} from "@/app/lib/api";
import { QuestionStemMedia } from "@/app/components/question-stem-media";
import { difficultyLabels, typeLabels } from "@/app/lib/question-labels";
import { formatQuestionText } from "@/app/lib/text-format";

export default function ExamAttemptPage({ params }: { params: Promise<{ id: string }> }) {
  return (
    <Suspense fallback={<main className="min-h-screen bg-[#f6f8f9] px-5 py-10 text-sm text-slate-500">正在加载套卷...</main>}>
      <ExamAttemptPageContent params={params} />
    </Suspense>
  );
}

function ExamAttemptPageContent({ params }: { params: Promise<{ id: string }> }) {
  const { id } = use(params);
  const searchParams = useSearchParams();
  const reportId = searchParams.get("report");
  const [hasAuth, setHasAuth] = useState<boolean | null>(null);
  const [attempt, setAttempt] = useState<ExamAttemptView | null>(null);
  const [report, setReport] = useState<ExamAttemptReport | null>(null);
  const [answers, setAnswers] = useState<Record<string, string>>({});
  const [currentIndex, setCurrentIndex] = useState(0);
  const [remainingSeconds, setRemainingSeconds] = useState(0);
  const [status, setStatus] = useState<"loading" | "success" | "submitting" | "error">("loading");
  const [message, setMessage] = useState("");
  const [backfillMessage, setBackfillMessage] = useState("");

  const handleSubmit = useCallback(async () => {
    if (!attempt || report) {
      return;
    }
    setStatus("submitting");
    setMessage("");
    try {
      const durationSeconds = Math.max(0, attempt.paper.durationMinutes * 60 - remainingSeconds);
      const submittedReport = await submitExamAttempt(attempt.id, { answers, durationSeconds });
      setReport(submittedReport);
      setStatus("success");
    } catch {
      setStatus("error");
      setMessage("交卷失败，请稍后再试。");
    }
  }, [answers, attempt, remainingSeconds, report]);

  useEffect(() => {
    let cancelled = false;
    Promise.resolve().then(() => {
      if (!cancelled) {
        setHasAuth(Boolean(getAuth()));
      }
    });
    return () => {
      cancelled = true;
    };
  }, []);

  useEffect(() => {
    if (!hasAuth) {
      return;
    }
    let cancelled = false;
    const loader = reportId ? fetchExamAttemptReport(reportId) : startExamAttempt(id);
    loader
      .then((loaded) => {
        if (!cancelled) {
          if ("results" in loaded) {
            setReport(loaded);
          } else {
            setAttempt(loaded);
            setRemainingSeconds(Math.max(0, Math.floor((new Date(loaded.expiresAt).getTime() - Date.now()) / 1000)));
          }
          setStatus("success");
        }
      })
      .catch(() => {
        if (!cancelled) {
          setStatus("error");
          setMessage("套卷作答初始化失败，请确认后端已启动。");
        }
      });
    return () => {
      cancelled = true;
    };
  }, [hasAuth, id, reportId]);

  useEffect(() => {
    if (!attempt || report) {
      return;
    }
    const timer = window.setInterval(() => {
      setRemainingSeconds((current) => Math.max(0, current - 1));
    }, 1000);
    return () => window.clearInterval(timer);
  }, [attempt, report]);

  useEffect(() => {
    if (attempt && remainingSeconds === 0 && !report && status === "success") {
      Promise.resolve().then(() => void handleSubmit());
    }
  }, [attempt, handleSubmit, remainingSeconds, report, status]);

  const currentQuestion = attempt?.paper.questions[currentIndex];
  const answeredCount = useMemo(() => Object.values(answers).filter(Boolean).length, [answers]);

  async function handleBackfillMistakes() {
    if (!report) {
      return;
    }
    setBackfillMessage("");
    try {
      const result = await backfillExamAttemptMistakes(report.id);
      setBackfillMessage(result.createdCount > 0 ? `已回灌 ${result.createdCount} 道错题。` : "本次报告没有新的错题需要回灌。");
    } catch {
      setBackfillMessage("错题回灌失败，请稍后再试。");
    }
  }

  if (hasAuth === false) {
    return (
      <main className="min-h-screen bg-[#f6f8f9] px-5 py-6 text-slate-950">
        <div className="mx-auto max-w-3xl rounded-lg border border-slate-200 bg-white p-6">
          <h1 className="text-xl font-semibold">套卷作答</h1>
          <p className="mt-2 text-sm text-slate-500">登录后可以开始整卷计时练习。</p>
          <Link className="mt-5 inline-flex rounded-md bg-teal-700 px-4 py-2 text-sm font-medium text-white" href="/login">
            去登录
          </Link>
        </div>
      </main>
    );
  }

  return (
    <main className="app-bg">
      <div className="mx-auto max-w-7xl px-4 py-6 sm:px-6 lg:py-8">
        <Link className="text-sm font-medium text-teal-700" href={`/exams/${id}`}>
          返回套卷详情
        </Link>

        {status === "loading" && <StateLine text="正在创建本次作答..." />}
        {message && <StateLine text={message} tone="error" />}

        {attempt && !report && currentQuestion && (
          <div className="mt-5 grid gap-5 lg:grid-cols-[minmax(0,1fr)_300px]">
            <section className="app-panel p-5 sm:p-6">
              <div className="flex flex-col gap-3 border-b border-slate-100 pb-4 md:flex-row md:items-start md:justify-between">
                <div>
                  <h1 className="text-xl font-semibold">{attempt.paper.title}</h1>
                  <p className="mt-1 text-sm text-slate-500">
                    第 {currentIndex + 1} / {attempt.paper.questionCount} 题 · {typeLabels[currentQuestion.type] ?? currentQuestion.type} · {difficultyLabels[currentQuestion.difficulty] ?? currentQuestion.difficulty}
                  </p>
                </div>
                <div className="rounded-md border border-teal-200 bg-teal-50 px-3 py-2 text-sm font-semibold tabular-nums text-teal-800">
                  剩余 {formatDuration(remainingSeconds)}
                </div>
              </div>

              <div className="mt-5">
                <QuestionStemMedia
                  className="whitespace-pre-wrap text-base leading-7"
                  stem={currentQuestion.stem}
                  stemFormat={currentQuestion.stemFormat}
                  stemImageUrl={currentQuestion.stemImageUrl}
                />
              </div>
              <div className="mt-5 grid gap-3">
                {currentQuestion.options.map((option) => {
                  const active = answers[currentQuestion.id] === option.label;
                  return (
                    <button
                      className={`rounded-md border px-4 py-3 text-left text-sm leading-6 transition ${
                        active
                          ? "border-teal-700 bg-teal-50 text-teal-900"
                          : "border-slate-200 bg-white hover:border-teal-700"
                      }`}
                      key={option.id}
                      onClick={() => setAnswers((current) => ({ ...current, [currentQuestion.id]: option.label }))}
                      type="button"
                    >
                      <span className="font-semibold">{option.label}.</span> {option.content}
                    </button>
                  );
                })}
              </div>

              <div className="mt-6 flex flex-wrap items-center justify-between gap-3">
                <button
                  className="app-button-secondary"
                  disabled={currentIndex === 0}
                  onClick={() => setCurrentIndex((current) => Math.max(0, current - 1))}
                  type="button"
                >
                  上一题
                </button>
                <div className="flex items-center gap-2">
                  <button
                    className="app-button-secondary"
                    disabled={currentIndex === attempt.paper.questions.length - 1}
                    onClick={() => setCurrentIndex((current) => Math.min(attempt.paper.questions.length - 1, current + 1))}
                    type="button"
                  >
                    下一题
                  </button>
                  <button
                    className="app-button-primary"
                    disabled={status === "submitting"}
                    onClick={() => void handleSubmit()}
                    type="button"
                  >
                    {status === "submitting" ? "交卷中" : "交卷"}
                  </button>
                </div>
              </div>
            </section>

            <aside className="app-panel h-fit p-5 lg:sticky lg:top-6">
              <h2 className="text-base font-semibold">答题卡</h2>
              <p className="mt-1 text-sm text-slate-500">已答 {answeredCount} / {attempt.paper.questionCount}</p>
              <div className="mt-4 grid grid-cols-5 gap-2">
                {attempt.paper.questions.map((question, index) => (
                  <button
                    className={`h-10 rounded-md border text-sm font-medium ${
                      index === currentIndex
                        ? "border-teal-700 bg-teal-700 text-white"
                        : answers[question.id]
                          ? "border-teal-200 bg-teal-50 text-teal-800"
                          : "border-slate-200 text-slate-600"
                    }`}
                    key={question.id}
                    onClick={() => setCurrentIndex(index)}
                    type="button"
                  >
                    {index + 1}
                  </button>
                ))}
              </div>
            </aside>
          </div>
        )}

        {report && (
          <section className="app-panel mt-5 p-5 sm:p-6">
            <div className="flex flex-col gap-4 border-b border-slate-100 pb-5 md:flex-row md:items-end md:justify-between">
              <div>
                <h1 className="text-3xl font-semibold">套卷报告</h1>
                <p className="mt-2 text-sm text-slate-500">{report.paperTitle}</p>
              </div>
              <div>
                <div className="grid grid-cols-3 gap-3 text-center text-sm">
                  <Metric label="得分" value={`${report.scoredPoints} / ${report.totalScore}`} />
                  <Metric label="正确率" value={`${report.accuracyPercent}%`} />
                  <Metric label="用时" value={formatDuration(report.durationSeconds)} />
                </div>
                <button className="app-button-secondary mt-3 w-full border-teal-700 text-teal-800" onClick={() => void handleBackfillMistakes()} type="button">
                  回灌错题本
                </button>
                {backfillMessage && <p className="mt-2 text-xs text-slate-500">{backfillMessage}</p>}
              </div>
            </div>

            <div className="mt-5 divide-y divide-slate-100">
              {report.results.map((result) => (
                <article className="py-4" key={result.questionId}>
                  <div className="flex flex-col gap-2 md:flex-row md:items-start md:justify-between">
                    <div>
                      <p className="text-sm font-semibold">第 {result.sortOrder} 题</p>
                        <p className="mt-1 whitespace-pre-wrap text-sm text-slate-700">{formatQuestionText(result.stem)}</p>
                    </div>
                    <span className={`rounded-md px-2.5 py-1 text-xs font-medium ${
                      result.correct ? "bg-teal-50 text-teal-800" : "bg-red-50 text-red-700"
                    }`}>
                      {result.correct ? "正确" : "错误"} · {result.earnedScore}/{result.score} 分
                    </span>
                  </div>
                  <p className="mt-3 text-sm text-slate-500">
                    你的答案：{result.submittedAnswer || "未作答"} · 正确答案：{result.correctAnswer}
                  </p>
                  <p className="mt-2 text-sm leading-6 text-slate-600">{result.explanation}</p>
                </article>
              ))}
            </div>
          </section>
        )}
      </div>
    </main>
  );
}

function formatDuration(seconds: number) {
  const minutes = Math.floor(seconds / 60);
  const rest = seconds % 60;
  return `${String(minutes).padStart(2, "0")}:${String(rest).padStart(2, "0")}`;
}

function Metric({ label, value }: { label: string; value: string }) {
  return (
    <div className="rounded-md border border-slate-200 px-4 py-3">
      <p className="text-xs text-slate-500">{label}</p>
      <p className="mt-1 font-semibold text-teal-800">{value}</p>
    </div>
  );
}

function StateLine({ text, tone = "default" }: { text: string; tone?: "default" | "error" }) {
  return (
    <div className={`mt-5 rounded-lg border border-slate-200 bg-white px-5 py-10 text-center text-sm ${
      tone === "error" ? "text-red-700" : "text-slate-500"
    }`}>
      {text}
    </div>
  );
}
