"use client";

import Link from "next/link";
import type { FormEvent, ReactNode } from "react";
import { useEffect, useState, useSyncExternalStore } from "react";
import { CurrentUser, createTeacher, fetchCurrentUser, getAuth } from "@/app/lib/api";

export default function RootTeachersPage() {
  const [currentUser, setCurrentUser] = useState<CurrentUser | null>(null);
  const [access, setAccess] = useState<"checking" | "login" | "denied" | "allowed">("checking");
  const [username, setUsername] = useState("");
  const [displayName, setDisplayName] = useState("");
  const [password, setPassword] = useState("");
  const [message, setMessage] = useState("");
  const [submitting, setSubmitting] = useState(false);
  const hasAuth = useSyncExternalStore(subscribeAuth, getAuthSnapshot, getAuthServerSnapshot);

  useEffect(() => {
    if (hasAuth !== true) {
      return;
    }

    fetchCurrentUser()
      .then((user) => {
        setCurrentUser(user);
        setAccess(user.roles.includes("ADMIN") ? "allowed" : "denied");
      })
      .catch(() => setAccess("login"));
  }, [hasAuth]);

  async function handleSubmit(event: FormEvent<HTMLFormElement>) {
    event.preventDefault();
    setSubmitting(true);
    setMessage("");
    try {
      const teacher = await createTeacher({ username, displayName, password });
      setUsername("");
      setDisplayName("");
      setPassword("");
      setMessage(`已创建教师账号：${teacher.displayName}（${teacher.username}）`);
    } catch (err) {
      setMessage(err instanceof Error ? err.message : "创建教师失败");
    } finally {
      setSubmitting(false);
    }
  }

  if (hasAuth === false || access === "login") {
    return (
      <Shell title="添加教师">
        <p className="text-sm text-slate-500">请先使用管理员账号登录。</p>
        <Link className="app-button-primary mt-5 inline-flex" href="/login">
          去登录
        </Link>
      </Shell>
    );
  }

  if (hasAuth === null || access === "checking") {
    return <Shell title="添加教师" />;
  }

  if (access === "denied") {
    return (
      <Shell title="添加教师">
        <p className="text-sm text-slate-500">只有系统管理员可以新增教师账号。</p>
        <Link className="app-button-secondary mt-5 inline-flex" href="/">
          返回仪表盘
        </Link>
      </Shell>
    );
  }

  return (
    <Shell title="添加教师" subtitle={`当前操作人：${currentUser?.displayName ?? "管理员"}`}>
      <form className="mt-5 grid gap-4" onSubmit={handleSubmit}>
        <label className="block text-sm font-medium text-slate-700">
          教师用户名
          <input
            className="field mt-2"
            onChange={(event) => setUsername(event.target.value)}
            placeholder="例如 teacher_01"
            value={username}
          />
        </label>
        <label className="block text-sm font-medium text-slate-700">
          教师昵称
          <input
            className="field mt-2"
            onChange={(event) => setDisplayName(event.target.value)}
            placeholder="例如 张老师"
            value={displayName}
          />
        </label>
        <label className="block text-sm font-medium text-slate-700">
          初始密码
          <input
            className="field mt-2"
            onChange={(event) => setPassword(event.target.value)}
            placeholder="至少 8 位"
            type="password"
            value={password}
          />
        </label>
        {message && <p aria-live="polite" className="rounded-md bg-slate-50 p-3 text-sm text-slate-600">{message}</p>}
        <button
          className="app-button-primary w-fit"
          disabled={submitting}
          type="submit"
        >
          {submitting ? "创建中..." : "创建教师账号"}
        </button>
      </form>
    </Shell>
  );
}

function Shell({ title, subtitle, children }: { title: string; subtitle?: string; children?: ReactNode }) {
  return (
    <main className="app-bg">
      <section className="app-container max-w-2xl">
        <div className="app-page-header">
        <Link className="text-sm font-medium text-teal-700" href="/">
          返回仪表盘
        </Link>
        <h1 className="app-page-title mt-4">{title}</h1>
        {subtitle && <p className="app-page-description">{subtitle}</p>}
        {children}
        </div>
      </section>
    </main>
  );
}

function subscribeAuth(callback: () => void) {
  if (typeof window === "undefined") {
    return () => {};
  }
  window.addEventListener("storage", callback);
  const timer = window.setTimeout(callback, 0);
  return () => {
    window.removeEventListener("storage", callback);
    window.clearTimeout(timer);
  };
}

function getAuthSnapshot() {
  return Boolean(getAuth());
}

function getAuthServerSnapshot() {
  return null;
}
