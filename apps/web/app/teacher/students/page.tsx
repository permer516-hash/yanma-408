"use client";

import Link from "next/link";
import type { FormEvent, ReactNode } from "react";
import { useCallback, useEffect, useMemo, useState } from "react";
import {
  CurrentUser,
  StudentLearningDetail,
  StudentLearningSummary,
  TeacherClassView,
  TeacherTaskAssignmentView,
  assignTeacherClassTask,
  createTeacherClass,
  exportTeacherStudentsCsv,
  fetchCurrentUser,
  fetchTeacherAssignments,
  fetchTeacherClasses,
  fetchTeacherStudentDetail,
  fetchTeacherStudents,
  getAuth,
} from "@/app/lib/api";
import { subjectLabels } from "@/app/lib/question-labels";
import { formatQuestionText } from "@/app/lib/text-format";

const taskSubjects = [
  { label: "数据结构", value: "DATA_STRUCTURE" },
  { label: "计算机组成与原理", value: "COMPUTER_ORGANIZATION" },
  { label: "操作系统", value: "OPERATING_SYSTEM" },
  { label: "计算机网络", value: "COMPUTER_NETWORK" },
];

const taskTypes = [
  { label: "刷题组", value: "QUESTION_SET" },
  { label: "薄弱点", value: "WEAK_POINT" },
  { label: "错题复习", value: "MISTAKE_REVIEW" },
  { label: "自定义", value: "CUSTOM" },
];

const taskPriorities = [
  { label: "普通", value: "NORMAL" },
  { label: "重点", value: "IMPORTANT" },
  { label: "复习", value: "REVIEW" },
];

