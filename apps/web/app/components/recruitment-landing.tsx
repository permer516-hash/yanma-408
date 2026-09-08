"use client";

import Image from "next/image";
import Link from "next/link";
import type { FormEvent } from "react";
import { useState } from "react";
import { RecruitmentLead, submitRecruitmentLead } from "@/app/lib/api";

const subjects = [
  { value: "DATA_STRUCTURE", label: "数据结构" },
  { value: "COMPUTER_ORGANIZATION", label: "计算机组成原理" },
  { value: "OPERATING_SYSTEM", label: "操作系统" },
  { value: "COMPUTER_NETWORK", label: "计算机网络" },
];

const studyStages: Array<{ value: RecruitmentLead["studyStage"]; label: string }> = [
  { value: "NOT_STARTED", label: "还没开始，想先找方向" },
  { value: "FIRST_ROUND", label: "一轮复习中" },
  { value: "SECOND_ROUND", label: "二轮强化中" },
  { value: "REVIEWING", label: "冲刺与查漏补缺" },
];

export function RecruitmentLanding() {
  const [form, setForm] = useState({
    contactName: "",
    wechatContact: "",
    examYear: "2027",
    targetSchool: "",
    studyStage: "NOT_STARTED" as RecruitmentLead["studyStage"],
    weakSubjects: [] as string[],
    weeklyHours: "",
    currentConcern: "",
    consented: false,
  });
  const [submitting, setSubmitting] = useState(false);
  const [message, setMessage] = useState("");
  const [submitted, setSubmitted] = useState(false);

  function toggleSubject(subject: string) {
    setForm((current) => ({
      ...current,
      weakSubjects: current.weakSubjects.includes(subject)
        ? current.weakSubjects.filter((value) => value !== subject)
        : [...current.weakSubjects, subject],
    }));
  }

  async function handleSubmit(event: FormEvent<HTMLFormElement>) {
    event.preventDefault();
    if (form.weakSubjects.length === 0) {
      setMessage("请至少选择一门当前最需要补强的科目。");
      return;
    }
    setSubmitting(true);
    setMessage("");
    try {
      await submitRecruitmentLead({
        contactName: form.contactName.trim(),
        wechatContact: form.wechatContact.trim(),
        examYear: Number(form.examYear),
        targetSchool: form.targetSchool.trim(),
        studyStage: form.studyStage,
        weakSubjects: form.weakSubjects,
        weeklyHours: form.weeklyHours ? Number(form.weeklyHours) : null,
        currentConcern: form.currentConcern.trim(),
        consented: form.consented,
      });
      setSubmitted(true);
    } catch (error) {
      setMessage(error instanceof Error ? error.message : "预约信息提交失败，请稍后再试。");
    } finally {
      setSubmitting(false);
    }
  }

  return (
    <main className="min-h-screen bg-white text-slate-950">
      <header className="absolute inset-x-0 top-0 z-20">
        <div className="mx-auto flex max-w-7xl items-center justify-between px-5 py-5 sm:px-8 lg:px-10">
          <Link className="flex items-center gap-3" href="/">
            <span className="grid size-10 place-items-center rounded-md bg-slate-950 text-sm font-semibold text-white">研</span>
            <span>
              <span className="block text-base font-semibold">研码408</span>
              <span className="block text-xs text-slate-600">CS 考研专业课诊断与练习</span>
            </span>
          </Link>
          <a className="text-sm font-semibold text-teal-800 hover:text-teal-950" href="#assessment">
            领取学情自测
          </a>
        </div>
      </header>

      <section className="relative isolate min-h-[660px] overflow-hidden border-b border-slate-200 bg-slate-100">
        <Image
          alt="正在进行计算机考研复习的学生"
          className="object-cover object-[67%_center]"
          fill
          priority
          sizes="100vw"
          src="/images/recruitment-hero-study.png"
        />
        <div className="relative mx-auto flex min-h-[660px] max-w-7xl items-end px-5 pb-12 pt-28 sm:px-8 sm:pb-14 lg:px-10 lg:pb-16">
          <div className="-mx-5 w-full bg-white/90 px-5 py-5 sm:mx-0 sm:max-w-xl sm:bg-transparent sm:px-0 sm:py-8">
            <p className="text-sm font-semibold text-teal-800">408 专业课一对一辅导</p>
            <h1 className="mt-3 text-4xl font-semibold leading-tight sm:text-5xl">研码408</h1>
            <p className="mt-4 text-xl font-medium leading-8 text-slate-800 sm:text-2xl">把零散练习，变成看得见的进步。</p>
            <p className="mt-5 max-w-lg text-base leading-7 text-slate-600">
              从薄弱点定位、针对性讲解到错题复盘，建立一条老师与学生都看得见的 408 学习路径。
            </p>
            <a className="app-button-primary mt-7 inline-flex min-h-11 items-center" href="#assessment">
              领取 408 学情自测并预约诊断
            </a>
          </div>
        </div>
      </section>

      <section className="border-b border-slate-200 bg-white">
        <div className="mx-auto grid max-w-7xl grid-cols-2 divide-x divide-y divide-slate-200 px-5 sm:grid-cols-4 sm:px-8 lg:px-10">
          <Proof label="408 专业课成绩" value="117 分" />
          <Proof label="考研总分" value="375 分" />
          <Proof label="持续教学经验" value="4 年" />
          <Proof label="学习反馈方式" value="可追踪" />
        </div>
      </section>

      <section className="border-b border-slate-200 bg-slate-50">
        <div className="mx-auto max-w-7xl px-5 py-16 sm:px-8 lg:px-10">
          <div className="max-w-2xl">
            <p className="text-sm font-semibold text-teal-800">不只讲一节课</p>
            <h2 className="mt-3 text-3xl font-semibold">一套能复盘的学习闭环</h2>
            <p className="mt-4 leading-7 text-slate-600">针对四门 408 专业课，把听懂、练习、错误与下一步安排连接起来。</p>
          </div>
          <div className="mt-10 grid gap-8 border-t border-slate-200 pt-8 md:grid-cols-4">
            <Method number="01" title="学情诊断" text="先明确阶段、薄弱科目和当前卡点，避免一上来就盲目刷题。" />
            <Method number="02" title="针对性讲解" text="围绕真题规律、核心概念和易错点组织课堂，给到可执行的复习顺序。" />
            <Method number="03" title="错题闭环" text="在研码408中沉淀错题、掌握情况与复习节奏，让问题不会只停留在当次课。" />
            <Method number="04" title="老师可追踪" text="老师端可查看练习、错题和掌握概况，及时调整后续学习安排。" />
          </div>
        </div>
      </section>

      <section className="scroll-mt-6 bg-white" id="assessment">
        <div className="mx-auto grid max-w-7xl gap-10 px-5 py-16 sm:px-8 lg:grid-cols-[0.85fr_1.15fr] lg:px-10">
          <div className="self-start lg:sticky lg:top-6">
            <p className="text-sm font-semibold text-teal-800">第一步，先把现状说清楚</p>
            <h2 className="mt-3 text-3xl font-semibold">408 学情自测与预约诊断</h2>
            <p className="mt-5 max-w-md leading-7 text-slate-600">
              用不到两分钟说明你的复习阶段与薄弱方向。老师会据此准备首次沟通，不会用一套泛泛的建议敷衍你。
            </p>
            <dl className="mt-9 divide-y divide-slate-200 border-y border-slate-200 text-sm">
              <div className="flex items-start justify-between gap-5 py-4">
                <dt className="font-medium">你会得到</dt>
                <dd className="max-w-52 text-right leading-6 text-slate-600">当前阶段的学习优先级建议</dd>
              </div>
              <div className="flex items-start justify-between gap-5 py-4">
                <dt className="font-medium">适合谁</dt>
                <dd className="max-w-52 text-right leading-6 text-slate-600">准备开始、复习受阻或希望有人跟进的 408 考生</dd>
              </div>
              <div className="flex items-start justify-between gap-5 py-4">
                <dt className="font-medium">联系方式</dt>
                <dd className="max-w-52 text-right leading-6 text-slate-600">仅用于本次诊断预约，不公开展示</dd>
              </div>
            </dl>
          </div>

          <div className="rounded-lg border border-slate-200 bg-slate-50 p-5 shadow-[0_14px_34px_rgba(15,23,42,0.06)] sm:p-7">
            {submitted ? (
              <div className="py-12 text-center">
                <p className="text-sm font-semibold text-teal-800">已收到</p>
                <h3 className="mt-3 text-2xl font-semibold">你的学情信息已经进入诊断队列。</h3>
                <p className="mx-auto mt-4 max-w-md leading-7 text-slate-600">老师会根据你填写的复习阶段与薄弱科目，通过预留微信联系你。</p>
                <Link className="app-button-secondary mt-7 inline-flex" href="/login">已有账号，去登录练习平台</Link>
              </div>
            ) : (
              <form className="grid gap-5" onSubmit={handleSubmit}>
                <div>
                  <h3 className="text-lg font-semibold">填写你的当前情况</h3>
                  <p className="mt-1 text-sm text-slate-500">带 * 的内容用于建立首次诊断画像。</p>
                </div>
                <div className="grid gap-4 sm:grid-cols-2">
                  <label className="grid gap-2 text-sm font-medium">
                    称呼 *
                    <input className="field" maxLength={40} onChange={(event) => setForm((current) => ({ ...current, contactName: event.target.value }))} placeholder="怎么称呼你" required value={form.contactName} />
                  </label>
                  <label className="grid gap-2 text-sm font-medium">
                    微信号 *
                    <input className="field" maxLength={80} onChange={(event) => setForm((current) => ({ ...current, wechatContact: event.target.value }))} placeholder="用于预约联系" required value={form.wechatContact} />
                  </label>
                  <label className="grid gap-2 text-sm font-medium">
                    考研年份 *
                    <select className="field" onChange={(event) => setForm((current) => ({ ...current, examYear: event.target.value }))} value={form.examYear}>
                      {[2026, 2027, 2028, 2029, 2030].map((year) => <option key={year} value={year}>{year} 年</option>)}
                    </select>
                  </label>
                  <label className="grid gap-2 text-sm font-medium">
                    目标院校
                    <input className="field" maxLength={120} onChange={(event) => setForm((current) => ({ ...current, targetSchool: event.target.value }))} placeholder="可选" value={form.targetSchool} />
                  </label>
                </div>
                <label className="grid gap-2 text-sm font-medium">
                  当前复习阶段 *
                  <select className="field" onChange={(event) => setForm((current) => ({ ...current, studyStage: event.target.value as RecruitmentLead["studyStage"] }))} value={form.studyStage}>
                    {studyStages.map((stage) => <option key={stage.value} value={stage.value}>{stage.label}</option>)}
                  </select>
                </label>
                <fieldset>
                  <legend className="text-sm font-medium">当前最需要补强的科目 *</legend>
                  <div className="mt-3 grid gap-2 sm:grid-cols-2">
                    {subjects.map((subject) => (
                      <label className="flex min-h-11 items-center gap-3 rounded-md border border-slate-200 bg-white px-3 text-sm text-slate-700" key={subject.value}>
                        <input checked={form.weakSubjects.includes(subject.value)} onChange={() => toggleSubject(subject.value)} type="checkbox" />
                        {subject.label}
                      </label>
                    ))}
                  </div>
                </fieldset>
                <div className="grid gap-4 sm:grid-cols-[0.6fr_1.4fr]">
                  <label className="grid gap-2 text-sm font-medium">
                    每周可投入时间
                    <input className="field" max="80" min="1" onChange={(event) => setForm((current) => ({ ...current, weeklyHours: event.target.value }))} placeholder="小时" type="number" value={form.weeklyHours} />
                  </label>
                  <label className="grid gap-2 text-sm font-medium">
                    当前最想解决的问题
                    <input className="field" maxLength={1000} onChange={(event) => setForm((current) => ({ ...current, currentConcern: event.target.value }))} placeholder="例如：学完容易忘、刷题正确率不稳定" value={form.currentConcern} />
                  </label>
                </div>
                <label className="flex items-start gap-3 text-sm leading-6 text-slate-600">
                  <input checked={form.consented} className="mt-1" onChange={(event) => setForm((current) => ({ ...current, consented: event.target.checked }))} required type="checkbox" />
                  我同意研码408仅为本次学情诊断与预约联系收集以上信息。
                </label>
                {message && <p className="rounded-md bg-red-50 px-3 py-2 text-sm text-red-800">{message}</p>}
                <button className="app-button-primary min-h-11" disabled={submitting} type="submit">
                  {submitting ? "正在提交..." : "提交学情自测并预约诊断"}
                </button>
              </form>
            )}
          </div>
        </div>
      </section>
    </main>
  );
}

function Proof({ label, value }: { label: string; value: string }) {
  return (
    <div className="px-4 py-6 sm:px-6">
      <dt className="text-xs text-slate-500">{label}</dt>
      <dd className="mt-2 text-2xl font-semibold">{value}</dd>
    </div>
  );
}

function Method({ number, title, text }: { number: string; title: string; text: string }) {
  return (
    <article>
      <p className="text-sm font-semibold text-teal-800">{number}</p>
      <h3 className="mt-3 text-lg font-semibold">{title}</h3>
      <p className="mt-3 text-sm leading-6 text-slate-600">{text}</p>
    </article>
  );
}
