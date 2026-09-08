"use client";

import Link from "next/link";
import { Suspense, useEffect, useMemo, useState } from "react";
import { usePathname, useRouter, useSearchParams } from "next/navigation";
import { fetchMistakeReviewQueue, fetchMistakes, MistakeSummary, updateMistakeMastery } from "@/app/lib/api";
import { difficultyLabels, subjectLabels, typeLabels } from "@/app/lib/question-labels";
import { formatQuestionText } from "@/app/lib/text-format";
import { PageLoadingState } from "@/app/components/page-loading-state";

const subjects = [
  { label: "全部", value: "" },
  { label: "数据结构", value: "DATA_STRUCTURE" },
  { label: "计算机组成与原理", value: "COMPUTER_ORGANIZATION" },
  { label: "操作系统", value: "OPERATING_SYSTEM" },
  { label: "计算机网络", value: "COMPUTER_NETWORK" },
];

const masteryFilters = [
  { label: "全部", value: "all" },
  { label: "待复习", value: "pending" },
  { label: "已掌握", value: "mastered" },
];

export default function MistakesPage() {
  return (
    <Suspense fallback={<PageLoadingState label="正在加载错题本..." />}>
      <MistakesPageContent />
    </Suspense>
  );
}

function MistakesPageContent() {
  const router = useRouter();
  const pathname = usePathname();
  const searchParams = useSearchParams();
  const activeSubject = searchParams.get("subject") ?? "";
  const activeMastery = searchParams.get("mastery") ?? "all";
  const queueMode = searchParams.get("queue") === "1";
  const [updatingId, setUpdatingId] = useState("");
  const [state, setState] = useState<{
    mistakes: MistakeSummary[];
    status: "loading" | "success" | "error";
    error: string;
  }>({
    mistakes: [],
    status: "loading",
    error: "",
  });

  useEffect(() => {
    let cancelled = false;
    const mastered = activeMastery === "all" ? undefined : activeMastery === "mastered";

    setState((current) => ({ ...current, status: "loading", error: "" }));

    const loader = queueMode
      ? fetchMistakeReviewQueue(activeSubject || undefined)
      : fetchMistakes({ subject: activeSubject || undefined, mastered });
    loader
      .then((mistakes) => {
        if (!cancelled) {
          setState({ mistakes, status: "success", error: "" });
        }
      })
      .catch((err: Error) => {
        if (!cancelled) {
          setState({ mistakes: [], status: "error", error: err.message });
        }
      });

    return () => {
      cancelled = true;
    };
  }, [activeSubject, activeMastery, queueMode]);

  const handleMasteryChange = async (mistake: MistakeSummary, mastered: boolean) => {
    setUpdatingId(mistake.id);
    setState((current) => ({ ...current, error: "" }));
    try {
      await updateMistakeMastery(mistake.id, mastered);
      setState((current) => ({
        ...current,
        mistakes: current.mistakes
          .map((item) => (item.id === mistake.id ? { ...item, mastered } : item))
          .filter((item) => activeMastery === "all" || item.mastered === (activeMastery === "mastered")),
      }));
    } catch (err) {
      setState((current) => ({
        ...current,
        status: "error",
        error: err instanceof Error ? err.message : "掌握状态更新失败",
      }));
    } finally {
      setUpdatingId("");
    }
  };

  function updateQuery(updates: Record<string, string | boolean>) {
    const next = new URLSearchParams(searchParams.toString());
    for (const [key, value] of Object.entries(updates)) {
      const normalized = typeof value === "boolean" ? (value ? "1" : "") : value;
      if (!normalized || (key === "mastery" && normalized === "all")) {
        next.delete(key);
      } else {
        next.set(key, normalized);
      }
    }
    const query = next.toString();
    router.replace(query ? `${pathname}?${query}` : pathname, { scroll: false });
  }

  const stats = useMemo(() => {
    const totalWrongCount = state.mistakes.reduce((sum, mistake) => sum + mistake.wrongCount, 0);
    const pendingCount = state.mistakes.filter((mistake) => !mistake.mastered).length;
    return {
      pendingCount,
      totalWrongCount,
      masteredCount: state.mistakes.length - pendingCount,
    };
  }, [state.mistakes]);

  return (
    <main className="app-bg">
      <div className="app-container">
        <header className="app-page-header">
          <div className="flex flex-col gap-5 md:flex-row md:items-end md:justify-between">
          <div>
            <Link className="text-sm font-medium text-teal-700" href="/">
              返回仪表盘
            </Link>
            <h1 className="app-page-title">错题本</h1>
            <p className="app-page-description">按最近出错时间整理错题，优先回炉高频失分点。</p>
          </div>
          <div className="grid grid-cols-3 gap-2 text-sm max-sm:w-full">
            <Metric label="待复习" value={String(stats.pendingCount)} />
            <Metric label="累计错次" value={String(stats.totalWrongCount)} />
            <Metric label="已掌握" value={String(stats.masteredCount)} />
          </div>
          </div>
        </header>

        <section className="app-filter-bar mt-5 sm:p-5">
          <div className="flex flex-col gap-4 lg:flex-row lg:items-center lg:justify-between">
            <div className="flex flex-wrap gap-2">
              {subjects.map((subject) => (
                <button
                  className={`rounded-md border px-3 py-2 text-sm font-medium ${
                    activeSubject === subject.value
                      ? "border-teal-700 bg-teal-50 text-teal-800"
                      : "border-slate-200 text-slate-600 hover:border-teal-600 hover:text-teal-800"
                  }`}
                  key={subject.value}
                  onClick={() => updateQuery({ subject: subject.value })}
                  type="button"
                >
                  {subject.label}
                </button>
              ))}
            </div>
            <div className="flex flex-wrap gap-2">
              <button
                className={`rounded-md border px-3 py-2 text-sm font-medium ${
                  queueMode
                    ? "border-red-700 bg-red-50 text-red-700"
                    : "border-slate-200 text-slate-600 hover:border-red-600 hover:text-red-700"
                }`}
                onClick={() => updateQuery({ queue: !queueMode })}
                type="button"
              >
                复习队列
              </button>
              {masteryFilters.map((filter) => (
                <button
                  className={`rounded-md border px-3 py-2 text-sm font-medium ${
                    activeMastery === filter.value
                      ? "border-slate-800 bg-slate-100 text-slate-950"
                      : "border-slate-200 text-slate-600 hover:border-slate-500 hover:text-slate-950"
                  }`}
                  key={filter.value}
                  disabled={queueMode}
                  onClick={() => updateQuery({ mastery: filter.value })}
                  type="button"
                >
                  {filter.label}
                </button>
              ))}
            </div>
          </div>
        </section>

        <section className="app-panel mt-5 overflow-hidden">
          <div className="app-table-header grid grid-cols-[104px_minmax(0,1fr)_96px_112px_192px] px-4 py-3 text-center max-xl:hidden">
            <span>科目</span>
            <span>错题</span>
            <span>错次</span>
            <span>最近出错</span>
            <span>复习状态</span>
          </div>

          {state.status === "loading" && <StateLine text="正在加载错题本..." />}
          {state.status === "error" && (
            <StateLine text={`${state.error}，请确认后端已启动在 8081 端口。`} tone="error" />
          )}
          {state.status === "success" && state.mistakes.length === 0 && (
            <div className="px-4 py-12 text-center">
              <p className="text-sm font-medium text-slate-700">当前还没有错题。</p>
              <Link
                className="mt-4 inline-flex rounded-md bg-teal-700 px-4 py-2 text-sm font-medium text-white hover:bg-teal-800"
                href="/question-bank"
              >
                去题库练习
              </Link>
            </div>
          )}

          {state.status === "success" &&
            state.mistakes.map((mistake) => (
              <article
                className="app-row grid gap-3 px-4 py-4 xl:grid-cols-[104px_minmax(0,1fr)_96px_112px_192px] xl:items-center"
                key={mistake.id}
              >
                <div>
                  <p className="text-sm font-medium text-teal-700">
                    {subjectLabels[mistake.subjectCode] ?? mistake.subjectName}
                  </p>
                  <p className="mt-1 text-xs text-slate-500">{mistake.chapterName}</p>
                </div>

                <div>
                  <Link
                    className="line-clamp-2 text-sm font-medium hover:text-teal-800"
                    href={`/practice/${mistake.questionId}`}
                  >
                    {formatQuestionText(mistake.stem)}
                  </Link>
                  <div className="mt-2 flex flex-wrap gap-2">
                    <Tag>{typeLabels[mistake.type] ?? mistake.type}</Tag>
                    <Tag>{difficultyLabels[mistake.difficulty] ?? mistake.difficulty}</Tag>
                    {mistake.knowledgePoints.map((point) => (
                      <Tag key={point}>{point}</Tag>
                    ))}
                  </div>
                </div>

                <div>
                  <p className="text-sm font-semibold text-red-700">{mistake.wrongCount} 次</p>
                  <p className="mt-1 text-xs text-slate-500">{mistake.mastered ? "已掌握" : "待复习"}</p>
                </div>

                <time className="text-sm text-slate-600" dateTime={mistake.latestWrongAt}>
                  {formatDate(mistake.latestWrongAt)}
                </time>

                <div className="flex flex-wrap gap-2">
                  <Link
                    className="app-button-primary inline-flex h-9 items-center justify-center px-3 py-0"
                    href={`/practice/${mistake.questionId}`}
                  >
                    开始复习
                  </Link>
                  <button
                    className="app-button-secondary inline-flex h-9 items-center justify-center px-3 py-0"
                    disabled={updatingId === mistake.id}
                    onClick={() => handleMasteryChange(mistake, !mistake.mastered)}
                    type="button"
                  >
                    {mistake.mastered ? "设为待复习" : "标记掌握"}
                  </button>
                </div>
              </article>
            ))}
        </section>
        {queueMode && state.status === "success" && state.mistakes.length > 0 && (
          <div className="mt-4 rounded-lg border border-red-100 bg-red-50 px-4 py-3 text-sm text-red-800">
            复习队列按“未掌握优先、错次更多优先、越早出错优先”排序。
          </div>
        )}
      </div>
    </main>
  );
}

function Metric({ label, value }: { label: string; value: string }) {
  return (
    <div className="app-stat px-3 py-3 sm:min-w-24 sm:px-4">
      <p className="truncate text-xs text-slate-500">{label}</p>
      <p className="mt-1 text-xl font-semibold text-slate-950">{value}</p>
    </div>
  );
}

function Tag({ children }: { children: React.ReactNode }) {
  return <span className="rounded-md bg-slate-100 px-2 py-1 text-xs font-medium text-slate-600">{children}</span>;
}

function StateLine({ text, tone = "default" }: { text: string; tone?: "default" | "error" }) {
  return (
    <div className={`px-4 py-10 text-center text-sm ${tone === "error" ? "text-red-700" : "text-slate-500"}`}>
      {text}
    </div>
  );
}

function formatDate(value: string) {
  return new Intl.DateTimeFormat("zh-CN", {
    month: "2-digit",
    day: "2-digit",
    hour: "2-digit",
    minute: "2-digit",
  }).format(new Date(value));
}