export default function TeacherStudentsPage() {
  const [access, setAccess] = useState<"checking" | "login" | "denied" | "allowed">("checking");
  const [students, setStudents] = useState<StudentLearningSummary[]>([]);
  const [classes, setClasses] = useState<TeacherClassView[]>([]);
  const [selectedClassId, setSelectedClassId] = useState("");
  const [assignments, setAssignments] = useState<TeacherTaskAssignmentView[]>([]);
  const [selectedStudentId, setSelectedStudentId] = useState<string | null>(null);
  const [detail, setDetail] = useState<StudentLearningDetail | null>(null);
  const [drilldownModal, setDrilldownModal] = useState<"practice" | "exams" | "mistakes" | "knowledge" | null>(null);
  const [keyword, setKeyword] = useState("");
  const [classForm, setClassForm] = useState({ name: "", courseName: "408 综合", description: "" });
  const [assignForm, setAssignForm] = useState({
    title: "",
    subjectCode: "DATA_STRUCTURE",
    taskType: "QUESTION_SET",
    targetCount: 20,
    estimatedMinutes: 30,
    priority: "NORMAL",
    taskDate: todayString(),
    recurrenceRule: "NONE",
    reminderTime: "",
  });
  const [operationMessage, setOperationMessage] = useState("");
  const [status, setStatus] = useState<"loading" | "success" | "error">("loading");
  const [detailStatus, setDetailStatus] = useState<"idle" | "loading" | "success" | "error">("idle");

  const loadStudents = useCallback(async (nextKeyword = keyword) => {
    setStatus("loading");
    try {
      const loaded = await fetchTeacherStudents({ classId: selectedClassId || undefined, keyword: nextKeyword });
      setStudents(loaded);
      setStatus("success");
      if (!selectedStudentId && loaded.length > 0) {
        setDetail(null);
        setDetailStatus("loading");
        setSelectedStudentId(loaded[0].id);
      }
      if (selectedStudentId && !loaded.some((student) => student.id === selectedStudentId)) {
        setSelectedStudentId(loaded[0]?.id ?? null);
        setDetail(null);
        setDetailStatus(loaded.length > 0 ? "loading" : "idle");
      }
    } catch {
      setStatus("error");
    }
  }, [keyword, selectedClassId, selectedStudentId]);

  useEffect(() => {
    let cancelled = false;
    Promise.resolve().then(() => {
      if (cancelled) {
        return;
      }
      if (!getAuth()) {
        setAccess("login");
        return;
      }
      fetchCurrentUser()
        .then((user) => {
          if (!cancelled) {
            setAccess(canViewTeacherStudents(user) ? "allowed" : "denied");
          }
        })
        .catch(() => {
          if (!cancelled) {
            setAccess("login");
          }
        });
    });
    return () => {
      cancelled = true;
    };
  }, []);

  useEffect(() => {
    if (access !== "allowed") {
      return;
    }
    Promise.resolve().then(() => loadStudents());
  }, [access, loadStudents]);

  useEffect(() => {
    if (access !== "allowed") {
      return;
    }
    let cancelled = false;
    fetchTeacherClasses()
      .then((loadedClasses) => {
        if (!cancelled) {
          setClasses(loadedClasses);
          if (!selectedClassId && loadedClasses.length > 0) {
            setSelectedClassId(loadedClasses[0].id);
          }
        }
      })
      .catch(() => {
        if (!cancelled) {
          setOperationMessage("班级加载失败。");
        }
      });
    return () => {
      cancelled = true;
    };
  }, [access, selectedClassId]);

  useEffect(() => {
    if (!selectedClassId) {
      return;
    }
    let cancelled = false;
    fetchTeacherAssignments(selectedClassId)
      .then((loaded) => {
        if (!cancelled) {
          setAssignments(loaded);
        }
      })
      .catch(() => {
        if (!cancelled) {
          setAssignments([]);
        }
      });
    return () => {
      cancelled = true;
    };
  }, [selectedClassId]);

  useEffect(() => {
    if (!selectedStudentId) {
      return;
    }
    let cancelled = false;
    fetchTeacherStudentDetail(selectedStudentId, selectedClassId || undefined)
      .then((loaded) => {
        if (!cancelled) {
          setDetail(loaded);
          setDetailStatus("success");
        }
      })
      .catch(() => {
        if (!cancelled) {
          setDetailStatus("error");
        }
      });
    return () => {
      cancelled = true;
    };
  }, [selectedClassId, selectedStudentId]);

  const classAverage = useMemo(() => {
    if (students.length === 0) {
      return 0;
    }
    return Math.round(students.reduce((sum, student) => sum + student.accuracyPercent, 0) / students.length);
  }, [students]);
  const selectedClass = useMemo(
    () => classes.find((item) => item.id === selectedClassId) ?? null,
    [classes, selectedClassId],
  );

  function handleSearch(event: FormEvent<HTMLFormElement>) {
    event.preventDefault();
    void loadStudents(keyword);
  }

  async function handleCreateClass(event: FormEvent<HTMLFormElement>) {
    event.preventDefault();
    setOperationMessage("");
    try {
      const created = await createTeacherClass({
        name: classForm.name,
        courseName: classForm.courseName,
        description: classForm.description || null,
      });
      setClasses((current) => [created, ...current]);
      setSelectedClassId(created.id);
      setClassForm({ name: "", courseName: "408 综合", description: "" });
      setOperationMessage("班级已创建。");
    } catch {
      setOperationMessage("班级创建失败，请检查名称和课程。");
    }
  }

  async function handleAssignTask(event: FormEvent<HTMLFormElement>) {
    event.preventDefault();
    if (!selectedClassId) {
      setOperationMessage("请先选择班级。");
      return;
    }
    try {
      const assignment = await assignTeacherClassTask(selectedClassId, {
        ...assignForm,
        title: assignForm.title.trim(),
        reminderTime: assignForm.reminderTime || null,
      });
      setAssignments((current) => [assignment, ...current]);
      setAssignForm((current) => ({ ...current, title: "" }));
      setOperationMessage(`任务已下发给 ${assignment.assignedCount} 名学生。`);
    } catch {
      setOperationMessage("任务下发失败，请确认班级内已有学生。");
    }
  }

  async function handleExport() {
    try {
      const blob = await exportTeacherStudentsCsv({ classId: selectedClassId || undefined, keyword });
      const url = URL.createObjectURL(blob);
      const link = document.createElement("a");
      link.href = url;
      link.download = "yanma408-students.csv";
      link.click();
      URL.revokeObjectURL(url);
    } catch {
      setOperationMessage("学生学情导出失败。");
    }
  }

  if (access === "checking") {
    return <StatePage title="学生学情" text="正在校验教师权限..." />;
  }

  if (access === "login") {
    return <StatePage title="学生学情" text="请先登录教师账号。" actionHref="/login" actionLabel="去登录" />;
  }

  if (access === "denied") {
    return <StatePage title="学生学情" text="当前账号没有教师端访问权限。" actionHref="/" actionLabel="返回首页" />;
  }

  return (
    <main className="app-bg px-4 py-6 sm:px-6 lg:py-8">
      <div className="mx-auto max-w-7xl space-y-5">
        <header className="app-panel flex flex-col gap-5 px-5 py-5 sm:px-6 sm:py-6 md:flex-row md:items-end md:justify-between">
          <div>
            <Link className="text-sm font-medium text-teal-700 hover:text-teal-800" href="/">
              返回仪表盘
            </Link>
            <h1 className="mt-3 text-3xl font-semibold">学生学情</h1>
            <p className="mt-1 text-sm text-slate-500">查看学生做题、错题和掌握情况。</p>
          </div>
          <form className="flex w-full gap-2 md:w-[360px]" onSubmit={handleSearch}>
            <input
              className="field h-10 min-w-0 flex-1"
              onChange={(event) => setKeyword(event.target.value)}
              placeholder="搜索用户名或昵称"
              value={keyword}
            />
            <button className="app-button-primary h-10 py-0" type="submit">
              查询
            </button>
          </form>
        </header>

        <section className="grid gap-4 lg:grid-cols-[minmax(0,0.95fr)_minmax(0,1.05fr)]">
          <div className="app-panel p-5">
            <div className="flex flex-col gap-3 md:flex-row md:items-start md:justify-between">
              <div>
                <h2 className="text-base font-semibold">班级与学生范围</h2>
                <p className="mt-1 text-sm text-slate-500">学生归属由管理员配置，老师在这里查看学情并下发任务。</p>
              </div>
              <button
                className="h-9 rounded-md border border-teal-200 bg-teal-50 px-3 text-sm font-semibold text-teal-800 hover:border-teal-700 hover:bg-teal-100"
                onClick={handleExport}
                type="button"
              >
                导出学情 CSV
              </button>
            </div>

            <label className="mt-4 block text-sm font-medium text-slate-700" htmlFor="teacher-class-select">
              当前班级
            </label>
            <select
              className="mt-2 h-10 w-full rounded-md border border-slate-200 bg-white px-3 text-sm outline-none focus:border-teal-700"
              id="teacher-class-select"
              onChange={(event) => {
                setSelectedClassId(event.target.value);
                setSelectedStudentId(null);
                setDetail(null);
                setDetailStatus("idle");
                setAssignments([]);
              }}
              value={selectedClassId}
            >
              <option value="">全部可见学生</option>
              {classes.map((item) => (
                <option key={item.id} value={item.id}>
                  {item.name} · {item.courseName} · {item.studentCount} 人
                </option>
              ))}
            </select>
            {selectedClass && (
              <p className="mt-2 text-xs text-slate-500">
                {selectedClass.description || "暂无班级备注"} · 状态 {selectedClass.status}
              </p>
            )}

            <form className="mt-5 grid gap-3 border-t border-slate-100 pt-4" onSubmit={handleCreateClass}>
              <h3 className="text-sm font-semibold">新建班级</h3>
              <div className="grid gap-3 md:grid-cols-2">
                <input
                  className="h-10 rounded-md border border-slate-200 px-3 text-sm outline-none focus:border-teal-700"
                  onChange={(event) => setClassForm((current) => ({ ...current, name: event.target.value }))}
                  placeholder="班级名称"
                  required
                  value={classForm.name}
                />
                <input
                  className="h-10 rounded-md border border-slate-200 px-3 text-sm outline-none focus:border-teal-700"
                  onChange={(event) => setClassForm((current) => ({ ...current, courseName: event.target.value }))}
                  placeholder="课程名称"
                  required
                  value={classForm.courseName}
                />
              </div>
              <input
                className="h-10 rounded-md border border-slate-200 px-3 text-sm outline-none focus:border-teal-700"
                onChange={(event) => setClassForm((current) => ({ ...current, description: event.target.value }))}
                placeholder="班级备注"
                value={classForm.description}
              />
              <button className="h-10 rounded-md bg-slate-900 px-4 text-sm font-medium text-white hover:bg-slate-800" type="submit">
                创建班级
              </button>
            </form>

            {operationMessage && (
              <p className="mt-4 rounded-md bg-slate-50 px-3 py-2 text-sm text-slate-600">{operationMessage}</p>
            )}
          </div>

          <div className="app-panel p-5">
            <h2 className="text-base font-semibold">给班级下发任务</h2>
            <p className="mt-1 text-sm text-slate-500">任务会进入学生端学习计划，可用于练习、薄弱点和错题复习。</p>
            <form className="mt-4 grid gap-3" onSubmit={handleAssignTask}>
              <input
                className="h-10 rounded-md border border-slate-200 px-3 text-sm outline-none focus:border-teal-700"
                onChange={(event) => setAssignForm((current) => ({ ...current, title: event.target.value }))}
                placeholder="任务标题"
                required
                value={assignForm.title}
              />
              <div className="grid gap-3 md:grid-cols-3">
                <select
                  className="h-10 rounded-md border border-slate-200 bg-white px-3 text-sm outline-none focus:border-teal-700"
                  onChange={(event) => setAssignForm((current) => ({ ...current, subjectCode: event.target.value }))}
                  value={assignForm.subjectCode}
                >
                  {taskSubjects.map((item) => (
                    <option key={item.value} value={item.value}>{item.label}</option>
                  ))}
                </select>
                <select
                  className="h-10 rounded-md border border-slate-200 bg-white px-3 text-sm outline-none focus:border-teal-700"
                  onChange={(event) => setAssignForm((current) => ({ ...current, taskType: event.target.value }))}
                  value={assignForm.taskType}
                >
                  {taskTypes.map((item) => (
                    <option key={item.value} value={item.value}>{item.label}</option>
                  ))}
                </select>
                <select
                  className="h-10 rounded-md border border-slate-200 bg-white px-3 text-sm outline-none focus:border-teal-700"
                  onChange={(event) => setAssignForm((current) => ({ ...current, priority: event.target.value }))}
                  value={assignForm.priority}
                >
                  {taskPriorities.map((item) => (
                    <option key={item.value} value={item.value}>{item.label}</option>
                  ))}
                </select>
              </div>
              <div className="grid gap-3 md:grid-cols-4">
                <input
                  className="h-10 rounded-md border border-slate-200 px-3 text-sm outline-none focus:border-teal-700"
                  min={1}
                  onChange={(event) => setAssignForm((current) => ({ ...current, targetCount: Number(event.target.value) }))}
                  type="number"
                  value={assignForm.targetCount}
                />
                <input
                  className="h-10 rounded-md border border-slate-200 px-3 text-sm outline-none focus:border-teal-700"
                  min={1}
                  onChange={(event) => setAssignForm((current) => ({ ...current, estimatedMinutes: Number(event.target.value) }))}
                  type="number"
                  value={assignForm.estimatedMinutes}
                />
                <input
                  className="h-10 rounded-md border border-slate-200 px-3 text-sm outline-none focus:border-teal-700"
                  onChange={(event) => setAssignForm((current) => ({ ...current, taskDate: event.target.value }))}
                  type="date"
                  value={assignForm.taskDate}
                />
                <input
                  className="h-10 rounded-md border border-slate-200 px-3 text-sm outline-none focus:border-teal-700"
                  onChange={(event) => setAssignForm((current) => ({ ...current, reminderTime: event.target.value }))}
                  type="time"
                  value={assignForm.reminderTime}
                />
              </div>
              <button className="h-10 rounded-md bg-teal-700 px-4 text-sm font-medium text-white hover:bg-teal-800" type="submit">
                下发到当前班级
              </button>
            </form>

            <div className="mt-5 border-t border-slate-100 pt-4">
              <h3 className="text-sm font-semibold">最近下发</h3>
              <div className="mt-3 space-y-2">
                {assignments.length === 0 && <p className="text-sm text-slate-500">当前班级暂无下发记录。</p>}
                {assignments.slice(0, 5).map((assignment) => (
                  <article className="rounded-md border border-slate-200 p-3" key={assignment.id}>
                    <div className="flex items-start justify-between gap-3">
                      <div>
                        <p className="text-sm font-medium">{assignment.title}</p>
                        <p className="mt-1 text-xs text-slate-500">
                          {subjectLabels[assignment.subjectCode] ?? assignment.subjectCode} · {taskTypeLabel(assignment.taskType)} · {assignment.targetCount} 题
                        </p>
                      </div>
                      <span className="shrink-0 text-xs font-semibold text-teal-700">{assignment.assignedCount} 人</span>
                    </div>
                  </article>
                ))}
              </div>
            </div>
          </div>
        </section>

        <section className="grid gap-4 md:grid-cols-4">
          <Metric title="学生数" value={String(students.length)} hint={status === "loading" ? "加载中" : "已纳入统计"} />
          <Metric title="总做题数" value={String(students.reduce((sum, student) => sum + student.attemptCount, 0))} hint="练习提交" />
          <Metric title="班级平均正确率" value={`${classAverage}%`} hint="按学生平均" />
          <Metric title="待掌握错题" value={String(students.reduce((sum, student) => sum + student.pendingMistakeCount, 0))} hint="未标记掌握" />
        </section>

        <section className="grid gap-5 lg:grid-cols-[minmax(0,1fr)_420px]">
          <div className="app-panel overflow-hidden">
            <div className="border-b border-slate-200 px-5 py-4">
              <h2 className="text-base font-semibold">学生列表</h2>
            </div>
            {status === "loading" && <StateLine text="正在加载学生列表..." />}
            {status === "error" && <StateLine text="学生列表加载失败。" tone="error" />}
            {status === "success" && students.length === 0 && <StateLine text="暂无匹配学生。" />}
            {status === "success" && students.length > 0 && (
              <div className="divide-y divide-slate-100">
                {students.map((student) => (
                  <button
                    className={`grid w-full gap-3 px-5 py-4 text-left transition hover:bg-slate-50 md:grid-cols-[1.1fr_0.8fr_0.8fr_0.8fr_0.8fr] ${
                      selectedStudentId === student.id ? "bg-teal-50/70" : ""
                    }`}
                    key={student.id}
                    onClick={() => {
                      setDetail(null);
                      setDetailStatus("loading");
                      setDrilldownModal(null);
                      setSelectedStudentId(student.id);
                    }}
                    type="button"
                  >
                    <div>
                      <p className="font-medium">{student.displayName}</p>
                      <p className="mt-1 text-xs text-slate-500">@{student.username}</p>
                    </div>
                    <StudentCell label="做题" value={`${student.attemptCount} 题`} />
                    <StudentCell label="正确率" value={`${student.accuracyPercent}%`} />
                    <StudentCell label="错题" value={`${student.pendingMistakeCount}/${student.mistakeCount}`} />
                    <StudentCell label="最近活跃" value={formatDate(student.latestActivityAt)} />
                  </button>
                ))}
              </div>
            )}
          </div>

          <aside className="app-panel h-fit overflow-hidden lg:sticky lg:top-6">
            <div className="border-b border-slate-200 px-5 py-4">
              <h2 className="text-base font-semibold">学生详情</h2>
            </div>
            {!selectedStudentId && <StateLine text="请选择一个学生。" />}
            {detailStatus === "loading" && <StateLine text="正在加载学生详情..." />}
            {detailStatus === "error" && <StateLine text="学生详情加载失败。" tone="error" />}
            {detailStatus === "success" && detail && (
              <div className="space-y-5 p-5">
                <div>
                  <p className="text-lg font-semibold">{detail.summary.displayName}</p>
                  <p className="mt-1 text-sm text-slate-500">@{detail.summary.username}</p>
                </div>

                <div className="grid grid-cols-2 gap-3">
                  <MiniMetric
                    label="练习正确率"
                    onClick={() => setDrilldownModal("practice")}
                    value={`${detail.summary.accuracyPercent}%`}
                  />
                  <MiniMetric
                    label="套卷次数"
                    onClick={() => setDrilldownModal("exams")}
                    value={`${detail.summary.examAttemptCount}`}
                  />
                  <MiniMetric
                    label="错题总数"
                    onClick={() => setDrilldownModal("mistakes")}
                    value={`${detail.summary.mistakeCount}`}
                  />
                  <MiniMetric
                    label="待掌握"
                    onClick={() => setDrilldownModal("knowledge")}
                    value={`${detail.summary.pendingMistakeCount}`}
                  />
                </div>

                <div>
                  <h3 className="text-sm font-semibold">四科掌握</h3>
                  <div className="mt-3 space-y-3">
                    {detail.dashboard.subjectMasteries.map((subject) => (
                      <div key={subject.subjectCode}>
                        <div className="flex items-center justify-between text-sm">
                          <span>{subjectLabels[subject.subjectCode] ?? subject.subjectName}</span>
                          <span className="font-semibold text-teal-700">{subject.masteryPercent}%</span>
                        </div>
                        <div className="mt-2 h-2 rounded-full bg-slate-100">
                          <div className="h-2 rounded-full bg-teal-700" style={{ width: `${subject.masteryPercent}%` }} />
                        </div>
                        <p className="mt-1 text-xs text-slate-500">薄弱点：{subject.weakestKnowledgePoint}</p>
                      </div>
                    ))}
                  </div>
                </div>

                <div>
                  <h3 className="text-sm font-semibold">优先关注错题</h3>
                  <div className="mt-3 space-y-3">
                    {detail.recentMistakes.length === 0 && <p className="text-sm text-slate-500">暂无错题。</p>}
                    {detail.recentMistakes.map((mistake) => (
                      <article className="rounded-md border border-slate-200 p-3" key={mistake.id}>
                        <p className="line-clamp-3 whitespace-pre-wrap text-sm font-medium">{formatQuestionText(mistake.stem)}</p>
                        <p className="mt-2 text-xs text-slate-500">
                          {subjectLabels[mistake.subjectCode] ?? mistake.subjectName} · 错 {mistake.wrongCount} 次 ·{" "}
                          {mistake.mastered ? "已掌握" : "待掌握"}
                        </p>
                      </article>
                    ))}
                  </div>
                </div>
              </div>
            )}
          </aside>
        </section>
      </div>
      {detail && drilldownModal && (
        <StudentDrilldownModal
          detail={detail}
          mode={drilldownModal}
          onClose={() => setDrilldownModal(null)}
        />
      )}
    </main>
  );
}

