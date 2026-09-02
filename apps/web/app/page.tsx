"use client";

import Link from "next/link";
import type { FormEvent, ReactNode } from "react";
import { useEffect, useState } from "react";
import {
  AuthResult,
  CurrentUser,
  clearAuth,
  createStudyTask,
  deleteStudyTask,
  fetchMistakes,
  fetchCurrentUser,
  fetchStudyDashboard,
  fetchStudyReminders,
  fetchStudyTaskRange,
  fetchStudyTasks,
  getAuth,
  logout,
  MistakeSummary,
  StudyDashboard,
  updateStudyTask,
  updateStudyTaskOccurrenceStatus,
  updateStudyTaskStatus,
} from "@/app/lib/api";
import { subjectLabels } from "@/app/lib/question-labels";
import { formatQuestionText } from "@/app/lib/text-format";
import { RecruitmentLanding } from "@/app/components/recruitment-landing";

const taskSubjects = [
  { label: "数据结构", value: "DATA_STRUCTURE" },
  { label: "计算机组成与原理", value: "COMPUTER_ORGANIZATION" },
  { label: "操作系统", value: "OPERATING_SYSTEM" },
  { label: "计算机网络", value: "COMPUTER_NETWORK" },
];

const taskTypes = [
  { label: "自定义", value: "CUSTOM" },
  { label: "刷题组", value: "QUESTION_SET" },
  { label: "薄弱点", value: "WEAK_POINT" },
  { label: "错题复习", value: "MISTAKE_REVIEW" },
];

const taskPriorities = [
  { label: "普通", value: "NORMAL" },
  { label: "重点", value: "IMPORTANT" },
  { label: "复习", value: "REVIEW" },
];

const recurrenceRules = [
  { label: "不重复", value: "NONE" },
  { label: "每天", value: "DAILY" },
  { label: "每周", value: "WEEKLY" },
  { label: "每月", value: "MONTHLY" },
];

const postgraduateExamTarget = new Date(2026, 11, 26, 8, 30, 0);

