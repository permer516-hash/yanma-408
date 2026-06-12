"use client";

import Link from "next/link";
import { Suspense, use, useEffect, useRef, useState } from "react";
import { useSearchParams } from "next/navigation";
import { fetchQuestionDetail, fetchQuestions, QuestionDetail, submitAnswer, SubmitAnswerResult } from "@/app/lib/api";
import { QuestionStemMedia } from "@/app/components/question-stem-media";
import { difficultyLabels, subjectLabels, typeLabels } from "@/app/lib/question-labels";
import { formatQuestionText } from "@/app/lib/text-format";

export default function PracticePage({ params }: { params: Promise<{ id: string }> }) {
  return (
    <Suspense fallback={<main className="min-h-screen bg-[#f6f8f9] px-5 py-10 text-sm text-slate-500">正在加载题目...</main>}>
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
  const [nextQuestionId, setNextQuestionId] = useState<string | null>(null);
  const [submitting, setSubmitting] = useState(false);
  const [error, setError] = useState("");
  const startedAtRef = useRef<number | null>(null);

  useEffect(() => {
    let cancelled = false;
    startedAtRef.current = Date.now();

    Promise.all([fetchQuestionDetail(id), fetchQuestions()])
      .then(([loadedQuestion, questions]) => {
        if (!cancelled) {
          const currentIndex = questions.findIndex((question) => question.id === id);
          const nextQuestion = currentIndex >= 0 ? questions[currentIndex + 1] : null;
          setQuestion(loadedQuestion);
          setNextQuestionId(nextQuestion?.id ?? null);
          setSelected("");
          setResult(null);
          setError("");
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
    if (!question || !selected) {
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

  return (
    <main className="min-h-screen bg-[#f6f8f9] text-slate-950">
      <div className="mx-auto grid max-w-7xl gap-5 px-5 py-6 xl:grid-cols-[1fr_320px]">
        <section className="rounded-lg border border-slate-200 bg-white">
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
                  className="whitespace-pre-wrap text-xl font-semibold leading-8"
                  stem={question.stem}
                  stemFormat={question.stemFormat}
                  stemImageUrl={question.stemImageUrl}
                />
              </div>

              <div className="mt-6 space-y-3">
                {question.options.map((option) => {
                  const isSelected = selected === option.label;
                  const isAnswer = result && option.label === result.correctAnswer;
                  const isWrongPick = result && isSelected && option.label !== result.correctAnswer;
                  return (
                    <button
                      className={`flex w-full gap-3 rounded-md border px-4 py-3 text-left text-sm ${
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

              <div className="mt-6 flex items-center gap-3">
                <button
                  className="rounded-md bg-teal-700 px-4 py-2 text-sm font-medium text-white disabled:bg-slate-300"
                  disabled={!selected || Boolean(result) || submitting}
                  onClick={handleSubmit}
                  type="button"
                >
                  {submitting ? "提交中..." : "提交答案"}
                </button>
                {result && (
                  <span className={`text-sm font-medium ${result.correct ? "text-green-700" : "text-red-700"}`}>
                    {result.correct ? "回答正确" : `回答错误，正确答案是 ${result.correctAnswer}`}
                  </span>
                )}
              </div>

              {result && (
                <section className="mt-6 rounded-md border border-slate-200 bg-slate-50 p-4">
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
            </div>
          )}
        </section>

        {question && (
          <aside className="space-y-5">
            <section className="rounded-lg border border-slate-200 bg-white p-5">
              <h2 className="text-base font-semibold">知识点</h2>
              <div className="mt-4 flex flex-wrap gap-2">
                {question.knowledgePoints.map((point) => (
                  <span className="rounded-md bg-teal-50 px-2.5 py-1 text-xs font-medium text-teal-800" key={point.id}>
                    {point.name}
                  </span>
                ))}
              </div>
            </section>

            <section className="rounded-lg border border-slate-200 bg-white p-5">
              <h2 className="text-base font-semibold">作答状态</h2>
              <dl className="mt-4 space-y-3 text-sm">
                <Row label="来源" value={question.sourceYear ? `${question.sourceYear} 真题` : "原创题"} />
                <Row label="分值" value={`${question.score} 分`} />
                <Row label="选择" value={selected || "未选择"} />
                <Row label="状态" value={result ? (result.correct ? "正确" : "已归档错题") : "未提交"} />
              </dl>
            </section>
          </aside>
        )}
      </div>
    </main>
  );
}

function normalizeReturnHref(value: string | null) {
  if (!value || !value.startsWith("/question-bank")) {
    return "/question-bank";
  }
  return value;
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