function canViewTeacherStudents(user: CurrentUser) {
  return user.roles.includes("TEACHER") || user.roles.includes("ADMIN");
}

function Metric({ title, value, hint }: { title: string; value: string; hint: string }) {
  return (
    <article className="app-panel-flat p-5">
      <p className="text-sm text-slate-500">{title}</p>
      <p className="mt-3 text-2xl font-semibold text-slate-950">{value}</p>
      <p className="mt-1 text-xs text-slate-500">{hint}</p>
    </article>
  );
}

function MiniMetric({ label, onClick, value }: { label: string; onClick: () => void; value: string }) {
  return (
    <button
      className="rounded-md border border-slate-200 bg-slate-50/50 p-3 text-left transition hover:border-teal-700 hover:bg-teal-50 hover:text-teal-900"
      onClick={onClick}
      type="button"
    >
      <p className="text-xs text-slate-500">{label}</p>
      <p className="mt-2 text-lg font-semibold">{value}</p>
    </button>
  );
}

function StudentDrilldown({
  detail,
  mode,
}: {
  detail: StudentLearningDetail;
  mode: "practice" | "exams" | "mistakes" | "knowledge";
}) {
  if (mode === "practice") {
    return (
      <DrilldownSection title="练习题目明细" hint="展示最近 20 条练习提交，包含学生答案和正确答案。">
        {detail.practiceAttempts.length === 0 && <EmptyDrilldown text="暂无练习提交。" />}
        {detail.practiceAttempts.map((attempt) => (
          <article className="rounded-md border border-slate-200 p-3" key={attempt.id}>
            <div className="flex items-center justify-between gap-2">
              <span className={`rounded-md px-2 py-1 text-xs font-medium ${attempt.correct ? "bg-teal-50 text-teal-800" : "bg-red-50 text-red-700"}`}>
                {attempt.correct ? "正确" : "错误"}
              </span>
              <span className="text-xs text-slate-500">{formatDate(attempt.submittedAt)} · {formatDuration(attempt.elapsedSeconds)}</span>
            </div>
            <p className="mt-2 line-clamp-3 whitespace-pre-wrap text-sm font-medium">{formatQuestionText(attempt.stem)}</p>
            <p className="mt-2 text-xs text-slate-500">
              {subjectLabels[attempt.subjectCode] ?? attempt.subjectName} · {attempt.chapterName}
            </p>
            <p className="mt-2 text-xs text-slate-600">
              学生选择 <span className="font-semibold text-slate-950">{attempt.submittedAnswer || "未作答"}</span> · 正确答案{" "}
              <span className="font-semibold text-teal-700">{attempt.correctAnswer}</span>
            </p>
          </article>
        ))}
      </DrilldownSection>
    );
  }

  if (mode === "exams") {
    return (
      <DrilldownSection title="套卷作答明细" hint="展示学生提交过的套卷、得分、正确率和用时。">
        {detail.examAttempts.length === 0 && <EmptyDrilldown text="暂无套卷提交。" />}
        {detail.examAttempts.map((attempt) => (
          <article className="rounded-md border border-slate-200 p-3" key={attempt.id}>
            <div className="flex items-start justify-between gap-3">
              <div>
                <p className="line-clamp-1 text-sm font-medium">{attempt.paperTitle}</p>
                <p className="mt-1 text-xs text-slate-500">
                  {paperTypeLabel(attempt.paperType)}{attempt.sourceYear ? ` · ${attempt.sourceYear}` : ""} · {formatDate(attempt.submittedAt)}
                </p>
              </div>
              <span className="text-sm font-semibold text-teal-700">{attempt.accuracyPercent}%</span>
            </div>
            <p className="mt-2 text-xs text-slate-600">
              得分 <span className="font-semibold text-slate-950">{attempt.scoredPoints}</span> / {attempt.totalScore} ·{" "}
              正确 {attempt.correctCount}/{attempt.questionCount} · 用时 {formatDuration(attempt.durationSeconds)}
            </p>
          </article>
        ))}
      </DrilldownSection>
    );
  }

  if (mode === "mistakes") {
    return (
      <DrilldownSection title="错题明细" hint="优先展示待掌握、错误次数较高的题目。">
        {detail.recentMistakes.length === 0 && <EmptyDrilldown text="暂无错题。" />}
        {detail.recentMistakes.map((mistake) => (
          <article className="rounded-md border border-slate-200 p-3" key={mistake.id}>
            <div className="flex items-center justify-between gap-2">
              <span className={`rounded-md px-2 py-1 text-xs font-medium ${mistake.mastered ? "bg-slate-100 text-slate-600" : "bg-amber-50 text-amber-800"}`}>
                {mistake.mastered ? "已掌握" : "待掌握"}
              </span>
              <span className="text-xs text-slate-500">错 {mistake.wrongCount} 次</span>
            </div>
            <p className="mt-2 line-clamp-3 whitespace-pre-wrap text-sm font-medium">{formatQuestionText(mistake.stem)}</p>
            <p className="mt-2 text-xs text-slate-500">
              {subjectLabels[mistake.subjectCode] ?? mistake.subjectName} · {mistake.chapterName} · {mistake.knowledgePoints.join("、") || "暂无知识点"}
            </p>
          </article>
        ))}
      </DrilldownSection>
    );
  }

  return (
    <DrilldownSection title="待掌握知识点" hint="按错题聚合出的薄弱知识点，优先处理待掌握数量高的项目。">
      {detail.weakKnowledgePoints.length === 0 && <EmptyDrilldown text="暂无待掌握知识点。" />}
      {detail.weakKnowledgePoints.map((point) => (
        <article className="rounded-md border border-slate-200 p-3" key={point.id}>
          <div className="flex items-center justify-between gap-2">
            <p className="text-sm font-medium">{point.name}</p>
            <span className="text-xs font-semibold text-teal-700">待掌握 {point.pendingMistakeCount}</span>
          </div>
          <p className="mt-2 text-xs text-slate-500">
            {subjectLabels[point.subjectCode] ?? point.subjectName} · {point.chapterName} · 错 {point.wrongCount} 次 · 题目 {point.mistakeCount} 道
          </p>
        </article>
      ))}
    </DrilldownSection>
  );
}

