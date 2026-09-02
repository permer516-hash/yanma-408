"use client";

import Link from "next/link";
import { useCallback, useEffect, useState } from "react";
import { CurrentUser, RecruitmentLeadPage, fetchCurrentUser, fetchRecruitmentLeads, getAuth } from "@/app/lib/api";

const stageLabels: Record<string, string> = {
  NOT_STARTED: "尚未开始",
  FIRST_ROUND: "一轮复习",
  SECOND_ROUND: "二轮强化",
  REVIEWING: "冲刺复盘",
};

const subjectLabels: Record<string, string> = {
  DATA_STRUCTURE: "数据结构",
  COMPUTER_ORGANIZATION: "计算机组成原理",
  OPERATING_SYSTEM: "操作系统",
  COMPUTER_NETWORK: "计算机网络",
};

export default function RecruitmentLeadsPage() {
  const [access, setAccess] = useState<"checking" | "login" | "denied" | "allowed">("checking");
  const [leadPage, setLeadPage] = useState<RecruitmentLeadPage | null>(null);
  const [status, setStatus] = useState<"loading" | "success" | "error">("loading");
  const [page, setPage] = useState(0);

  const load = useCallback(async () => {
    setStatus("loading");
    try {
      setLeadPage(await fetchRecruitmentLeads({ page, size: 30 }));
      setStatus("success");
    } catch {
      setStatus("error");
    }
  }, [page]);

  useEffect(() => {
    let cancelled = false;
    Promise.resolve().then(async () => {
      if (!getAuth()) {
        if (!cancelled) setAccess("login");
        return;
      }
      try {
        const user: CurrentUser = await fetchCurrentUser();
        if (cancelled) return;
        if (!user.roles.includes("ADMIN")) {
          setAccess("denied");
          return;
        }
        setAccess("allowed");
      } catch {
        if (!cancelled) setAccess("login");
      }
    });
    return () => {
      cancelled = true;
    };
  }, []);

  useEffect(() => {
    if (access === "allowed") {
      void Promise.resolve().then(load);
    }
  }, [access, load]);

  if (access === "checking") return <StatePage title="招生线索" text="正在校验管理权限..." />;
  if (access === "login") return <StatePage actionHref="/login" actionLabel="去登录" title="招生线索" text="请先登录管理员账号。" />;
  if (access === "denied") return <StatePage actionHref="/" actionLabel="返回仪表盘" title="招生线索" text="当前账号没有查看招生线索的权限。" />;

  return (
    <main className="app-bg">
      <div className="mx-auto max-w-7xl px-4 py-6 sm:px-6 lg:py-8">
        <header className="app-panel px-5 py-5 sm:px-6 sm:py-6">
          <Link className="text-sm font-medium text-teal-700" href="/">返回仪表盘</Link>
          <div className="mt-3 flex flex-wrap items-end justify-between gap-4">
            <div>
              <h1 className="text-3xl font-semibold">招生线索</h1>
              <p className="mt-2 text-sm text-slate-500">来自公开学情自测与预约诊断表单，仅管理员可查看联系方式。</p>
            </div>
            <p className="text-sm text-slate-500">{leadPage ? `共 ${leadPage.total} 条待跟进` : ""}</p>
          </div>
        </header>

        <section className="app-panel mt-5 overflow-hidden">
          {status === "loading" && <p className="p-6 text-sm text-slate-500">正在加载招生线索...</p>}
          {status === "error" && <p className="p-6 text-sm text-red-800">招生线索加载失败，请稍后刷新重试。</p>}
          {status === "success" && leadPage?.items.length === 0 && <p className="p-6 text-sm text-slate-500">还没有新的诊断预约。</p>}
          {status === "success" && leadPage && leadPage.items.length > 0 && (
            <>
              <div className="overflow-x-auto">
                <table className="min-w-[860px] w-full text-left text-sm">
                  <thead className="app-table-header">
                    <tr>
                      <th className="px-5 py-3">提交时间</th>
                      <th className="px-5 py-3">称呼 / 微信</th>
                      <th className="px-5 py-3">考研目标</th>
                      <th className="px-5 py-3">复习阶段</th>
                      <th className="px-5 py-3">薄弱科目</th>
                      <th className="px-5 py-3">补充说明</th>
                    </tr>
                  </thead>
                  <tbody>
                    {leadPage.items.map((lead) => (
                      <tr className="app-row align-top" key={lead.id}>
                        <td className="whitespace-nowrap px-5 py-4 text-slate-500">{formatTime(lead.createdAt)}</td>
                        <td className="px-5 py-4"><p className="font-medium text-slate-950">{lead.contactName}</p><p className="mt-1 text-slate-500">{lead.wechatContact}</p></td>
                        <td className="px-5 py-4"><p>{lead.examYear} 考研</p><p className="mt-1 text-slate-500">{lead.targetSchool || "未填写院校"}</p></td>
                        <td className="px-5 py-4"><p>{stageLabels[lead.studyStage] ?? lead.studyStage}</p><p className="mt-1 text-slate-500">每周 {lead.weeklyHours ?? "未填写"} 小时</p></td>
                        <td className="px-5 py-4 text-slate-600">{lead.weakSubjects.map((subject) => subjectLabels[subject] ?? subject).join("、")}</td>
                        <td className="max-w-sm px-5 py-4 leading-6 text-slate-600">{lead.currentConcern || "未填写"}</td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
              {leadPage.totalPages > 1 && (
                <div className="flex items-center justify-end gap-3 border-t border-slate-200 px-5 py-4 text-sm">
                  <button className="app-button-secondary" disabled={page === 0} onClick={() => setPage((current) => Math.max(0, current - 1))} type="button">上一页</button>
                  <span className="text-slate-500">第 {page + 1} / {leadPage.totalPages} 页</span>
                  <button className="app-button-secondary" disabled={page + 1 >= leadPage.totalPages} onClick={() => setPage((current) => current + 1)} type="button">下一页</button>
                </div>
              )}
            </>
          )}
        </section>
      </div>
    </main>
  );
}

function StatePage({ title, text, actionHref, actionLabel }: { title: string; text: string; actionHref?: string; actionLabel?: string }) {
  return (
    <main className="app-bg px-5 py-6">
      <section className="app-panel mx-auto max-w-2xl p-6">
        <Link className="text-sm font-medium text-teal-700" href="/">返回仪表盘</Link>
        <h1 className="mt-4 text-2xl font-semibold">{title}</h1>
        <p className="mt-4 text-sm text-slate-500">{text}</p>
        {actionHref && actionLabel && <Link className="app-button-primary mt-5 inline-flex" href={actionHref}>{actionLabel}</Link>}
      </section>
    </main>
  );
}

function formatTime(value: string) {
  return new Intl.DateTimeFormat("zh-CN", { dateStyle: "short", timeStyle: "short", hour12: false }).format(new Date(value));
}