export default function Home() {
  const [auth, setAuth] = useState<AuthResult | null | undefined>(undefined);
  const [currentUser, setCurrentUser] = useState<CurrentUser | null>(null);
  const [taskDate, setTaskDate] = useState(() => todayString());
  const [tasks, setTasks] = useState<StudyDashboard["todayTasks"]>([]);
  const [taskRange, setTaskRange] = useState<StudyDashboard["todayTasks"]>([]);
  const [reminders, setReminders] = useState<StudyDashboard["todayTasks"]>([]);
  const [rangeMode, setRangeMode] = useState<"week" | "month">("week");
  const [taskListStatus, setTaskListStatus] = useState<"loading" | "success" | "error">("loading");
  const [recentMistakes, setRecentMistakes] = useState<MistakeSummary[]>([]);
  const [mistakeStatus, setMistakeStatus] = useState<"loading" | "success" | "error">("loading");
  const [studyDashboard, setStudyDashboard] = useState<StudyDashboard | null>(null);
  const [dashboardStatus, setDashboardStatus] = useState<"loading" | "success" | "error">("loading");
  const [updatingTaskId, setUpdatingTaskId] = useState<string | null>(null);
  const [taskStatusError, setTaskStatusError] = useState<string | null>(null);
  const [creatingTask, setCreatingTask] = useState(false);
  const [editingTaskId, setEditingTaskId] = useState<string | null>(null);
  const [taskForm, setTaskForm] = useState({
    title: "",
    subjectCode: "DATA_STRUCTURE",
    taskType: "CUSTOM",
    targetCount: 10,
    estimatedMinutes: 20,
    priority: "NORMAL",
    recurrenceRule: "NONE",
    reminderTime: "",
  });

  useEffect(() => {
    let cancelled = false;
    Promise.resolve().then(() => {
      if (!cancelled) {
        setAuth(getAuth());
      }
    });

    return () => {
      cancelled = true;
    };
  }, []);

  useEffect(() => {
    let cancelled = false;
    if (auth === undefined || auth === null) {
      return () => {
        cancelled = true;
      };
    }

    fetchMistakes()
      .then((mistakes) => {
        if (!cancelled) {
          setRecentMistakes(mistakes.slice(0, 3));
          setMistakeStatus("success");
        }
      })
      .catch(() => {
        if (!cancelled) {
          setMistakeStatus("error");
        }
      });

    fetchCurrentUser()
      .then((user) => {
        if (!cancelled) {
          setCurrentUser(user);
        }
      })
      .catch(() => {
        if (!cancelled) {
          setCurrentUser(null);
        }
      });

    fetchStudyDashboard()
      .then((dashboard) => {
        if (!cancelled) {
          setStudyDashboard(dashboard);
          setDashboardStatus("success");
        }
      })
      .catch(() => {
        if (!cancelled) {
          setDashboardStatus("error");
        }
      });

    return () => {
      cancelled = true;
    };
  }, [auth]);

  useEffect(() => {
    let cancelled = false;
    if (!auth) {
      return () => {
        cancelled = true;
      };
    }
    fetchStudyTasks(taskDate)
      .then((loadedTasks) => {
        if (!cancelled) {
          setTasks(loadedTasks);
          setTaskListStatus("success");
        }
      })
      .catch(() => {
        if (!cancelled) {
          setTaskListStatus("error");
        }
      });

    return () => {
      cancelled = true;
    };
  }, [auth, taskDate]);

  useEffect(() => {
    let cancelled = false;
    if (!auth) {
      return () => {
        cancelled = true;
      };
    }
    fetchStudyReminders(taskDate)
      .then((loadedReminders) => {
        if (!cancelled) {
          setReminders(loadedReminders);
        }
      })
      .catch(() => {
        if (!cancelled) {
          setReminders([]);
        }
      });
    return () => {
      cancelled = true;
    };
  }, [auth, taskDate]);

  useEffect(() => {
    let cancelled = false;
    if (!auth) {
      return () => {
        cancelled = true;
      };
    }
    const [start, end] = rangeBounds(taskDate, rangeMode);
    fetchStudyTaskRange(start, end)
      .then((loadedTasks) => {
        if (!cancelled) {
          setTaskRange(loadedTasks);
        }
      })
      .catch(() => {
        if (!cancelled) {
          setTaskRange([]);
        }
      });
    return () => {
      cancelled = true;
    };
  }, [auth, taskDate, rangeMode]);

  async function handleTaskStatus(task: StudyDashboard["todayTasks"][number]) {
    const nextStatus = task.status === "DONE" ? "PENDING" : "DONE";
    setUpdatingTaskId(task.id);
    setTaskStatusError(null);
    try {
      await updateStudyTaskStatus(task.id, nextStatus);
      await refreshTaskSurfaces();
    } catch {
      setTaskStatusError("任务状态更新失败，请稍后再试。");
    } finally {
      setUpdatingTaskId(null);
    }
  }

  async function handleOccurrenceStatus(task: StudyDashboard["todayTasks"][number], status: "PENDING" | "DONE" | "SKIPPED") {
    setUpdatingTaskId(task.id);
    setTaskStatusError(null);
    try {
      await updateStudyTaskOccurrenceStatus(task.id, task.taskDate, status);
      await refreshTaskSurfaces();
    } catch {
      setTaskStatusError("计划实例更新失败，请稍后再试。");
    } finally {
      setUpdatingTaskId(null);
    }
  }

  async function handleCreateTask(event: FormEvent<HTMLFormElement>) {
    event.preventDefault();
    if (!taskForm.title.trim()) {
      setTaskStatusError("请填写任务名称。");
      return;
    }
    setCreatingTask(true);
    setTaskStatusError(null);
    try {
      const input = {
        ...taskForm,
        title: taskForm.title.trim(),
        taskDate,
        reminderTime: taskForm.reminderTime || null,
      };
      if (editingTaskId) {
        await updateStudyTask(editingTaskId, input);
      } else {
        await createStudyTask(input);
      }
      await refreshTaskSurfaces();
      resetTaskForm();
    } catch {
      setTaskStatusError(editingTaskId ? "任务更新失败，请稍后再试。" : "任务创建失败，请稍后再试。");
    } finally {
      setCreatingTask(false);
    }
  }

  async function handleDeleteTask(taskId: string) {
    setUpdatingTaskId(taskId);
    setTaskStatusError(null);
    try {
      await deleteStudyTask(taskId);
      await refreshTaskSurfaces();
      if (editingTaskId === taskId) {
        resetTaskForm();
      }
    } catch {
      setTaskStatusError("任务删除失败，请稍后再试。");
    } finally {
      setUpdatingTaskId(null);
    }
  }

  function startEditTask(task: StudyDashboard["todayTasks"][number]) {
    setEditingTaskId(task.id);
    setTaskForm({
      title: task.title,
      subjectCode: task.subjectCode,
      taskType: task.taskType,
      targetCount: task.targetCount,
      estimatedMinutes: task.estimatedMinutes,
      priority: task.priority,
      recurrenceRule: task.recurrenceRule,
      reminderTime: task.reminderTime?.slice(0, 5) ?? "",
    });
    setTaskDate(task.taskDate);
  }

  async function refreshTaskSurfaces() {
    const [start, end] = rangeBounds(taskDate, rangeMode);
    const [loadedTasks, loadedRange, dashboard] = await Promise.all([
      fetchStudyTasks(taskDate),
      fetchStudyTaskRange(start, end),
      fetchStudyDashboard(),
    ]);
    const loadedReminders = await fetchStudyReminders(taskDate).catch(() => []);
    setTasks(loadedTasks);
    setTaskRange(loadedRange);
    setReminders(loadedReminders);
    setTaskListStatus("success");
    setStudyDashboard(dashboard);
    setDashboardStatus("success");
  }

  function resetTaskForm() {
    setEditingTaskId(null);
    setTaskForm((current) => ({
      ...current,
      title: "",
      targetCount: 10,
      estimatedMinutes: 20,
      priority: "NORMAL",
      taskType: "CUSTOM",
      recurrenceRule: "NONE",
      reminderTime: "",
    }));
  }

  if (!auth) {
    return <RecruitmentLanding />;
  }

  return (
    <main className="app-bg">
      <div className="grid min-h-screen grid-cols-1 lg:grid-cols-[264px_1fr]">
        <aside className="border-b border-slate-200 bg-white px-5 py-5 shadow-[8px_0_28px_rgba(15,23,42,0.03)] lg:border-b-0 lg:border-r">
          <div className="flex items-center gap-3">
            <div className="grid size-11 place-items-center rounded-lg bg-slate-950 text-sm font-semibold text-white shadow-sm shadow-slate-950/20">
              <FutureLogo />
            </div>
            <div>
              <p className="text-lg font-semibold tracking-normal">研码408</p>
              <p className="text-xs text-slate-500">CS考研专业课练习平台</p>
            </div>
          </div>

          <nav className="mt-6 grid grid-cols-2 gap-2 text-sm lg:mt-9 lg:block lg:space-y-1.5 lg:text-[15px]">
            {[
              { label: "仪表盘", href: "/" },
              { label: "题库", href: "/question-bank" },
              { label: "章节练习", href: "/chapters" },
              { label: "错题本", href: "/mistakes" },
              { label: "历年真题", href: "/exams" },
              { label: "模拟测评", href: "/mock-exams" },
              { label: "学习分析", href: "/analysis" },
              ...(canViewTeacherStudents(currentUser) ? [
                { label: "学生学情", href: "/teacher/students" },
              ] : []),
              ...(isAdmin(currentUser) ? [
                { label: "题库管理", href: "/admin" },
                { label: "招生线索", href: "/admin/recruitment-leads" },
                { label: "师生绑定", href: "/admin/teacher-bindings" },
                { label: "添加教师", href: "/root/teachers" },
                { label: "账号安全", href: "/account/security" },
              ] : []),
              { label: auth ? "退出登录" : "登录", href: auth ? "#" : "/login" },
            ].map((item, index) => (
                <Link
                  className={`flex h-10 items-center rounded-lg px-3.5 font-medium lg:h-11 ${
                    index === 0
                      ? "bg-teal-50 text-teal-900 shadow-inner shadow-teal-900/5"
                      : "text-slate-600 hover:bg-slate-50 hover:text-slate-950"
                  }`}
                  href={item.href}
                  key={item.label}
                  onClick={(event) => {
                    if (item.label === "退出登录") {
                      event.preventDefault();
                      void logout()
                        .catch(() => undefined)
                        .finally(() => {
                          clearAuth();
                          window.location.href = "/login";
                        });
                    }
                  }}
                >
                  {item.label}
                </Link>
              ))}
          </nav>
        </aside>

        <section className="flex min-w-0 w-full flex-col">
          <div className="grid gap-5 px-5 py-5 xl:grid-cols-[1fr_320px] 2xl:px-7">
            <div className="space-y-5">
              <header className="app-panel px-5 py-5">
                <div className="flex w-full flex-col gap-3 md:flex-row md:items-center md:justify-between">
                  <div>
                    <h1 className="text-2xl font-semibold tracking-tight">今日学习仪表盘</h1>
                    <p className="mt-1 max-w-3xl text-sm leading-6 text-slate-500">
                      {buildDashboardSlogan(auth, dashboardStatus, studyDashboard)}
                    </p>
                  </div>
                  <div className="flex items-center gap-2 text-sm">
                    <CountdownBadge />
                    <Link className="app-button-primary" href="/question-bank">
                      开始刷题
                    </Link>
                  </div>
                </div>
              </header>
              <section className="grid gap-4 md:grid-cols-3">
                <Metric
                  title="今日目标"
                  value={
                    auth && dashboardStatus === "success" && studyDashboard
                      ? `${studyDashboard.todayGoal.completedCount} / ${studyDashboard.todayGoal.targetCount}`
                      : "-- / --"
                  }
                  hint={auth === null ? "登录后同步" : dashboardStatus === "error" ? "加载失败" : "已完成题量"}
                />
                <Metric
                  title="连续学习"
                  value={
                    auth && dashboardStatus === "success" && studyDashboard
                      ? `${studyDashboard.continuousStudy.days} 天`
                      : "--"
                  }
                  hint={auth === null ? "登录后同步" : dashboardStatus === "error" ? "加载失败" : "保持节奏"}
                />
                <Metric
                  title="本周正确率"
                  value={
                    auth && dashboardStatus === "success" && studyDashboard
                      ? `${studyDashboard.weeklyAccuracy.percent}%`
                      : "--"
                  }
                  hint={
                    auth && dashboardStatus === "success" && studyDashboard
                      ? (
                          <WeeklyAccuracyHint
                            attemptCount={studyDashboard.weeklyAccuracy.attemptCount}
                            deltaPercent={studyDashboard.weeklyAccuracy.deltaPercent}
                          />
                        )
                      : auth === null
                        ? "登录后同步"
                        : dashboardStatus === "error"
                        ? "加载失败"
                        : "正在加载"
                  }
                />
              </section>

              <section className="app-panel p-5">
                <div className="flex items-center justify-between">
                  <h2 className="text-base font-semibold">四科掌握度</h2>
                  <span className="text-xs text-slate-500">按当前练习记录计算</span>
                </div>
                <div className="mt-5 grid gap-4 md:grid-cols-2">
                  {(auth === undefined || (auth && dashboardStatus === "loading")) && (
                    <StateCard text="正在加载四科掌握度..." />
                  )}
                  {(auth === null || (auth && dashboardStatus === "error")) && (
                    <StateCard text={auth ? "四科掌握度加载失败。" : "登录后查看四科掌握度。"} tone="error" />
                  )}
                  {auth &&
                    dashboardStatus === "success" &&
                    studyDashboard?.subjectMasteries.map((subject) => (
                      <article className="rounded-lg border border-slate-200 bg-white p-4 shadow-sm shadow-slate-950/[0.02]" key={subject.subjectCode}>
                        <div className="flex items-start justify-between gap-4">
                          <div>
                            <h3 className="font-medium">
                              {subjectLabels[subject.subjectCode] ?? subject.subjectName}
                            </h3>
                            <p className="mt-1 text-xs text-slate-500">
                              已练 {subject.practicedCount} 题 · 薄弱点：{subject.weakestKnowledgePoint}
                            </p>
                          </div>
                          <span className="text-lg font-semibold text-teal-700">{subject.masteryPercent}%</span>
                        </div>
                        <div className="mt-4 h-2 rounded-full bg-slate-100">
                          <div
                            className="h-2 rounded-full bg-teal-700"
                            style={{ width: `${subject.masteryPercent}%` }}
                          />
                        </div>
                      </article>
                    ))}
                </div>
              </section>

              <section className="app-panel overflow-hidden">
                <div className="border-b border-slate-200 px-5 py-4">
                  <div>
                    <h2 className="text-base font-semibold">学习任务</h2>
                    {auth && (
                      <form
                        className="mt-3 grid gap-2 md:grid-cols-2 lg:grid-cols-[142px_minmax(145px,1fr)_154px_92px_70px_70px_76px_82px_82px_72px]"
                        onSubmit={handleCreateTask}
                      >
                        <label className="text-center text-xs font-medium text-slate-500">
                          日期
                          <input
                            className="mt-1 h-9 w-full rounded-md border border-slate-200 px-3 text-center text-sm text-slate-950 outline-none focus:border-teal-700"
                            onChange={(event) => {
                              setTaskListStatus("loading");
                              setTaskDate(event.target.value);
                            }}
                            type="date"
                            value={taskDate}
                          />
                        </label>
                        <label className="text-center text-xs font-medium text-slate-500">
                          任务名称
                          <input
                            className="mt-1 h-9 w-full rounded-md border border-slate-200 px-3 text-center text-sm text-slate-950 outline-none focus:border-teal-700"
                            onChange={(event) => setTaskForm((current) => ({ ...current, title: event.target.value }))}
                            placeholder="新增任务"
                            value={taskForm.title}
                          />
                        </label>
                        <label className="text-center text-xs font-medium text-slate-500">
                          科目
                          <select
                            className="mt-1 h-9 w-full rounded-md border border-slate-200 px-2 text-center text-sm text-slate-950 outline-none focus:border-teal-700"
                            onChange={(event) => setTaskForm((current) => ({ ...current, subjectCode: event.target.value }))}
                            value={taskForm.subjectCode}
                          >
                            {taskSubjects.map((subject) => (
                              <option key={subject.value} value={subject.value}>
                                {subject.label}
                              </option>
                            ))}
                          </select>
                        </label>
                        <label className="text-center text-xs font-medium text-slate-500">
                          类型
                          <select
                            className="mt-1 h-9 w-full rounded-md border border-slate-200 px-2 text-center text-sm text-slate-950 outline-none focus:border-teal-700"
                            onChange={(event) => setTaskForm((current) => ({ ...current, taskType: event.target.value }))}
                            value={taskForm.taskType}
                          >
                            {taskTypes.map((type) => (
                              <option key={type.value} value={type.value}>
                                {type.label}
                              </option>
                            ))}
                          </select>
                        </label>
                        <label className="text-center text-xs font-medium text-slate-500">
                          目标题数
                          <input
                            className="mt-1 h-9 w-full rounded-md border border-slate-200 px-2 text-center text-sm text-slate-950 outline-none focus:border-teal-700"
                            min={1}
                            onChange={(event) =>
                              setTaskForm((current) => ({ ...current, targetCount: Number(event.target.value) }))
                            }
                            type="number"
                            value={taskForm.targetCount}
                          />
                        </label>
                        <label className="text-center text-xs font-medium text-slate-500">
                          预计分钟
                          <input
                            className="mt-1 h-9 w-full rounded-md border border-slate-200 px-2 text-center text-sm text-slate-950 outline-none focus:border-teal-700"
                            min={1}
                            onChange={(event) =>
                              setTaskForm((current) => ({ ...current, estimatedMinutes: Number(event.target.value) }))
                            }
                            type="number"
                            value={taskForm.estimatedMinutes}
                          />
                        </label>
                        <label className="text-center text-xs font-medium text-slate-500">
                          优先级
                          <select
                            className="mt-1 h-9 w-full rounded-md border border-slate-200 px-2 text-center text-sm text-slate-950 outline-none focus:border-teal-700"
                            onChange={(event) => setTaskForm((current) => ({ ...current, priority: event.target.value }))}
                            value={taskForm.priority}
                          >
                            {taskPriorities.map((priority) => (
                              <option key={priority.value} value={priority.value}>
                                {priority.label}
                              </option>
                            ))}
                          </select>
                        </label>
                        <label className="text-center text-xs font-medium text-slate-500">
                          重复
                          <select
                            className="mt-1 h-9 w-full rounded-md border border-slate-200 px-2 text-center text-sm text-slate-950 outline-none focus:border-teal-700"
                            onChange={(event) => setTaskForm((current) => ({ ...current, recurrenceRule: event.target.value }))}
                            value={taskForm.recurrenceRule}
                          >
                            {recurrenceRules.map((rule) => (
                              <option key={rule.value} value={rule.value}>
                                {rule.label}
                              </option>
                            ))}
                          </select>
                        </label>
                        <label className="text-center text-xs font-medium text-slate-500">
                          提醒时间
                          <input
                            className="mt-1 h-9 w-full rounded-md border border-slate-200 px-2 text-center text-sm text-slate-950 outline-none focus:border-teal-700"
                            onChange={(event) => setTaskForm((current) => ({ ...current, reminderTime: event.target.value }))}
                            type="time"
                            value={taskForm.reminderTime}
                          />
                        </label>
                        <div className="text-center text-xs font-medium text-slate-500">
                          <span className="text-xs font-medium text-slate-500">操作</span>
                          <button
                            className="mt-1 h-9 w-full rounded-md bg-teal-700 px-3 text-sm font-medium text-white hover:bg-teal-800 disabled:cursor-not-allowed disabled:bg-slate-300"
                            disabled={creatingTask}
                            type="submit"
                          >
                            {creatingTask ? "保存中" : editingTaskId ? "保存" : "添加"}
                          </button>
                        </div>
                        {editingTaskId && (
                          <button
                            className="h-9 self-end rounded-md border border-slate-200 px-3 text-sm font-medium text-slate-700 hover:border-teal-700 hover:text-teal-800"
                            onClick={resetTaskForm}
                            type="button"
                          >
                            取消
                          </button>
                        )}
                      </form>
                    )}
                    {!auth && (
                      <label className="mt-3 block max-w-40 text-xs font-medium text-slate-500">
                        日期
                        <input
                          className="mt-1 h-9 w-full rounded-md border border-slate-200 px-3 text-sm text-slate-950 outline-none focus:border-teal-700"
                          onChange={(event) => {
                            setTaskListStatus("loading");
                            setTaskDate(event.target.value);
                          }}
                          type="date"
                          value={taskDate}
                        />
                      </label>
                    )}
                  </div>
                  {taskStatusError && <p className="mt-2 text-sm text-red-700">{taskStatusError}</p>}
                </div>
                <div className="divide-y divide-slate-100">
                  {(auth === undefined || (auth && taskListStatus === "loading")) && (
                    <div className="px-5 py-4 text-sm text-slate-500">正在加载学习任务...</div>
                  )}
                  {(auth === null || (auth && taskListStatus === "error")) && (
                    <div className="px-5 py-4 text-sm text-red-800">
                      {auth ? "学习任务加载失败。" : "登录后查看学习任务。"}
                    </div>
                  )}
                  {taskListStatus === "success" && tasks.length === 0 && (
                    <div className="px-5 py-4 text-sm text-slate-500">当前日期还没有学习任务。</div>
                  )}
                  {taskListStatus === "success" && tasks.map((task) => (
                    <div className="flex flex-col gap-3 px-5 py-4 md:flex-row md:items-center md:justify-between" key={task.id}>
                      <div>
                        <p className={`font-medium ${task.status === "DONE" ? "text-slate-500 line-through" : ""}`}>
                          {task.title}
                        </p>
                        <p className="mt-1 text-sm text-slate-500">
                          {formatTaskMeta(task)}
                        </p>
                      </div>
                      <div className="flex items-center gap-2">
                        <span className="rounded-md bg-slate-100 px-2.5 py-1 text-xs font-medium text-slate-700">
                          {formatTaskState(task.priority, task.status)}
                        </span>
                        <button
                          className="h-8 rounded-md border border-slate-200 px-3 text-xs font-medium text-slate-700 hover:border-teal-700 hover:text-teal-800 disabled:cursor-not-allowed disabled:opacity-60"
                          disabled={updatingTaskId === task.id}
                          onClick={() => handleTaskStatus(task)}
                          type="button"
                        >
                          {updatingTaskId === task.id
                            ? "更新中"
                            : task.status === "DONE"
                              ? "恢复"
                              : "完成"}
                        </button>
                        <button
                          className="h-8 rounded-md border border-slate-200 px-3 text-xs font-medium text-slate-700 hover:border-teal-700 hover:text-teal-800"
                          onClick={() => startEditTask(task)}
                          type="button"
                        >
                          编辑
                        </button>
                        <button
                          className="h-8 rounded-md border border-red-200 px-3 text-xs font-medium text-red-700 hover:border-red-700"
                          disabled={updatingTaskId === task.id}
                          onClick={() => handleDeleteTask(task.id)}
                          type="button"
                        >
                          删除
                        </button>
                      </div>
                    </div>
                  ))}
                </div>
                {auth && (
                  <div className="border-t border-slate-200 px-5 py-4">
                    <div className="flex items-center justify-between gap-3">
                      <h3 className="text-sm font-semibold text-slate-700">计划视图</h3>
                      <select
                        className="h-8 rounded-md border border-slate-200 px-2 text-xs outline-none focus:border-teal-700"
                        onChange={(event) => setRangeMode(event.target.value as "week" | "month")}
                        value={rangeMode}
                      >
                        <option value="week">本周</option>
                        <option value="month">本月</option>
                      </select>
                    </div>
                    <div className="mt-3 grid gap-2 md:grid-cols-2">
                      {taskRange.length === 0 && (
                        <p className="text-sm text-slate-500">当前视图暂无计划。</p>
                      )}
                      {taskRange.slice(0, 12).map((task, index) => (
                        <div className="rounded-md border border-slate-200 px-3 py-2 text-sm" key={`${task.id}-${task.taskDate}-${index}`}>
                          <div className="flex items-center justify-between gap-2">
                            <span className="font-medium">{task.taskDate}</span>
                            <span className="text-xs text-slate-500">{formatRecurrence(task.recurrenceRule)}</span>
                          </div>
                          <p className="mt-1 line-clamp-1 text-slate-700">{task.title}</p>
                          {task.reminderTime && (
                            <p className="mt-1 text-xs text-teal-700">提醒 {task.reminderTime.slice(0, 5)}</p>
                          )}
                          <div className="mt-2 flex flex-wrap gap-2">
                            <button
                              className="rounded-md border border-slate-200 px-2 py-1 text-xs text-slate-700"
                              onClick={() => handleOccurrenceStatus(task, task.status === "DONE" ? "PENDING" : "DONE")}
                              type="button"
                            >
                              {task.status === "DONE" ? "恢复实例" : "完成实例"}
                            </button>
                            <button
                              className="rounded-md border border-amber-200 px-2 py-1 text-xs text-amber-800"
                              onClick={() => handleOccurrenceStatus(task, task.status === "SKIPPED" ? "PENDING" : "SKIPPED")}
                              type="button"
                            >
                              {task.status === "SKIPPED" ? "取消跳过" : "跳过本次"}
                            </button>
                          </div>
                        </div>
                      ))}
                    </div>
                  </div>
                )}
              </section>
            </div>

            <aside className="space-y-5">
              <section className="app-panel p-5">
                <h2 className="text-base font-semibold">学习提醒</h2>
                <div className="mt-4 space-y-2">
                  {auth === null && <p className="text-sm text-slate-500">登录后查看提醒。</p>}
                  {auth && reminders.length === 0 && <p className="text-sm text-slate-500">当前日期暂无提醒。</p>}
                  {reminders.map((task) => (
                    <div className="rounded-lg border border-teal-100 bg-teal-50 px-3 py-2 text-sm text-teal-950" key={`${task.id}-${task.taskDate}`}>
                      <p className="font-medium">{task.title}</p>
                      <p className="mt-1 text-xs">服务端提醒 · {task.reminderTime?.slice(0, 5)}</p>
                    </div>
                  ))}
                </div>
              </section>

              <section className="app-panel p-5">
                <h2 className="text-base font-semibold">薄弱知识点</h2>
                <div className="mt-4 space-y-2">
                  {(auth === undefined || (auth && dashboardStatus === "loading")) && (
                    <p className="rounded-md bg-slate-50 p-3 text-sm text-slate-500">正在加载分析...</p>
                  )}
                  {(auth === null || (auth && dashboardStatus === "error")) && (
                    <p className="rounded-md bg-red-50 p-3 text-sm text-red-800">
                      {auth ? "学习分析加载失败。" : "登录后查看薄弱知识点。"}
                    </p>
                  )}
                  {dashboardStatus === "success" && studyDashboard?.weakKnowledgePoints.length === 0 && (
                    <p className="rounded-md bg-slate-50 p-3 text-sm text-slate-600">暂无薄弱知识点。</p>
                  )}
                  {dashboardStatus === "success" &&
                    studyDashboard?.weakKnowledgePoints.map((point) => (
                      <Link
                        className="flex w-full items-center justify-between gap-3 rounded-lg border border-slate-200 bg-white px-3 py-2 text-left text-sm shadow-sm shadow-slate-950/[0.02] hover:border-teal-600 hover:text-teal-800"
                        href="/mistakes"
                        key={point.id}
                      >
                        <span>
                          <span className="block font-medium">{point.name}</span>
                          <span className="mt-1 block text-xs text-slate-500">
                            {subjectLabels[point.subjectCode] ?? point.subjectName} · {point.chapterName}
                          </span>
                        </span>
                        <span className="shrink-0 text-xs text-slate-500">错 {point.wrongCount} 次</span>
                      </Link>
                    ))}
                </div>
              </section>

              <section className="app-panel p-5">
                <div className="flex items-center justify-between gap-3">
                  <h2 className="text-base font-semibold">最近错题</h2>
                  <Link className="text-xs font-medium text-teal-700 hover:text-teal-800" href="/mistakes">
                    查看全部
                  </Link>
                </div>
                <div className="mt-4 space-y-3 text-sm">
                  {(auth === undefined || (auth && mistakeStatus === "loading")) && (
                    <p className="rounded-md bg-slate-50 p-3 text-slate-500">正在加载错题...</p>
                  )}
                  {(auth === null || (auth && mistakeStatus === "error")) && (
                    <p className="rounded-md bg-red-50 p-3 text-red-800">
                      {auth ? "错题加载失败，请确认后端已启动。" : "登录后查看最近错题。"}
                    </p>
                  )}
                  {mistakeStatus === "success" && recentMistakes.length === 0 && (
                    <p className="rounded-md bg-slate-50 p-3 text-slate-600">当前还没有错题，今天很稳。</p>
                  )}
                  {mistakeStatus === "success" &&
                    recentMistakes.map((mistake) => (
                      <Link
                        className="block rounded-lg border border-red-100 bg-red-50 p-3 text-red-800 hover:bg-red-100"
                        href={`/practice/${mistake.questionId}`}
                        key={mistake.id}
                      >
                        <span className="block text-xs font-medium">
                          {subjectLabels[mistake.subjectCode] ?? mistake.subjectName} · 错 {mistake.wrongCount} 次
                        </span>
                        <span className="mt-1 line-clamp-3 block whitespace-pre-wrap">{formatQuestionText(mistake.stem)}</span>
                      </Link>
                    ))}
                </div>
              </section>
            </aside>
          </div>
        </section>
      </div>
    </main>
  );
}