function StudentDrilldownModal({
  detail,
  mode,
  onClose,
}: {
  detail: StudentLearningDetail;
  mode: "practice" | "exams" | "mistakes" | "knowledge";
  onClose: () => void;
}) {
  const titles = {
    practice: "练习题目明细",
    exams: "套卷作答明细",
    mistakes: "错题明细",
    knowledge: "待掌握知识点",
  };
  const subtitles = {
    practice: "查看学生最近练习过哪些题目，以及每道题的选择和正确情况。",
    exams: "查看学生提交过的套卷、得分、正确率和用时。",
    mistakes: "查看学生做错的题目、错误次数和当前掌握状态。",
    knowledge: "查看学生当前仍需优先掌握的薄弱知识点。",
  };

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center bg-slate-950/45 p-4 backdrop-blur-sm">
      <section className="flex max-h-[86vh] w-full max-w-4xl flex-col overflow-hidden rounded-xl border border-slate-200 bg-white shadow-2xl shadow-slate-950/20">
        <header className="flex items-start justify-between gap-4 border-b border-slate-200 px-5 py-4">
          <div>
            <p className="text-xs font-medium text-teal-700">{detail.summary.displayName} @{detail.summary.username}</p>
            <h2 className="mt-1 text-lg font-semibold">{titles[mode]}</h2>
            <p className="mt-1 text-sm text-slate-500">{subtitles[mode]}</p>
          </div>
          <button
            aria-label="关闭弹窗"
            className="grid size-9 shrink-0 place-items-center rounded-md border border-slate-200 text-slate-500 hover:border-teal-700 hover:text-teal-800"
            onClick={onClose}
            type="button"
          >
            ×
          </button>
        </header>
        <div className="min-h-0 overflow-y-auto bg-slate-50 p-5">
          <StudentDrilldown detail={detail} mode={mode} />
        </div>
      </section>
    </div>
  );
}

