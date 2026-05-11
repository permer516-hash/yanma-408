"use client";

import Link from "next/link";
import { useEffect, useMemo, useState } from "react";
import { ExamPaperSummary, ExamReportOverview, fetchExamPapers, fetchExamReportOverview, getAuth } from "@/app/lib/api";

const paperTypeLabels: Record<string, string> = {
  MOCK: "模拟卷",
  PAST: "真题",
};

export default function ExamsPage() {
  const [papers, setPapers] = useState<ExamPaperSummary[]>([]);
  const [overview, setOverview] = useState<ExamReportOverview | null>(null);
  const [status, setStatus] = useState<"loading" | "success" | "error">("loading");

  useEffect(() => {
    let cancelled = false;
    fetchExamPapers()
      .then((loadedPapers) => {
        if (!cancelled) {
          setPapers(loadedPapers);
          setStatus("success");
        }
      })
      .catch(() => {
        if (!cancelled) {
          setStatus("error");
        }
      });

    return () => {
      cancelled = true;
    };
  }, []);

  useEffect(() => {
    if (!getAuth()) {
      return;
    }
    let cancelled = false;
    fetchExamReportOverview()
      .then((loadedOverview) => {
        if (!cancelled) {
          setOverview(loadedOverview);
        }
      })
      .catch(() => {
        if (!cancelled) {
          setOverview(null);
        }
      });
    return () => {
      cancelled = true;
    };
  }, []);

  const totalQuestions = useMemo(
    () => papers.reduce((sum, paper) => sum + paper.questionCount, 0),
    [papers],
  );

  return (
    <main className="min-h-screen bg-[#f6f8f9] text-slate-950">
      <div className="mx-auto max-w-7xl px-5 py-6">
        <div className="flex flex-col gap-4 border-b border-slate-200 pb-5 md:flex-row md:items-end md:justify-between">
          <div>
            <Link className="text-sm font-medium text-teal-700" href="/">
              返回仪表盘
            </Link>
            <h1 className="mt-3 text-2xl font-semibold">真题套卷</h1>
            <p className="mt-2 text-sm text-slate-500">按套卷组织 408 综合练习，后续接入计时作答和报告。</p>
          </div>
          <div className="grid grid-cols-2 gap-2 text-sm">
            <Metric label="套卷数" value={String(papers.length)} />
            <Metric label="题目数" value={String(totalQuestions)} />
          </div>
        </div>

        <section className="mt-5 grid gap-4 md:grid-cols-2 xl:grid-cols-3">
          {status === "loading" && <StateCard text="正在加载套卷..." />}
          {status === "error" && <StateCard text="套卷列表加载失败，请确认后端已启动。" tone="error" />}
          {status === "success" && papers.length === 0 && <StateCard text="暂无可练习套卷。" />}
          {status === "success" &&
            papers.map((paper) => (
              <article className="rounded-lg border border-slate-200 bg-white p-5" key={paper.id}>
                <div className="flex items-start justify-between gap-4">
                  <div>
                    <span className="rounded-md bg-teal-50 px-2.5 py-1 text-xs font-medium text-teal-800">
                      {paperTypeLabels[paper.paperType] ?? paper.paperType}
                    </span>
                    <h2 className="mt-4 text-lg font-semibold">{paper.title}</h2>
                    <p className="mt-2 text-sm text-slate-500">
                      {paper.questionCount} 题 · {paper.totalScore} 分 · {paper.durationMinutes} 分钟
                    </p>
                  </div>
                  {paper.sourceYear && <span className="text-sm font-medium text-slate-500">{paper.sourceYear}</span>}
                </div>
                <div className="mt-5 flex gap-2">
                  <Link
                    className="rounded-md bg-teal-700 px-3 py-2 text-sm font-medium text-white hover:bg-teal-800"
                    href={`/exams/${paper.id}`}
                  >
                    查看套卷
                  </Link>
                  <button
                    className="rounded-md border border-slate-200 px-3 py-2 text-sm font-medium text-slate-500"
                    disabled
                    type="button"
                  >
                    报告
                  </button>
                </div>
              </article>
            ))}
        </section>

        {overview && (
          <section className="mt-5 grid gap-5 lg:grid-cols-[360px_1fr]">
            <div className="rounded-lg border border-slate-200 bg-white p-5">
              <h2 className="text-base font-semibold">报告总览</h2>
              <div className="mt-4 grid grid-cols-2 gap-2 text-sm">
                <Metric label="交卷次数" value={String(overview.attemptCount)} />
                <Metric label="平均正确率" value={`${overview.averageAccuracyPercent}%`} />
                <Metric label="最高分" value={String(overview.bestScore)} />
                <Metric label="最近正确率" value={`${overview.latestAccuracyPercent}%`} />
              </div>
              <div className="mt-5">
                <h3 className="text-sm font-semibold text-slate-700">趋势分析</h3>
                {overview.trend.length === 0 && <p className="mt-3 text-sm text-slate-500">暂无交卷趋势。</p>}
                {overview.trend.length > 0 && (
                  <div className="mt-3 flex h-36 items-end gap-2 border-b border-slate-200">
                    {overview.trend.slice().reverse().map((point) => (
                      <div className="flex min-w-0 flex-1 flex-col items-center gap-1" key={point.attemptId}>
                        <div
                          className="w-full rounded-t bg-teal-600"
                          style={{ height: `${Math.max(8, point.accuracyPercent)}%` }}
                          title={`${point.paperTitle} ${point.accuracyPercent}%`}
                        />
                        <span className="w-full truncate text-center text-[10px] text-slate-500">{point.accuracyPercent}%</span>
                      </div>
                    ))}
                  </div>
                )}
              </div>
            </div>
            <div className="rounded-lg border border-slate-200 bg-white p-5">
              <h2 className="text-base font-semibold">薄弱题目</h2>
              <div className="mt-4 space-y-3">
                {overview.weakQuestions.length === 0 && <p className="text-sm text-slate-500">暂无套卷错题。</p>}
                {overview.weakQuestions.map((question) => (
                  <div className="rounded-md border border-slate-200 p-3" key={question.questionId}>
                    <p className="line-clamp-1 text-sm font-medium">{question.stem}</p>
                    <p className="mt-1 text-xs text-slate-500">
                      错 {question.wrongCount} 次 · 最近答案 {question.latestWrongAnswer || "未作答"} · 正确答案 {question.correctAnswer}
                    </p>
                  </div>
                ))}
              </div>
            </div>
          </section>
        )}
      </div>
    </main>
  );
}

function Metric({ label, value }: { label: string; value: string }) {
  return (
    <div className="rounded-md border border-slate-200 bg-white px-4 py-3">
      <p className="text-slate-500">{label}</p>
      <p className="mt-1 text-xl font-semibold">{value}</p>
    </div>
  );
}

function StateCard({ text, tone = "default" }: { text: string; tone?: "default" | "error" }) {
  return (
    <div
      className={`rounded-lg border border-slate-200 bg-white p-5 text-sm ${
        tone === "error" ? "text-red-700" : "text-slate-500"
      }`}
    >
      {text}
    </div>
  );
}