function buildDashboardSlogan(
  auth: AuthResult | null | undefined,
  status: "loading" | "success" | "error",
  dashboard: StudyDashboard | null,
) {
  if (auth === undefined || (auth && status === "loading")) {
    return "正在同步今日练习节奏，稍后给出最适合的推进建议。";
  }
  if (auth === null) {
    return "登录后同步目标、薄弱点和错题节奏，让练习更贴合今天的状态。";
  }
  if (status === "error" || !dashboard) {
    return "数据暂时没有同步成功，先从题库热身，保持手感不断线。";
  }

  const remaining = Math.max(0, dashboard.todayGoal.targetCount - dashboard.todayGoal.completedCount);
  const weakPoint = dashboard.weakKnowledgePoints[0];
  const weakestSubject = dashboard.subjectMasteries
    .filter((subject) => subject.practicedCount > 0)
    .sort((a, b) => a.masteryPercent - b.masteryPercent)[0];

  if (weakPoint) {
    return `优先攻克${weakPoint.name}，再用${remaining || dashboard.todayGoal.targetCount}题巩固今天的练习节奏。`;
  }
  if (remaining > 0 && weakestSubject) {
    return `今天还差${remaining}题，建议先补${subjectLabels[weakestSubject.subjectCode] ?? weakestSubject.subjectName}的薄弱环节。`;
  }
  if (remaining > 0) {
    return `今天还差${remaining}题，保持小步快跑，把目标稳稳推进。`;
  }

  return `今日目标已完成，本周正确率${dashboard.weeklyAccuracy.percent}%，可以复盘错题或加练一组。`;
}

