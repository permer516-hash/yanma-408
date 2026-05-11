"use client";

import Link from "next/link";
import { useEffect, useMemo, useState } from "react";
import { QuestionPage, searchQuestions } from "@/app/lib/api";
import { difficultyLabels, subjectLabels, typeLabels } from "@/app/lib/question-labels";

const subjects = [
  { label: "全部", value: "" },
  { label: "数据结构", value: "DATA_STRUCTURE" },
  { label: "计组", value: "COMPUTER_ORGANIZATION" },
  { label: "操作系统", value: "OPERATING_SYSTEM" },
  { label: "计网", value: "COMPUTER_NETWORK" },
];

export default function QuestionBankPage() {
  const [activeSubject, setActiveSubject] = useState("");
  const [keyword, setKeyword] = useState("");
  const [difficulty, setDifficulty] = useState("");
  const [knowledgePoint, setKnowledgePoint] = useState("");
  const [page, setPage] = useState(0);
  const [state, setState] = useState<{
    result: QuestionPage | null;
    status: "loading" | "success" | "error";
    error: string;
  }>({
    result: null,
    status: "loading",
    error: "",
  });

  useEffect(() => {
    let cancelled = false;

    searchQuestions({
      subject: activeSubject || undefined,
      keyword,
      difficulty,
      knowledgePoint,
      page,
      size: 8,
    })
      .then((result) => {
        if (!cancelled) {
          setState({ result, status: "success", error: "" });
        }
      })
      .catch((err: Error) => {
        if (!cancelled) {
          setState({ result: null, status: "error", error: err.message });
        }
      });

    return () => {
      cancelled = true;
    };
  }, [activeSubject, keyword, difficulty, knowledgePoint, page]);

  const totalScore = useMemo(
    () => (state.result?.items ?? []).reduce((sum, question) => sum + Number(question.score), 0),
    [state.result],
  );

  return (
    <main className="min-h-screen bg-[#f6f8f9] text-slate-950">
      <div className="mx-auto max-w-7xl px-5 py-6">
        <div className="flex flex-col gap-4 border-b border-slate-200 pb-5 md:flex-row md:items-end md:justify-between">
          <div>
            <Link className="text-sm font-medium text-teal-700" href="/">
              返回仪表盘
            </Link>
            <h1 className="mt-3 text-2xl font-semibold">题库</h1>
            <p className="mt-2 text-sm text-slate-500">按 408 科目、章节、题型和难度筛选练习题。</p>
          </div>
          <div className="grid grid-cols-2 gap-2 text-sm">
            <Metric label="当前题量" value={String(state.result?.total ?? 0)} />
            <Metric label="总分值" value={String(totalScore)} />
          </div>
        </div>

        <section className="mt-5 rounded-lg border border-slate-200 bg-white p-4">
          <div className="flex flex-wrap gap-2">
            {subjects.map((subject) => (
              <button
                className={`rounded-md border px-3 py-2 text-sm font-medium ${
                  activeSubject === subject.value
                    ? "border-teal-700 bg-teal-50 text-teal-800"
                    : "border-slate-200 text-slate-600 hover:border-teal-600 hover:text-teal-800"
                }`}
                key={subject.value}
                onClick={() => {
                  setState((current) => ({ ...current, status: "loading", error: "" }));
                  setActiveSubject(subject.value);
                  setPage(0);
                }}
                type="button"
              >
                {subject.label}
              </button>
            ))}
          </div>
          <div className="mt-4 grid gap-3 md:grid-cols-[1fr_160px_180px]">
            <input className="field" onChange={(event) => { setKeyword(event.target.value); setPage(0); }} placeholder="搜索题干或解析" value={keyword} />
            <select className="field" onChange={(event) => { setDifficulty(event.target.value); setPage(0); }} value={difficulty}>
              <option value="">全部难度</option>
              <option value="BASIC">基础</option>
              <option value="MEDIUM">中等</option>
              <option value="HARD">困难</option>
            </select>
            <input className="field" onChange={(event) => { setKnowledgePoint(event.target.value); setPage(0); }} placeholder="知识点编码或名称" value={knowledgePoint} />
          </div>
        </section>

        <section className="mt-5 overflow-hidden rounded-lg border border-slate-200 bg-white">
          <div className="grid grid-cols-[88px_1fr_96px_96px_120px] border-b border-slate-200 bg-slate-50 px-4 py-3 text-xs font-semibold text-slate-500 max-lg:hidden">
            <span>科目</span>
            <span>题目</span>
            <span>题型</span>
            <span>难度</span>
            <span>知识点</span>
          </div>

          {state.status === "loading" && <StateLine text="正在加载题库..." />}
          {state.status === "error" && (
            <StateLine text={`${state.error}，请确认后端已启动在 8081 端口。`} tone="error" />
          )}
          {state.status === "success" && (state.result?.items.length ?? 0) === 0 && (
            <StateLine text="当前筛选条件下暂无题目。" />
          )}

          {state.status === "success" &&
            state.result?.items.map((question) => (
              <Link
                className="grid gap-3 border-b border-slate-100 px-4 py-4 last:border-b-0 hover:bg-slate-50 lg:grid-cols-[88px_1fr_96px_96px_120px] lg:items-center"
                href={`/practice/${question.id}`}
                key={question.id}
              >
                <span className="text-sm font-medium text-teal-700">
                  {subjectLabels[question.subjectCode] ?? question.subjectName}
                </span>
                <div>
                  <p className="line-clamp-2 text-sm font-medium">{question.stem}</p>
                  <p className="mt-1 text-xs text-slate-500">
                    {question.chapterName} · {question.sourceYear ?? "原创"} · {question.score} 分
                  </p>
                </div>
                <span className="text-sm text-slate-600">{typeLabels[question.type] ?? question.type}</span>
                <span className="text-sm text-slate-600">
                  {difficultyLabels[question.difficulty] ?? question.difficulty}
                </span>
                <span className="text-sm text-slate-600">{question.knowledgePoints.join("、")}</span>
              </Link>
            ))}
          {state.status === "success" && state.result && state.result.totalPages > 1 && (
            <div className="flex items-center justify-between border-t border-slate-100 px-4 py-3 text-sm">
              <span className="text-slate-500">第 {state.result.page + 1} / {state.result.totalPages} 页</span>
              <div className="flex gap-2">
                <button className="rounded-md border border-slate-200 px-3 py-2 disabled:opacity-50" disabled={page === 0} onClick={() => setPage((current) => Math.max(0, current - 1))} type="button">上一页</button>
                <button className="rounded-md border border-slate-200 px-3 py-2 disabled:opacity-50" disabled={page + 1 >= state.result.totalPages} onClick={() => setPage((current) => current + 1)} type="button">下一页</button>
              </div>
            </div>
          )}
        </section>
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

function StateLine({ text, tone = "default" }: { text: string; tone?: "default" | "error" }) {
  return (
    <div className={`px-4 py-10 text-center text-sm ${tone === "error" ? "text-red-700" : "text-slate-500"}`}>
      {text}
    </div>
  );
}
