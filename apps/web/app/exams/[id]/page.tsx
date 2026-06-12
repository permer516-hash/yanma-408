"use client";

import Link from "next/link";
import { use, useEffect, useState } from "react";
import {
  ExamAttemptComparison,
  ExamAttemptSummary,
  ExamPaperDetail,
  fetchExamAttemptComparison,
  fetchExamAttemptHistory,
  fetchExamPaperDetail,
} from "@/app/lib/api";
import { QuestionStemMedia, QuestionStemThumbnail } from "@/app/components/question-stem-media";
import { difficultyLabels, subjectLabels, typeLabels } from "@/app/lib/question-labels";
import { formatQuestionText } from "@/app/lib/text-format";

const paperTypeLabels: Record<string, string> = {
  MOCK: "模拟卷",
  MOCK_EXAM: "模拟卷",
  PAST: "真题",
  PAST_EXAM: "真题",
};

export default function ExamDetailPage({ params }: { params: Promise<{ id: string }> }) {
  const { id } = use(params);
  const [paper, setPaper] = useState<ExamPaperDetail | null>(null);
  const [history, setHistory] = useState<ExamAttemptSummary[]>([]);
  const [comparison, setComparison] = useState<ExamAttemptComparison | null>(null);
  const [status, setStatus] = useState<"loading" | "success" | "error">("loading");

  useEffect(() => {
    let cancelled = false;
    fetchExamPaperDetail(id)
      .then((loadedPaper) => {
        if (!cancelled) {
          setPaper(loadedPaper);
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
  }, [id]);

  useEffect(() => {
    let cancelled = false;
    Promise.all([
      fetchExamAttemptHistory(id).catch(() => []),
      fetchExamAttemptComparison(id).catch(() => null),
    ]).then(([loadedHistory, loadedComparison]) => {
      if (!cancelled) {
        setHistory(loadedHistory);
        setComparison(loadedComparison);
      }
    });
    return () => {
      cancelled = true;
    };
  }, [id]);

  return (
    <main className="min-h-screen bg-[#f6f8f9] text-slate-950">
      <div className="mx-auto max-w-7xl px-5 py-6">
        <Link className="text-sm font-medium text-teal-700" href={paper && ["MOCK", "MOCK_EXAM"].includes(paper.paperType) ? "/mock-exams" : "/exams"}>
          返回套卷
        </Link>

        {status === "loading" && <StateLine text="正在加载套卷详情..." />}
        {status === "error" && <StateLine text="套卷详情加载失败，请确认后端已启动。" tone="error" />}

        {paper && (
          <>
            <header className="mt-4 rounded-lg border border-slate-200 bg-white p-5">
              <span className="rounded-md bg-teal-50 px-2.5 py-1 text-xs font-medium text-teal-800">
                {paperTypeLabels[paper.paperType] ?? paper.paperType}
              </span>
              <div className="mt-4 flex flex-col gap-4 md:flex-row md:items-end md:justify-between">
                <div>
                  <h1 className="text-2xl font-semibold">{paper.title}</h1>
                  <p className="mt-2 text-sm text-slate-500">
                    {paper.questionCount} 题 · {paper.totalScore} 分 · {paper.durationMinutes} 分钟
                  </p>
                </div>
                <Link
                  className="rounded-md bg-teal-700 px-4 py-2 text-sm font-medium text-white hover:bg-teal-800"
                  href={`/exams/${paper.id}/attempt`}
                >
                  开始作答
                </Link>
              </div>
            </header>

            <section className="mt-5 overflow-hidden rounded-lg border border-slate-200 bg-white">
              <div className="border-b border-slate-200 bg-slate-50 px-5 py-3 text-sm font-semibold text-slate-600">
                题目清单
              </div>
              {paper.questions.map((question, index) => (
                <Link
                  className="grid gap-3 border-b border-slate-100 px-5 py-4 last:border-b-0 hover:bg-slate-50 lg:grid-cols-[56px_1fr_88px_88px]"
                  href={`/practice/${question.id}`}
                  key={question.id}
                >
                  <span className="text-sm font-semibold text-slate-500">#{index + 1}</span>
                  <div>
                    <QuestionStemMedia
                      className="line-clamp-3 whitespace-pre-wrap text-sm font-medium"
                      compact
                      stem={question.stem}
                      stemFormat={question.stemFormat}
                      stemImageUrl={question.stemImageUrl}
                    />
                    <QuestionStemThumbnail stemImageUrl={question.stemImageUrl} />
                    <p className="mt-1 text-xs text-slate-500">
                      {subjectLabels[question.subjectCode] ?? question.subjectName} · {question.chapterName}
                    </p>
                  </div>
                  <span className="text-sm text-slate-600">{typeLabels[question.type] ?? question.type}</span>
                  <span className="text-sm text-slate-600">
                    {difficultyLabels[question.difficulty] ?? question.difficulty}
                  </span>
                </Link>
              ))}
            </section>

            <section className="mt-5 grid gap-5 lg:grid-cols-[1fr_1fr]">
              <div className="rounded-lg border border-slate-200 bg-white p-5">
                <h2 className="text-base font-semibold">作答历史</h2>
                <div className="mt-4 space-y-3">
                  {history.length === 0 && <p className="text-sm text-slate-500">暂无交卷记录。</p>}
                  {history.slice(0, 5).map((attempt) => (
                    <Link
                      className="block rounded-md border border-slate-200 p-3 text-sm hover:border-teal-700"
                      href={`/exams/${paper.id}/attempt?report=${attempt.id}`}
                      key={attempt.id}
                    >
                      <span className="font-medium">{attempt.scoredPoints} / {attempt.totalScore} 分</span>
                      <span className="ml-3 text-slate-500">正确率 {attempt.accuracyPercent}%</span>
                      <span className="mt-1 block text-xs text-slate-500">
                        {new Date(attempt.submittedAt).toLocaleString()} · 用时 {formatDuration(attempt.durationSeconds)}
                      </span>
                    </Link>
                  ))}
                </div>
              </div>

              <div className="rounded-lg border border-slate-200 bg-white p-5">
                <h2 className="text-base font-semibold">最近两次对比</h2>
                {!comparison && <p className="mt-4 text-sm text-slate-500">至少完成两次后展示对比。</p>}
                {comparison && (
                  <div className="mt-4 space-y-3 text-sm">
                    <div className="grid grid-cols-2 gap-3">
                      <Metric label="分数变化" value={`${comparison.scoreDelta >= 0 ? "+" : ""}${comparison.scoreDelta}`} />
                      <Metric label="正确率变化" value={`${comparison.accuracyDelta >= 0 ? "+" : ""}${comparison.accuracyDelta}%`} />
                    </div>
                    {comparison.questions.map((question) => (
                      <div className="rounded-md border border-slate-200 p-3" key={question.questionId}>
                        <p className="line-clamp-2 whitespace-pre-wrap font-medium">第 {question.sortOrder} 题：{formatQuestionText(question.stem)}</p>
                        <p className="mt-1 text-xs text-slate-500">
                          最近 {question.latestCorrect ? "正确" : "错误"} · 上次 {question.previousCorrect ? "正确" : "错误"}
                        </p>
                      </div>
                    ))}
                  </div>
                )}
              </div>
            </section>
          </>
        )}
      </div>
    </main>
  );
}

function Metric({ label, value }: { label: string; value: string }) {
  return (
    <div className="rounded-md border border-slate-200 p-3">
      <p className="text-xs text-slate-500">{label}</p>
      <p className="mt-1 text-lg font-semibold text-teal-800">{value}</p>
    </div>
  );
}

function formatDuration(seconds: number) {
  const minutes = Math.floor(seconds / 60);
  const rest = seconds % 60;
  return `${String(minutes).padStart(2, "0")}:${String(rest).padStart(2, "0")}`;
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