function isAdmin(user: CurrentUser | null) {
  return user?.roles.includes("ADMIN") ?? false;
}

function canViewTeacherStudents(user: CurrentUser | null) {
  return user?.roles.includes("TEACHER") || user?.roles.includes("ADMIN") || false;
}

function FutureLogo() {
  return (
    <svg aria-hidden="true" className="size-7" fill="none" viewBox="0 0 32 32">
      <path d="M16 4.8 25.7 10.4v11.2L16 27.2 6.3 21.6V10.4L16 4.8Z" stroke="currentColor" strokeLinejoin="round" strokeWidth="1.8" />
      <path d="M16 11.2 20.1 13.6v4.8L16 20.8 11.9 18.4v-4.8L16 11.2Z" stroke="currentColor" strokeLinejoin="round" strokeWidth="1.5" />
      <path d="M11.9 13.6 8.9 11.9M20.1 13.6l3-1.7M11.9 18.4l-3 1.7M20.1 18.4l3 1.7" stroke="currentColor" strokeLinecap="round" strokeWidth="1.5" />
      <path d="M16 8.1v3.1M16 20.8v3.1" stroke="currentColor" strokeLinecap="round" strokeWidth="1.5" />
      <circle cx="16" cy="16" r="1.6" stroke="currentColor" strokeWidth="1.4" />
    </svg>
  );
}

