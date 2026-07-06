"use client";

import Link from "next/link";
import type { FormEvent, ReactNode } from "react";
import { useCallback, useEffect, useState } from "react";
import {
  StudentLearningSummary,
  TeacherClassView,
  TeacherUserView,
  addTeacherClassStudents,
  createTeacherClass,
  fetchCurrentUser,
  fetchTeacherClasses,
  fetchTeacherStudentCandidates,
  fetchTeacherStudents,
  fetchTeacherUsers,
  getAuth,
  removeTeacherClassStudent,
} from "@/app/lib/api";

export default function TeacherBindingsPage() {
  const [access, setAccess] = useState<"checking" | "login" | "denied" | "allowed">("checking");
  const [teacherUsers, setTeacherUsers] = useState<TeacherUserView[]>([]);
  const [teacherClasses, setTeacherClasses] = useState<TeacherClassView[]>([]);
  const [bindingStudents, setBindingStudents] = useState<StudentLearningSummary[]>([]);
  const [studentCandidates, setStudentCandidates] = useState<StudentLearningSummary[]>([]);
  const [selectedTeacherId, setSelectedTeacherId] = useState("");
  const [selectedBindingClassId, setSelectedBindingClassId] = useState("");
  const [selectedStudentToBind, setSelectedStudentToBind] = useState("");
  const [bindingKeyword, setBindingKeyword] = useState("");
  const [bindingMessage, setBindingMessage] = useState("");
  const [teacherClassForm, setTeacherClassForm] = useState({
    teacherId: "",
    name: "",
    courseName: "408 综合",
    description: "",
  });

  const refreshTeacherBindings = useCallback(async () => {
    const [teachers, classes, candidates] = await Promise.all([
      fetchTeacherUsers(),
      fetchTeacherClasses(),
      fetchTeacherStudentCandidates(),
    ]);
    setTeacherUsers(teachers);
    setTeacherClasses(classes);
    setStudentCandidates(candidates);
    setSelectedTeacherId((current) => current || teachers[0]?.id || "");
    setSelectedBindingClassId((current) => current || classes.find((item) => item.teacherId === teachers[0]?.id)?.id || "");
    setTeacherClassForm((current) => ({ ...current, teacherId: current.teacherId || teachers[0]?.id || "" }));
  }, []);

  useEffect(() => {
    let cancelled = false;
    Promise.resolve().then(() => {
      const auth = getAuth();
      if (!auth) {
        setAccess("login");
        return;
      }
      fetchCurrentUser()
        .then((user) => {
          if (!cancelled) {
            setAccess(user.roles.includes("ADMIN") ? "allowed" : "denied");
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
    Promise.resolve()
      .then(refreshTeacherBindings)
      .catch(() => setBindingMessage("师生绑定数据加载失败。"));
  }, [access, refreshTeacherBindings]);

  useEffect(() => {
    Promise.resolve().then(() => {
      if (!selectedBindingClassId) {
        setBindingStudents([]);
        return;
      }
      fetchTeacherStudents({ classId: selectedBindingClassId })
        .then(setBindingStudents)
        .catch(() => setBindingMessage("班级学生加载失败。"));
    });
  }, [selectedBindingClassId]);

  async function handleCreateTeacherClass(event: FormEvent<HTMLFormElement>) {
    event.preventDefault();
    setBindingMessage("");
    try {
      const created = await createTeacherClass({
        teacherId: teacherClassForm.teacherId,
        name: teacherClassForm.name,
        courseName: teacherClassForm.courseName,
        description: teacherClassForm.description || null,
      });
      setTeacherClasses((current) => [created, ...current]);
      setSelectedTeacherId(created.teacherId);
      setSelectedBindingClassId(created.id);
      setTeacherClassForm((current) => ({ ...current, name: "", description: "" }));
      setBindingMessage("教师班级已创建。");
    } catch {
      setBindingMessage("班级创建失败，请确认教师和班级名称。");
    }
  }

  async function handleSearchStudentCandidates() {
    setBindingMessage("");
    try {
      setStudentCandidates(await fetchTeacherStudentCandidates(bindingKeyword));
    } catch {
      setBindingMessage("学生候选加载失败。");
    }
  }

  async function handleBindStudent(event: FormEvent<HTMLFormElement>) {
    event.preventDefault();
    if (!selectedBindingClassId || !selectedStudentToBind) {
      setBindingMessage("请选择班级和学生。");
      return;
    }
    try {
      const updated = await addTeacherClassStudents(selectedBindingClassId, [selectedStudentToBind]);
      setTeacherClasses((current) => current.map((item) => (item.id === updated.id ? updated : item)));
      setBindingStudents(await fetchTeacherStudents({ classId: selectedBindingClassId }));
      setSelectedStudentToBind("");
      setBindingMessage("学生已绑定到该老师。");
    } catch {
      setBindingMessage("学生绑定失败。");
    }
  }

  async function handleRemoveBoundStudent(studentId: string) {
    if (!selectedBindingClassId) {
      return;
    }
    try {
      const updated = await removeTeacherClassStudent(selectedBindingClassId, studentId);
      setTeacherClasses((current) => current.map((item) => (item.id === updated.id ? updated : item)));
      setBindingStudents((current) => current.filter((student) => student.id !== studentId));
      setBindingMessage("学生绑定已解除。");
    } catch {
      setBindingMessage("解除绑定失败。");
    }
  }

  if (access === "checking") {
    return <StatePage title="师生绑定" text="正在校验管理权限..." />;
  }

  if (access === "login") {
    return <StatePage title="师生绑定" text="请先登录管理员账号。" actionHref="/login" actionLabel="去登录" />;
  }

  if (access === "denied") {
    return <StatePage title="师生绑定" text="当前账号没有师生绑定管理权限。" actionHref="/" actionLabel="返回仪表盘" />;
  }

  return (
    <main className="app-bg">
      <div className="mx-auto max-w-7xl px-4 py-6 sm:px-6 lg:py-8">
        <header className="app-panel px-5 py-5 sm:px-6 sm:py-6">
          <Link className="text-sm font-medium text-teal-700" href="/">
            返回仪表盘
          </Link>
          <h1 className="mt-3 text-3xl font-semibold">师生绑定</h1>
          <p className="mt-2 text-sm text-slate-500">管理教师班级和学生归属关系。</p>
        </header>

        <section className="app-panel mt-5 p-5 sm:p-6">
          <p className="text-sm text-slate-500">学生可以加入多位老师的班级，老师只能查看自己班级内的学生。</p>

          <div className="mt-5 grid gap-5 lg:grid-cols-2">
            <form className="grid gap-3 rounded-md border border-slate-200 bg-slate-50/50 p-4" onSubmit={handleCreateTeacherClass}>
              <h2 className="text-sm font-semibold">创建教师班级</h2>
              <select
                className="field"
                onChange={(event) => setTeacherClassForm((current) => ({ ...current, teacherId: event.target.value }))}
                required
                value={teacherClassForm.teacherId}
              >
                <option value="">选择老师</option>
                {teacherUsers.map((teacher) => (
                  <option key={teacher.id} value={teacher.id}>
                    {teacher.displayName} @{teacher.username}
                  </option>
                ))}
              </select>
              <div className="grid gap-3 md:grid-cols-2">
                <input
                  className="field"
                  onChange={(event) => setTeacherClassForm((current) => ({ ...current, name: event.target.value }))}
                  placeholder="班级名称"
                  required
                  value={teacherClassForm.name}
                />
                <input
                  className="field"
                  onChange={(event) => setTeacherClassForm((current) => ({ ...current, courseName: event.target.value }))}
                  placeholder="课程名称"
                  required
                  value={teacherClassForm.courseName}
                />
              </div>
              <input
                className="field"
                onChange={(event) => setTeacherClassForm((current) => ({ ...current, description: event.target.value }))}
                placeholder="班级备注"
                value={teacherClassForm.description}
              />
              <button className="h-10 rounded-md bg-slate-900 px-4 text-sm font-semibold text-white hover:bg-slate-800" type="submit">
                创建班级
              </button>
            </form>

            <div className="grid gap-3 rounded-md border border-slate-200 bg-slate-50/50 p-4">
              <h2 className="text-sm font-semibold">维护学生归属</h2>
              <select
                className="field"
                onChange={(event) => {
                  const teacherId = event.target.value;
                  setSelectedTeacherId(teacherId);
                  setSelectedBindingClassId(teacherClasses.find((item) => item.teacherId === teacherId)?.id || "");
                }}
                value={selectedTeacherId}
              >
                <option value="">选择老师</option>
                {teacherUsers.map((teacher) => (
                  <option key={teacher.id} value={teacher.id}>
                    {teacher.displayName} @{teacher.username}
                  </option>
                ))}
              </select>
              <select className="field" onChange={(event) => setSelectedBindingClassId(event.target.value)} value={selectedBindingClassId}>
                <option value="">选择班级</option>
                {teacherClasses
                  .filter((item) => item.teacherId === selectedTeacherId)
                  .map((item) => (
                    <option key={item.id} value={item.id}>
                      {item.name} · {item.studentCount} 人
                    </option>
                  ))}
              </select>
              <form className="grid gap-3" onSubmit={handleBindStudent}>
                <div className="grid gap-3 md:grid-cols-[minmax(0,1fr)_110px]">
                  <input
                    className="field"
                    onChange={(event) => setBindingKeyword(event.target.value)}
                    placeholder="搜索学生用户名或昵称"
                    value={bindingKeyword}
                  />
                  <button
                    className="app-button-secondary h-10 py-0"
                    onClick={handleSearchStudentCandidates}
                    type="button"
                  >
                    搜索
                  </button>
                </div>
                <select className="field" onChange={(event) => setSelectedStudentToBind(event.target.value)} value={selectedStudentToBind}>
                  <option value="">选择学生</option>
                  {studentCandidates.map((student) => (
                    <option key={student.id} value={student.id}>
                      {student.displayName} @{student.username}
                    </option>
                  ))}
                </select>
                <button
                  className="app-button-primary h-10 py-0"
                  disabled={!selectedBindingClassId}
                  type="submit"
                >
                  绑定到当前老师
                </button>
              </form>
            </div>
          </div>

          <div className="mt-5 border-t border-slate-100 pt-4">
            <h2 className="text-sm font-semibold">当前班级学生</h2>
            <div className="mt-3 divide-y divide-slate-100 overflow-hidden rounded-md border border-slate-200 bg-white">
              {!selectedBindingClassId && <p className="p-4 text-sm text-slate-500">请先选择老师和班级。</p>}
              {selectedBindingClassId && bindingStudents.length === 0 && <p className="p-4 text-sm text-slate-500">当前班级暂无学生。</p>}
              {bindingStudents.map((student) => (
                <div className="flex items-center justify-between gap-3 px-4 py-3 hover:bg-slate-50" key={student.id}>
                  <div>
                    <p className="text-sm font-medium">{student.displayName}</p>
                    <p className="mt-1 text-xs text-slate-500">@{student.username}</p>
                  </div>
                  <button
                    className="rounded-md border border-red-200 px-3 py-1.5 text-xs font-medium text-red-700 hover:bg-red-50"
                    onClick={() => void handleRemoveBoundStudent(student.id)}
                    type="button"
                  >
                    解除绑定
                  </button>
                </div>
              ))}
            </div>
            {bindingMessage && <p className="mt-3 text-sm text-slate-600">{bindingMessage}</p>}
          </div>
        </section>
      </div>
    </main>
  );
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
    <PageShell title={title}>
      <p className="text-sm text-slate-500">{text}</p>
      {actionHref && actionLabel && (
        <Link className="mt-5 inline-flex rounded-md bg-teal-700 px-4 py-2 text-sm font-medium text-white" href={actionHref}>
          {actionLabel}
        </Link>
      )}
    </PageShell>
  );
}

function PageShell({ title, children }: { title: string; children: ReactNode }) {
  return (
    <main className="min-h-screen bg-[#f6f8f9] px-5 py-6 text-slate-950">
      <section className="mx-auto max-w-2xl rounded-lg border border-slate-200 bg-white p-6">
        <Link className="text-sm font-medium text-teal-700" href="/">
          返回仪表盘
        </Link>
        <h1 className="mt-4 text-2xl font-semibold">{title}</h1>
        <div className="mt-5">{children}</div>
      </section>
    </main>
  );
}
