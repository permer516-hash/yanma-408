"use client";

import Link from "next/link";
import { Suspense, useEffect, useMemo, useState } from "react";
import { usePathname, useRouter, useSearchParams } from "next/navigation";
import { QuestionPage, QuestionSummary, searchQuestions } from "@/app/lib/api";
import { difficultyLabels, subjectLabels } from "@/app/lib/question-labels";

const subjects = [
  { label: "全部", value: "" },
  { label: "数据结构", value: "DATA_STRUCTURE" },
  { label: "计算机组成与原理", value: "COMPUTER_ORGANIZATION" },
  { label: "操作系统", value: "OPERATING_SYSTEM" },
  { label: "计算机网络", value: "COMPUTER_NETWORK" },
];

type ChapterGroup = {
  key: string;
  subjectCode: string;
  subjectName: string;
  chapterName: string;
  questions: QuestionSummary[];
  totalScore: number;
  knowledgePoints: string[];
  difficulties: string[];
};

export default function ChaptersPage() {
  return (
    <Suspense fallback={<main className="min-h-screen bg-[#f6f8f9] px-5 py-10 text-sm text-slate-500">正在加载章节练习...</main>}>
      <ChaptersPageContent />
    </Suspense>
  );
}

function ChaptersPageContent() {
  const router = useRouter();
  const pathname = usePathname();
  const searchParams = useSearchParams();
  const activeSubject = searchParams.get("subject") ?? "";
  const [state, setState] = useState<{
    result: QuestionPage | null;
    status: "loading" | "success" | "error";
    error: string;
  }>({
    result: null,
    status: "loading",
    error: "",
  });

  function updateSubject(subject: string) {
    const next = new URLSearchParams(searchParams.toString());
    if (subject) {
      next.set("subject", subject);
    } else {
      next.delete("subject");
    }
    setState((current) => ({ ...current, status: "loading", error: "" }));
    const query = next.toString();
    router.replace(query ? `${pathname}?${query}` : pathname, { scroll: false });
  }

  useEffect(() => {
    let cancelled = false;

    searchQuestions({
      subject: activeSubject || undefined,
      page: 0,
      size: 200,
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
  }, [activeSubject]);

  const chapters = useMemo(() => groupByChapter(state.result?.items ?? []), [state.result]);

  return (
    <main className="min-h-screen bg-[#f6f8f9] text-slate-950">
      <div className="mx-auto max-w-7xl px-5 py-6">
        <div className="flex flex-col gap-4 border-b border-slate-200 pb-5 md:flex-row md:items-end md:justify-between">
          <div>
            <Link className="text-sm font-medium text-teal-700" href="/">
              返回仪表盘
            </Link>
            <h1 className="mt-3 text-2xl font-semibold">章节练习</h1>
            <p className="mt-2 text-sm text-slate-500">按 408 科目和章节组织题目，适合逐章刷题和查漏补缺。</p>
          </div>
          <div className="grid grid-cols-2 gap-2 text-sm">
            <Metric label="章节数" value={String(chapters.length)} />
            <Metric label="题目数" value={String(state.result?.total ?? 0)} />
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
                  updateSubject(subject.value);
                }}
                type="button"
              >
                {subject.label}
              </button>
            ))}
          </div>
        </section>

        {state.status === "loading" && <StateLine text="正在加载章节练习..." />}
        {state.status === "error" && <StateLine text={`${state.error}，请确认后端服务已启动。`} tone="error" />}
        {state.status === "success" && chapters.length === 0 && <StateLine text="当前科目下暂无章节题目。" />}

        {state.status === "success" && chapters.length > 0 && (
          <section className="mt-5 grid gap-4 md:grid-cols-2">
            {chapters.map((chapter) => (
              <article className="rounded-lg border border-slate-200 bg-white p-5" key={chapter.key}>
                <div className="flex items-start justify-between gap-4">
                  <div>
                    <p className="text-sm font-medium text-teal-700">
                      {subjectLabels[chapter.subjectCode] ?? chapter.subjectName}
                    </p>
                    <h2 className="mt-2 text-lg font-semibold">{chapter.chapterName}</h2>
                    <p className="mt-2 text-sm text-slate-500">
                      {chapter.questions.length} 题 · {chapter.totalScore} 分 · {chapter.difficulties.join(" / ")}
                    </p>
                  </div>
                  <Link
                    className="shrink-0 rounded-md bg-teal-700 px-3 py-2 text-sm font-medium text-white hover:bg-teal-800"
                    href={`/practice/${chapter.questions[0].id}`}
                  >
                    开始练习
                  </Link>
                </div>
                <div className="mt-4 flex flex-wrap gap-2">
                  {chapter.knowledgePoints.slice(0, 6).map((point) => (
                    <span className="rounded-md bg-slate-100 px-2.5 py-1 text-xs font-medium text-slate-600" key={point}>
                      {point}
                    </span>
                  ))}
                </div>
              </article>
            ))}
          </section>
        )}
      </div>
    </main>
  );
}

function groupByChapter(questions: QuestionSummary[]) {
  const groups = new Map<string, ChapterGroup>();

  questions.forEach((question) => {
    const key = `${question.subjectCode}:${question.chapterName}`;
    const group = groups.get(key) ?? {
      key,
      subjectCode: question.subjectCode,
      subjectName: question.subjectName,
      chapterName: question.chapterName,
      questions: [],
      totalScore: 0,
      knowledgePoints: [],
      difficulties: [],
    };

    group.questions.push(question);
    group.totalScore += Number(question.score);
    group.knowledgePoints = unique([...group.knowledgePoints, ...question.knowledgePoints]);
    group.difficulties = unique([
      ...group.difficulties,
      difficultyLabels[question.difficulty] ?? question.difficulty,
    ]);
    groups.set(key, group);
  });

  return Array.from(groups.values());
}

function unique(values: string[]) {
  return Array.from(new Set(values.filter(Boolean)));
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
    <div className={`mt-5 rounded-lg bg-white px-4 py-10 text-center text-sm ${tone === "error" ? "text-red-700" : "text-slate-500"}`}>
      {text}
    </div>
  );
}