function CountdownBadge() {
  const countdown = useCountdown(postgraduateExamTarget);

  return (
    <div
      className="rounded-md border border-slate-200 px-3 py-2 text-slate-600"
      title="按 2026/12/26 08:30 计算"
    >
      考研倒计时{" "}
      <span className="font-semibold text-slate-950">
        {countdown ? `${countdown.days} 天 ${countdown.hours}:${countdown.minutes}:${countdown.seconds}` : "-- 天 --:--:--"}
      </span>
    </div>
  );
}

function useCountdown(target: Date) {
  const [remaining, setRemaining] = useState<ReturnType<typeof calculateRemaining> | null>(null);

  useEffect(() => {
    const updateRemaining = () => {
      setRemaining(calculateRemaining(target));
    };
    const timer = window.setInterval(updateRemaining, 1000);
    window.requestAnimationFrame(updateRemaining);

    return () => window.clearInterval(timer);
  }, [target]);

  return remaining;
}

function calculateRemaining(target: Date) {
  const diff = Math.max(0, target.getTime() - Date.now());
  const totalSeconds = Math.floor(diff / 1000);
  const days = Math.floor(totalSeconds / 86400);
  const hours = Math.floor((totalSeconds % 86400) / 3600);
  const minutes = Math.floor((totalSeconds % 3600) / 60);
  const seconds = totalSeconds % 60;

  return {
    days,
    hours: padClock(hours),
    minutes: padClock(minutes),
    seconds: padClock(seconds),
  };
}

