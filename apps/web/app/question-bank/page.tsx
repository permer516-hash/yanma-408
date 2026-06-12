"use client";

import Link from "next/link";
import { Suspense, useEffect, useState } from "react";
import { usePathname, useRouter, useSearchParams } from "next/navigation";
import { QuestionPage, searchQuestions } from "@/app/lib/api";
import { QuestionStemMedia, QuestionStemThumbnail } from "@/app/components/question-stem-media";
import { difficultyLabels, sourceLabels, subjectLabels, typeLabels } from "@/app/lib/question-labels";

const subjects = [
  { label: "全部", value: "" },
  { label: "数据结构", value: "DATA_STRUCTURE" },
  { label: "计算机组成与原理", value: "COMPUTER_ORGANIZATION" },
  { label: "操作系统", value: "OPERATING_SYSTEM" },
  { label: "计算机网络", value: "COMPUTER_NETWORK" },
];

export default function QuestionBankPage() {
  return (
    <Suspense fallback={<main className="min-h-screen bg-[#f6f8f9] px-5 py-10 text-sm text-slate-500">正在加载题库...</main>}>
      <QuestionBankPageContent />
    </Suspense>
  );
}

function QuestionBankPageContent() {
  const router = useRouter();
  const pathname = usePathname();
  const searchParams = useSearchParams();
  const activeSubject = searchParams.get("subject") ?? "";
  const keyword = searchParams.get("keyword") ?? "";
  const difficulty = searchParams.get("difficulty") ?? "";
  const source = searchParams.get("source") ?? "";
  const knowledgePoint = searchParams.get("knowledgePoint") ?? "";
  const page = parsePage(searchParams.get("page"));
  const returnHref = `${pathname}${searchParams.toString() ? `?${searchParams.toString()}` : ""}`;
  const [state, setState] = useState<{
    result: QuestionPage | null;
    status: "loading" | "success" | "error";
    error: string;
  }>({
    result: null,
    status: "loading",
    error: "",
  });

  function updateQuery(updates: Record<string, string | number>, options: { resetPage?: boolean } = {}) {
    const next = new URLSearchParams(searchParams.toString());
    for (const [key, value] of Object.entries(updates)) {
      const normalized = String(value);
      if (!normalized || (key === "page" && normalized === "0")) {
        next.delete(key);
      } else {
        next.set(key, normalized);
      }
    }
    if (options.resetPage) {
      next.delete("page");
    }
    setState((current) => ({ ...current, status: "loading", error: "" }));
    const query = next.toString();
    router.replace(query ? `${pathname}?${query}` : pathname, { scroll: false });
  }

  useEffect(() => {
    let cancelled = false;

    searchQuestions({
      subject: activeSubject || undefined,
      keyword,
      difficulty,
      source,
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
  }, [activeSubject, keyword, difficulty, source, knowledgePoint, page]);

  return (
    <main className="min-h-screen bg-[#f6f8f9] text-slate-950">
      <div className="mx-auto max-w-7xl px-5 py-6">
        <div className="flex flex-col gap-4 border-b border-slate-200 pb-5 md:flex-row md:items-end md:justify-between">
          <div>
            <Link className="text-sm font-medium text-teal-700" href="/">
              返回仪表盘
            </Link>
            <h1 className="mt-3 text-2xl font-semibold">题库</h1>
            <p className="mt-2 text-sm text-slate-500">按 408 科目、来源、章节、题型和难度筛选练习题。</p>
          </div>
          <div className="w-28 text-sm">
            <Metric label="当前题量" value={String(state.result?.total ?? 0)} />
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
                  updateQuery({ subject: subject.value }, { resetPage: true });
                }}
                type="button"
              >
                {subject.label}
              </button>
            ))}
          </div>
          <div className="mt-4 grid gap-3 md:grid-cols-[1fr_140px_140px_180px]">
            <input className="field" onChange={(event) => updateQuery({ keyword: event.target.value }, { resetPage: true })} placeholder="搜索题干或解析" value={keyword} />
            <select className="field" onChange={(event) => updateQuery({ difficulty: event.target.value }, { resetPage: true })} value={difficulty}>
              <option value="">全部难度</option>
              <option value="BASIC">简单</option>
              <option value="MEDIUM">中等</option>
              <option value="HARD">困难</option>
            </select>
            <select className="field" onChange={(event) => updateQuery({ source: event.target.value }, { resetPage: true })} value={source}>
              <option value="">全部来源</option>
              <option value="PAST_EXAM">真题</option>
              <option value="MOCK">模拟题</option>
              <option value="ORIGINAL">原创题</option>
            </select>
            <input className="field" onChange={(event) => updateQuery({ knowledgePoint: event.target.value }, { resetPage: true })} placeholder="知识点编码或名称" value={knowledgePoint} />
          </div>
        </section>

        <section className="mt-5 overflow-hidden rounded-lg border border-slate-200 bg-white">
          <div className="grid grid-cols-[88px_1fr_96px_96px_96px_120px] gap-3 border-b border-slate-200 bg-slate-50 px-4 py-3 text-xs font-semibold text-slate-500 max-lg:hidden">
            <span className="flex items-center justify-center text-center">科目</span>
            <span className="flex items-center">题目</span>
            <span className="flex items-center justify-center text-center">来源</span>
            <span className="flex items-center justify-center text-center">题型</span>
            <span className="flex items-center justify-center text-center">难度</span>
            <span className="flex items-center justify-center text-center">知识点</span>
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
                className="grid gap-3 border-b border-slate-100 px-4 py-4 last:border-b-0 hover:bg-slate-50 lg:grid-cols-[88px_1fr_96px_96px_96px_120px] lg:items-center"
                href={`/practice/${question.id}?from=${encodeURIComponent(returnHref)}`}
                key={question.id}
              >
                <span className="flex items-center justify-center text-center text-sm font-medium text-teal-700">
                  {subjectLabels[question.subjectCode] ?? question.subjectName}
                </span>
                <div>
                  <QuestionStemMedia
                    className="line-clamp-3 whitespace-pre-wrap text-sm font-medium"
                    compact
                    linkImage={false}
                    stem={question.stem}
                    stemFormat={question.stemFormat}
                    stemImageUrl={question.stemImageUrl}
                  />
                  <QuestionStemThumbnail stemImageUrl={question.stemImageUrl} />
                  <p className="mt-1 text-xs text-slate-500">
                    {question.chapterName} · {question.sourceYear ?? "无年份"} · {question.score} 分
                  </p>
                </div>
                <span className="flex items-center justify-center text-center text-sm text-slate-600">{sourceLabels[question.source] ?? question.source}</span>
                <span className="flex items-center justify-center text-center text-sm text-slate-600">{typeLabels[question.type] ?? question.type}</span>
                <span className="flex items-center justify-center text-center text-sm text-slate-600">
                  {difficultyLabels[question.difficulty] ?? question.difficulty}
                </span>
                <span className="flex items-center justify-center text-center text-sm text-slate-600">{question.knowledgePoints.join("、")}</span>
              </Link>
            ))}
          {state.status === "success" && state.result && state.result.totalPages > 1 && (
            <div className="flex items-center justify-between border-t border-slate-100 px-4 py-3 text-sm">
              <span className="text-slate-500">第 {state.result.page + 1} / {state.result.totalPages} 页</span>
              <div className="flex gap-2">
                <button className="rounded-md border border-slate-200 px-3 py-2 disabled:opacity-50" disabled={page === 0} onClick={() => updateQuery({ page: Math.max(0, page - 1) })} type="button">上一页</button>
                <button className="rounded-md border border-slate-200 px-3 py-2 disabled:opacity-50" disabled={page + 1 >= state.result.totalPages} onClick={() => updateQuery({ page: page + 1 })} type="button">下一页</button>
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

function parsePage(value: string | null) {
  const parsed = Number(value ?? 0);
  return Number.isInteger(parsed) && parsed > 0 ? parsed : 0;
}

function StateLine({ text, tone = "default" }: { text: string; tone?: "default" | "error" }) {
  return (
    <div className={`px-4 py-10 text-center text-sm ${tone === "error" ? "text-red-700" : "text-slate-500"}`}>
      {text}
    </div>
  );
}
