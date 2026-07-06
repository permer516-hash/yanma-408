"use client";

import Link from "next/link";
import { Suspense, useEffect, useState } from "react";
import { usePathname, useSearchParams } from "next/navigation";
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
  const pathname = usePathname();
  const searchParams = useSearchParams();
  const [filters, setFilters] = useState(() => readFilters(searchParams));
  const [keywordInput, setKeywordInput] = useState(filters.keyword);
  const [knowledgePointInput, setKnowledgePointInput] = useState(filters.knowledgePoint);
  const { subject: activeSubject, keyword, difficulty, source, knowledgePoint, page } = filters;
  const query = buildQuery(filters);
  const returnHref = `${pathname}${query ? `?${query}` : ""}`;
  const [state, setState] = useState<{
    result: QuestionPage | null;
    status: "loading" | "updating" | "success" | "error";
    error: string;
  }>({
    result: null,
    status: "loading",
    error: "",
  });

  function updateFilters(updates: Partial<QuestionBankFilters>, options: { resetPage?: boolean } = {}) {
    setState((current) => ({
      ...current,
      status: current.result ? "updating" : "loading",
      error: "",
    }));
    setFilters((current) => ({
      ...current,
      ...updates,
      page: options.resetPage ? 0 : updates.page ?? current.page,
    }));
  }

  useEffect(() => {
    if (filters.keyword === keywordInput && filters.knowledgePoint === knowledgePointInput) {
      return;
    }
    const timer = window.setTimeout(() => {
      setState((current) => ({
        ...current,
        status: current.result ? "updating" : "loading",
        error: "",
      }));
      setFilters((current) => ({
        ...current,
        keyword: keywordInput,
        knowledgePoint: knowledgePointInput,
        page: 0,
      }));
    }, 300);
    return () => window.clearTimeout(timer);
  }, [filters.keyword, filters.knowledgePoint, keywordInput, knowledgePointInput]);

  useEffect(() => {
    window.history.replaceState(window.history.state, "", query ? `${pathname}?${query}` : pathname);
  }, [pathname, query]);

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
    <main className="app-bg">
      <div className="mx-auto grid max-w-7xl gap-5 px-5 py-6 xl:grid-cols-[1fr_300px] 2xl:px-0">
        <section className="min-w-0">
          <div className="app-panel px-5 py-5">
            <div className="flex flex-col gap-4 md:flex-row md:items-end md:justify-between">
              <div>
                <Link className="text-sm font-medium text-teal-700" href="/">
                  返回仪表盘
                </Link>
                <h1 className="mt-3 text-2xl font-semibold tracking-tight">题库</h1>
                <p className="mt-2 max-w-2xl text-sm leading-6 text-slate-500">按 408 科目、来源、章节、题型和难度筛选练习题，优先把题目做准、复盘做深。</p>
              </div>
              <div className="grid w-full grid-cols-2 gap-3 sm:w-auto">
                <Metric label="当前题量" value={String(state.result?.total ?? 0)} />
                <Metric label="当前页" value={state.result ? `${state.result.page + 1}/${Math.max(1, state.result.totalPages)}` : "--"} />
              </div>
            </div>
          </div>

          <section className="app-panel mt-5 p-4">
            <div className="flex flex-wrap gap-2">
              {subjects.map((subject) => (
                <button
                  className={`rounded-md border px-3 py-2 text-sm font-medium ${
                    activeSubject === subject.value
                      ? "border-teal-700 bg-teal-50 text-teal-900"
                      : "border-slate-200 bg-white text-slate-600 hover:border-teal-600 hover:text-teal-800"
                  }`}
                  key={subject.value}
                  onClick={() => {
                    updateFilters({ subject: subject.value }, { resetPage: true });
                  }}
                  type="button"
                >
                  {subject.label}
                </button>
              ))}
            </div>
            <div className="mt-4 grid gap-3 md:grid-cols-[1fr_140px_140px_180px]">
              <input className="field" onChange={(event) => setKeywordInput(event.target.value)} placeholder="搜索题干或解析" value={keywordInput} />
              <select className="field" onChange={(event) => updateFilters({ difficulty: event.target.value }, { resetPage: true })} value={difficulty}>
                <option value="">全部难度</option>
                <option value="BASIC">简单</option>
                <option value="MEDIUM">中等</option>
                <option value="HARD">困难</option>
              </select>
              <select className="field" onChange={(event) => updateFilters({ source: event.target.value }, { resetPage: true })} value={source}>
                <option value="">全部来源</option>
                <option value="PAST_EXAM">真题</option>
                <option value="MOCK">模拟题</option>
                <option value="ORIGINAL">原创题</option>
              </select>
              <input className="field" onChange={(event) => setKnowledgePointInput(event.target.value)} placeholder="知识点编码或名称" value={knowledgePointInput} />
            </div>
          </section>

          <section className="app-panel mt-5 overflow-hidden">
            <div className="grid grid-cols-[92px_1fr_104px_92px_92px_132px] gap-3 app-table-header px-4 py-3 max-lg:hidden">
              <span className="flex items-center justify-center text-center">科目</span>
              <span className="flex items-center">题目</span>
              <span className="flex items-center justify-center text-center">来源</span>
              <span className="flex items-center justify-center text-center">题型</span>
              <span className="flex items-center justify-center text-center">难度</span>
              <span className="flex items-center justify-center text-center">知识点</span>
            </div>

            {state.status === "loading" && <StateLine text="正在加载题库..." />}
            {state.status === "updating" && state.result && (
              <div aria-live="polite" className="border-b border-teal-100 bg-teal-50/70 px-4 py-2 text-xs font-medium text-teal-800">
                正在更新题目...
              </div>
            )}
            {state.status === "error" && (
              <StateLine text={`${state.error}，请确认后端已启动在 18082 端口。`} tone="error" />
            )}
            {state.status === "success" && (state.result?.items.length ?? 0) === 0 && (
              <StateLine text="当前筛选条件下暂无题目。" />
            )}

            {state.result?.items.map((question) => (
                <Link
                  className="app-row grid gap-3 px-4 py-4 lg:grid-cols-[92px_1fr_104px_92px_92px_132px] lg:items-center"
                  href={`/practice/${question.id}?from=${encodeURIComponent(returnHref)}`}
                  key={question.id}
                >
                  <span className="flex items-center justify-center text-center text-sm font-semibold text-teal-700">
                    {subjectLabels[question.subjectCode] ?? question.subjectName}
                  </span>
                  <div>
                    <QuestionStemMedia
                      className="line-clamp-3 whitespace-pre-wrap text-sm font-semibold leading-6 text-slate-950"
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
            {state.result && state.result.totalPages > 1 && (
              <div className="flex items-center justify-between border-t border-slate-100 bg-white px-4 py-3 text-sm">
                <span className="text-slate-500">第 {state.result.page + 1} / {state.result.totalPages} 页</span>
                <div className="flex gap-2">
                  <button className="app-button-secondary disabled:opacity-50" disabled={page === 0} onClick={() => updateFilters({ page: Math.max(0, page - 1) })} type="button">上一页</button>
                  <button className="app-button-secondary disabled:opacity-50" disabled={page + 1 >= state.result.totalPages} onClick={() => updateFilters({ page: page + 1 })} type="button">下一页</button>
                </div>
              </div>
            )}
          </section>
        </section>

        <aside className="space-y-5">
          <section className="app-panel p-5">
            <h2 className="app-section-title">当前筛选</h2>
            <dl className="mt-4 space-y-3 text-sm">
              <FilterRow label="科目" value={subjects.find((item) => item.value === activeSubject)?.label ?? "全部"} />
              <FilterRow label="难度" value={difficulty ? difficultyLabels[difficulty] ?? difficulty : "全部"} />
              <FilterRow label="来源" value={source ? sourceLabels[source] ?? source : "全部"} />
              <FilterRow label="知识点" value={knowledgePoint || "未限定"} />
            </dl>
          </section>
          <section className="app-panel p-5">
            <h2 className="app-section-title">练习建议</h2>
            <p className="mt-3 text-sm leading-6 text-slate-600">
              先完成一组同科目题目，再进入错题本复盘。遇到答案或解析疑问，可在做题页直接反馈给管理员。
            </p>
            <Link className="mt-4 inline-flex app-button-primary" href={state.result?.items[0] ? `/practice/${state.result.items[0].id}?from=${encodeURIComponent(returnHref)}` : "/question-bank"}>
              开始当前题组
            </Link>
          </section>
        </aside>
      </div>
    </main>
  );
}

function Metric({ label, value }: { label: string; value: string }) {
  return (
    <div className="rounded-lg border border-slate-200 bg-white px-4 py-3 shadow-sm shadow-slate-950/[0.02]">
      <p className="text-xs font-medium text-slate-500">{label}</p>
      <p className="mt-1 text-xl font-semibold tracking-tight text-slate-950">{value}</p>
    </div>
  );
}

function FilterRow({ label, value }: { label: string; value: string }) {
  return (
    <div className="flex justify-between gap-4 border-b border-slate-100 pb-3 last:border-b-0 last:pb-0">
      <dt className="text-slate-500">{label}</dt>
      <dd className="max-w-36 truncate font-medium text-slate-800">{value}</dd>
    </div>
  );
}

function parsePage(value: string | null) {
  const parsed = Number(value ?? 0);
  return Number.isInteger(parsed) && parsed > 0 ? parsed : 0;
}

type QuestionBankFilters = {
  subject: string;
  keyword: string;
  difficulty: string;
  source: string;
  knowledgePoint: string;
  page: number;
};

function readFilters(searchParams: URLSearchParams): QuestionBankFilters {
  return {
    subject: searchParams.get("subject") ?? "",
    keyword: searchParams.get("keyword") ?? "",
    difficulty: searchParams.get("difficulty") ?? "",
    source: searchParams.get("source") ?? "",
    knowledgePoint: searchParams.get("knowledgePoint") ?? "",
    page: parsePage(searchParams.get("page")),
  };
}

function buildQuery(filters: QuestionBankFilters) {
  const query = new URLSearchParams();
  if (filters.subject) query.set("subject", filters.subject);
  if (filters.keyword) query.set("keyword", filters.keyword);
  if (filters.difficulty) query.set("difficulty", filters.difficulty);
  if (filters.source) query.set("source", filters.source);
  if (filters.knowledgePoint) query.set("knowledgePoint", filters.knowledgePoint);
  if (filters.page > 0) query.set("page", String(filters.page));
  return query.toString();
}

function StateLine({ text, tone = "default" }: { text: string; tone?: "default" | "error" }) {
  return (
    <div className={`px-4 py-10 text-center text-sm ${tone === "error" ? "text-red-700" : "text-slate-500"}`}>
      {text}
    </div>
  );
}