function padClock(value: number) {
  return value.toString().padStart(2, "0");
}

function Metric({ title, value, hint }: { title: string; value: string; hint: ReactNode }) {
  return (
    <section className="app-panel p-5">
      <p className="text-sm font-medium text-slate-500">{title}</p>
      <p className="mt-2 text-3xl font-semibold tracking-tight text-slate-950">{value}</p>
      <p className="mt-2 text-xs text-slate-500">{hint}</p>
    </section>
  );
}

function WeeklyAccuracyHint({ deltaPercent, attemptCount }: { deltaPercent: number; attemptCount: number }) {
  if (deltaPercent === 0) {
    return <>较上周持平 · {attemptCount} 次提交</>;
  }

  const isImproved = deltaPercent > 0;
  return (
    <>
      较上周{" "}
      <span className={isImproved ? "font-medium text-red-600" : "font-medium text-emerald-600"}>
        {isImproved ? `+${deltaPercent}%` : `${deltaPercent}%`}
      </span>{" "}
      · {attemptCount} 次提交
    </>
  );
}

function StateCard({ text, tone = "default" }: { text: string; tone?: "default" | "error" }) {
  return (
    <div
      className={`rounded-md border border-slate-200 p-4 text-sm ${
        tone === "error" ? "bg-red-50 text-red-800" : "bg-slate-50 text-slate-500"
      }`}
    >
      {text}
    </div>
  );
}

