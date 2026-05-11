"use client";

import Link from "next/link";
import { FormEvent, useState } from "react";
import { useRouter } from "next/navigation";
import { login, register, saveAuth } from "@/app/lib/api";

export default function LoginPage() {
  const router = useRouter();
  const [mode, setMode] = useState<"login" | "register">("login");
  const [username, setUsername] = useState("demo");
  const [displayName, setDisplayName] = useState("研码同学");
  const [password, setPassword] = useState("yanma408");
  const [submitting, setSubmitting] = useState(false);
  const [error, setError] = useState("");

  const handleSubmit = async (event: FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    setSubmitting(true);
    setError("");
    try {
      const auth =
        mode === "login"
          ? await login({ username, password })
          : await register({ username, displayName, password });
      saveAuth(auth);
      router.push("/");
    } catch (err) {
      setError(err instanceof Error ? err.message : "认证失败");
    } finally {
      setSubmitting(false);
    }
  };

  return (
    <main className="grid min-h-screen place-items-center bg-[#f6f8f9] px-5 text-slate-950">
      <section className="w-full max-w-md rounded-lg border border-slate-200 bg-white p-6">
        <Link className="text-sm font-medium text-teal-700" href="/">
          返回首页
        </Link>
        <h1 className="mt-4 text-2xl font-semibold">{mode === "login" ? "登录研码408" : "注册研码408"}</h1>
        <p className="mt-2 text-sm text-slate-500">默认演示账号：demo / yanma408。</p>

        <div className="mt-5 grid grid-cols-2 gap-2 rounded-md bg-slate-100 p-1 text-sm">
          <button
            className={`rounded-md px-3 py-2 font-medium ${mode === "login" ? "bg-white text-teal-800 shadow-sm" : "text-slate-600"}`}
            onClick={() => setMode("login")}
            type="button"
          >
            登录
          </button>
          <button
            className={`rounded-md px-3 py-2 font-medium ${mode === "register" ? "bg-white text-teal-800 shadow-sm" : "text-slate-600"}`}
            onClick={() => setMode("register")}
            type="button"
          >
            注册
          </button>
        </div>

        <form className="mt-5 space-y-4" onSubmit={handleSubmit}>
          <label className="block text-sm font-medium">
            用户名
            <input
              className="mt-2 w-full rounded-md border border-slate-200 px-3 py-2 outline-none focus:border-teal-700"
              onChange={(event) => setUsername(event.target.value)}
              value={username}
            />
          </label>

          {mode === "register" && (
            <label className="block text-sm font-medium">
              昵称
              <input
                className="mt-2 w-full rounded-md border border-slate-200 px-3 py-2 outline-none focus:border-teal-700"
                onChange={(event) => setDisplayName(event.target.value)}
                value={displayName}
              />
            </label>
          )}

          <label className="block text-sm font-medium">
            密码
            <input
              className="mt-2 w-full rounded-md border border-slate-200 px-3 py-2 outline-none focus:border-teal-700"
              onChange={(event) => setPassword(event.target.value)}
              type="password"
              value={password}
            />
          </label>

          {error && <p className="rounded-md bg-red-50 p-3 text-sm text-red-800">{error}</p>}

          <button
            className="w-full rounded-md bg-teal-700 px-4 py-2 text-sm font-medium text-white hover:bg-teal-800 disabled:bg-slate-300"
            disabled={submitting}
            type="submit"
          >
            {submitting ? "处理中..." : mode === "login" ? "登录" : "注册并登录"}
          </button>
        </form>
      </section>
    </main>
  );
}
