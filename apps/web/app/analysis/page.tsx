"use client";

import Link from "next/link";
import { useEffect, useMemo, useState } from "react";
import { StudyDashboard, fetchStudyDashboard, getAuth } from "@/app/lib/api";
import { subjectLabels } from "@/app/lib/question-labels";

export default function AnalysisPage() {
  const [hasAuth, setHasAuth] = useState<boolean | null>(null);
  const [dashboard, setDashboard] = useState<StudyDashboard | null>(null);
  const [status, setStatus] = useState<"loading" | "success" | "error">("loading");

  useEffect(() => {
    let cancelled = false;
    Promise.resolve().then(() => {
      if (cancelled) {
        return;
      }
      const auth = Boolean(getAuth());
      setHasAuth(auth);
      if (!auth) {
        return;
      }
      fetchStudyDashboard().then((loaded) => {
        if (!cancelled) {
          setDashboard(loaded);
          setStatus("success");
        }
      }).catch(() => {
        if (!cancelled) {
          setStatus("error");
        }
      });
    });
    return () => {
      cancelled = true;
    };
  }, []);

  const weakestSubject = useMemo(() => {
    return dashboard?.subjectMasteries
      .filter((item) => item.practicedCount > 0)
      .sort((a, b) => a.masteryPercent - b.masteryPercent)[0];
  }, [dashboard]);

  if (hasAuth === false) {
    return (
      <main className="min-h-screen bg-[#f6f8f9] px-5 py-6 text-slate-950">
        <div className="mx-auto max-w-3xl rounded-lg border border-slate-200 bg-white p-6">
          <h1 className="text-xl font-semibold">学习分析</h1>
          <p className="mt-2 text-sm text-slate-500">登录后可以查看学习分析。</p>
          <Link className="mt-5 inline-flex rounded-md bg-teal-700 px-4 py-2 text-sm font-medium text-white" href="/login">
            去登录
          </Link>
        </div>
      </main>
    );
  }

  return (
    <main className="min-h-screen bg-[#f6f8f9] text-slate-950">
      <div className="mx-auto max-w-7xl px-5 py-6">
        <Link className="text-sm font-medium text-teal-700" href="/">
          返回仪表盘
        </Link>
        <header className="mt-4 border-b border-slate-200 pb-5">
          <h1 className="text-2xl font-semibold">学习分析</h1>
          <p className="mt-2 text-sm text-slate-500">从正确率、掌握度和薄弱知识点判断下一轮复习重点。</p>
        </header>

        {status === "loading" && <StateLine text="正在加载学习分析..." />}
        {status === "error" && <StateLine text="学习分析加载失败。" tone="error" />}

        {dashboard && (
          <>
            <section className="mt-5 grid gap-3 md:grid-cols-4">
              <Metric label="今日完成" value={`${dashboard.todayGoal.completedCount}/${dashboard.todayGoal.targetCount}`} />
              <Metric label="连续学习" value={`${dashboard.continuousStudy.days} 天`} />
              <Metric label="本周正确率" value={`${dashboard.weeklyAccuracy.percent}%`} />
              <Metric label="最弱科目" value={weakestSubject ? subjectLabels[weakestSubject.subjectCode] ?? weakestSubject.subjectName : "暂无"} />
            </section>

            <section className="mt-5 grid gap-5 lg:grid-cols-[1fr_1fr]">
              <div className="rounded-lg border border-slate-200 bg-white p-5">
                <h2 className="text-base font-semibold">四科掌握度</h2>
                <div className="mt-4 space-y-4">
                  {dashboard.subjectMasteries.map((item) => (
                    <div key={item.subjectCode}>
                      <div className="flex items-center justify-between text-sm">
                        <span className="font-medium">{subjectLabels[item.subjectCode] ?? item.subjectName}</span>
                        <span className="text-slate-500">{item.masteryPercent}% · {item.practicedCount} 题</span>
                      </div>
                      <div className="mt-2 h-2 rounded-full bg-slate-100">
                        <div className="h-2 rounded-full bg-teal-700" style={{ width: `${item.masteryPercent}%` }} />
                      </div>
                      <p className="mt-1 text-xs text-slate-500">薄弱点：{item.weakestKnowledgePoint}</p>
                    </div>
                  ))}
                </div>
              </div>

              <div className="rounded-lg border border-slate-200 bg-white p-5">
                <h2 className="text-base font-semibold">薄弱知识点</h2>
                <div className="mt-4 space-y-3">
                  {dashboard.weakKnowledgePoints.length === 0 && <p className="text-sm text-slate-500">暂无薄弱知识点。</p>}
                  {dashboard.weakKnowledgePoints.map((point) => (
                    <div className="rounded-md border border-slate-200 p-3" key={point.id}>
                      <div className="flex items-center justify-between gap-3">
                        <p className="text-sm font-medium">{point.name}</p>
                        <span className="text-xs text-red-700">错 {point.wrongCount} 次</span>
                      </div>
                      <p className="mt-1 text-xs text-slate-500">
                        {subjectLabels[point.subjectCode] ?? point.subjectName} · 待复习 {point.pendingMistakeCount} 题
                      </p>
                    </div>
                  ))}
                </div>
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
    <div className="rounded-lg border border-slate-200 bg-white p-4">
      <p className="text-sm text-slate-500">{label}</p>
      <p className="mt-2 text-2xl font-semibold text-teal-800">{value}</p>
    </div>
  );
}

function StateLine({ text, tone = "default" }: { text: string; tone?: "default" | "error" }) {
  return <div className={`mt-5 rounded-lg border border-slate-200 bg-white p-8 text-center text-sm ${tone === "error" ? "text-red-700" : "text-slate-500"}`}>{text}</div>;
}