function DrilldownSection({ children, hint, title }: { children: ReactNode; hint: string; title: string }) {
  return (
    <section className="rounded-lg border border-slate-200 bg-white p-4">
      <h3 className="text-sm font-semibold">{title}</h3>
      <p className="mt-1 text-xs text-slate-500">{hint}</p>
      <div className="mt-3 space-y-3">{children}</div>
    </section>
  );
}

function EmptyDrilldown({ text }: { text: string }) {
  return <p className="rounded-md border border-dashed border-slate-200 bg-white p-3 text-sm text-slate-500">{text}</p>;
}

function StudentCell({ label, value }: { label: string; value: string }) {
  return (
    <div>
      <p className="text-xs text-slate-500">{label}</p>
      <p className="mt-1 text-sm font-medium text-slate-800">{value}</p>
    </div>
  );
}

function StateLine({ text, tone = "default" }: { text: string; tone?: "default" | "error" }) {
  return <p className={`px-5 py-6 text-sm ${tone === "error" ? "text-red-600" : "text-slate-500"}`}>{text}</p>;
}

function StatePage({
  title,
  text,
  actionHref,
  actionLabel,
}: {
  title: string;
  text: string;
  actionHref?: string;
  actionLabel?: string;
}) {
  return (
    <main className="min-h-screen bg-[#f6f8f9] px-5 py-10 text-slate-950">
      <section className="mx-auto max-w-xl rounded-lg border border-slate-200 bg-white p-6">
        <h1 className="text-xl font-semibold">{title}</h1>
        <p className="mt-2 text-sm text-slate-500">{text}</p>
        {actionHref && actionLabel && (
          <Link className="mt-5 inline-flex rounded-md bg-teal-700 px-4 py-2 text-sm font-medium text-white" href={actionHref}>
            {actionLabel}
          </Link>
        )}
      </section>
    </main>
  );
}

function formatDate(value: string | null) {
  if (!value) {
    return "暂无";
  }
  return new Intl.DateTimeFormat("zh-CN", {
    month: "2-digit",
    day: "2-digit",
    hour: "2-digit",
    minute: "2-digit",
  }).format(new Date(value));
}

function formatDuration(seconds: number | null) {
  if (!seconds) {
    return "暂无";
  }
  const minutes = Math.floor(seconds / 60);
  const restSeconds = seconds % 60;
  if (minutes === 0) {
    return `${restSeconds} 秒`;
  }
  return `${minutes} 分 ${restSeconds} 秒`;
}

function paperTypeLabel(type: string) {
  if (type === "MOCK" || type === "MOCK_EXAM") {
    return "模拟卷";
  }
  if (type === "PAST" || type === "PAST_EXAM") {
    return "真题";
  }
  return type;
}

function taskTypeLabel(type: string) {
  const option = taskTypes.find((item) => item.value === type);
  return option?.label ?? type;
}

function todayString() {
  return new Date().toISOString().slice(0, 10);
}