function formatTaskMeta(task: StudyDashboard["todayTasks"][number]) {
  const recurrence = formatRecurrence(task.recurrenceRule);
  const reminder = task.reminderTime ? ` · ${task.reminderTime.slice(0, 5)} 提醒` : "";
  return `${subjectLabels[task.subjectCode] ?? task.subjectCode} · ${task.targetCount} 题 · 预计 ${
    task.estimatedMinutes
  } 分钟 · ${recurrence}${reminder}`;
}

function formatRecurrence(rule: string) {
  if (rule === "DAILY") {
    return "每天";
  }
  if (rule === "WEEKLY") {
    return "每周";
  }
  if (rule === "MONTHLY") {
    return "每月";
  }
  return "不重复";
}

function formatTaskState(priority: string, status: string) {
  if (status === "DONE") {
    return "已完成";
  }
  if (status === "SKIPPED") {
    return "已跳过";
  }
  if (priority === "IMPORTANT") {
    return "重点";
  }
  if (priority === "REVIEW") {
    return "复习";
  }
  return "待开始";
}

function todayString() {
  return new Date().toISOString().slice(0, 10);
}

function rangeBounds(dateText: string, mode: "week" | "month"): [string, string] {
  const date = new Date(`${dateText}T00:00:00`);
  if (mode === "month") {
    const start = new Date(date.getFullYear(), date.getMonth(), 1);
    const end = new Date(date.getFullYear(), date.getMonth() + 1, 0);
    return [toDateString(start), toDateString(end)];
  }
  const day = date.getDay() || 7;
  const start = new Date(date);
  start.setDate(date.getDate() - day + 1);
  const end = new Date(start);
  end.setDate(start.getDate() + 6);
  return [toDateString(start), toDateString(end)];
}

function toDateString(date: Date) {
  return date.toISOString().slice(0, 10);
}
