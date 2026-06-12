"use client";

import Link from "next/link";
import { FormEvent, useState } from "react";
import { useRouter } from "next/navigation";
import { login, register, saveAuth } from "@/app/lib/api";

export default function LoginPage() {
  const router = useRouter();
  const [mode, setMode] = useState<"login" | "register">("login");
  const [username, setUsername] = useState("");
  const [displayName, setDisplayName] = useState("");
  const [password, setPassword] = useState("");
  const [showPassword, setShowPassword] = useState(false);
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
    <main className="relative grid min-h-screen overflow-hidden bg-slate-950 px-5 py-10 text-slate-950">
      <Starfield />
      <section className="relative z-10 m-auto flex w-full max-w-[560px] flex-col rounded-3xl border border-cyan-100/50 bg-white/92 p-8 shadow-2xl shadow-cyan-950/30 backdrop-blur-xl">
        <div className="flex items-center justify-between gap-4">
          <Link className="text-sm font-medium text-teal-700 hover:text-teal-800" href="/">
            返回首页
          </Link>
        </div>

        <div className="mt-8 flex flex-col items-center justify-center gap-3 text-center sm:flex-row sm:text-left">
          <div className="flex items-center gap-3">
            <span className="grid size-11 place-items-center rounded-xl bg-slate-950 text-white shadow-lg shadow-slate-950/25">
              <FutureLogo />
            </span>
            <p className="text-3xl font-semibold tracking-normal">研码408</p>
          </div>
          <p className="max-w-48 border-teal-200 text-sm leading-5 text-slate-500 sm:border-l sm:pl-3">
            把每一次练习，沉淀成上岸的确定性。
          </p>
        </div>

        <form className="mt-8 space-y-5" onSubmit={handleSubmit}>
          <label className="block text-sm font-medium">
            用户名
            <input
              className="mt-2 w-full rounded-xl border border-slate-200 bg-white px-4 py-3 outline-none focus:border-teal-700"
              onChange={(event) => setUsername(event.target.value)}
              placeholder={mode === "login" ? "请输入用户名" : "设置用户名"}
              value={username}
            />
          </label>

          {mode === "register" && (
            <label className="block text-sm font-medium">
              昵称
              <input
                className="mt-2 w-full rounded-xl border border-slate-200 bg-white px-4 py-3 outline-none focus:border-teal-700"
                onChange={(event) => setDisplayName(event.target.value)}
                placeholder="设置昵称"
                value={displayName}
              />
            </label>
          )}

          <label className="block text-sm font-medium">
            密码
            <span className="mt-2 flex w-full items-center rounded-xl border border-slate-200 bg-white pr-2 focus-within:border-teal-700">
              <input
                className="min-w-0 flex-1 rounded-xl px-4 py-3 outline-none"
                onChange={(event) => setPassword(event.target.value)}
                placeholder={mode === "login" ? "请输入密码" : "至少 8 位密码"}
                type={showPassword ? "text" : "password"}
                value={password}
              />
              <button
                aria-label={showPassword ? "隐藏密码" : "显示密码"}
                className="grid size-9 place-items-center rounded-lg text-slate-500 hover:bg-slate-100 hover:text-teal-800"
                onClick={() => setShowPassword((current) => !current)}
                type="button"
              >
                {showPassword ? <EyeOffIcon /> : <EyeIcon />}
              </button>
            </span>
          </label>

          {error && <p className="rounded-md bg-red-50 p-3 text-sm text-red-800">{error}</p>}

          <button
            className="w-full rounded-xl bg-teal-700 px-4 py-3 text-sm font-medium text-white hover:bg-teal-800 disabled:bg-slate-300"
            disabled={submitting}
            type="submit"
          >
            {submitting ? "处理中..." : mode === "login" ? "登录" : "注册并登录"}
          </button>
        </form>

        <p className="mt-5 text-center text-xs leading-5 text-slate-500">
          注册或登录即代表您同意
          <Link className="font-medium text-teal-700 hover:text-teal-800" href="#">
            《用户协议》
          </Link>
          和
          <Link className="font-medium text-teal-700 hover:text-teal-800" href="#">
            《隐私协议》
          </Link>
        </p>

        <div className="mt-8 flex items-center justify-between gap-4 text-sm">
          <button
            className={`min-w-28 rounded-xl px-4 py-2.5 font-medium ${
              mode === "login" ? "bg-teal-700 text-white shadow-lg shadow-teal-900/20" : "bg-slate-100 text-slate-600 hover:bg-slate-200"
            }`}
            onClick={() => setMode("login")}
            type="button"
          >
            登录
          </button>
          <button
            className={`min-w-28 rounded-xl px-4 py-2.5 font-medium ${
              mode === "register" ? "bg-teal-700 text-white shadow-lg shadow-teal-900/20" : "bg-slate-100 text-slate-600 hover:bg-slate-200"
            }`}
            onClick={() => setMode("register")}
            type="button"
          >
            注册
          </button>
        </div>
      </section>
    </main>
  );
}

function Starfield() {
  return (
    <div aria-hidden="true" className="pointer-events-none absolute inset-0 overflow-hidden">
      <div className="absolute inset-0 bg-[radial-gradient(circle_at_50%_18%,rgba(125,211,252,0.28),transparent_28%),radial-gradient(circle_at_80%_70%,rgba(45,212,191,0.22),transparent_30%),radial-gradient(circle_at_16%_82%,rgba(14,165,233,0.18),transparent_32%),linear-gradient(145deg,#020617_0%,#061329_44%,#020617_100%)]" />
      <div className="absolute inset-0 bg-[linear-gradient(rgba(45,212,191,0.09)_1px,transparent_1px),linear-gradient(90deg,rgba(56,189,248,0.08)_1px,transparent_1px)] bg-[size:72px_72px] opacity-40" />
      <div className="login-orbit-grid absolute inset-x-[-10%] bottom-[-18%] h-[58%]" />
      <div className="absolute left-[-12%] top-[18%] h-44 w-[72%] rotate-[-14deg] bg-gradient-to-r from-transparent via-cyan-300/14 to-transparent blur-xl" />
      <div className="absolute right-[-10%] top-[36%] h-32 w-[58%] rotate-[16deg] bg-gradient-to-r from-transparent via-teal-200/12 to-transparent blur-xl" />
      <div className="star-layer star-layer-slow absolute inset-0" />
      <div className="star-layer star-layer-fast absolute inset-0" />
      <div className="login-scan-line absolute left-0 top-0 h-px w-full bg-gradient-to-r from-transparent via-cyan-200/70 to-transparent" />
      <div className="absolute left-1/2 top-20 h-px w-[68vw] -translate-x-1/2 bg-gradient-to-r from-transparent via-cyan-100/50 to-transparent" />
      <div className="absolute bottom-[-18%] left-1/2 h-[42%] w-[78%] -translate-x-1/2 rounded-[999px] bg-teal-500/10 blur-3xl" />
      <div className="absolute inset-0 opacity-35">
        <div className="absolute left-[12%] top-[18%] size-1 rounded-full bg-cyan-100 shadow-[0_0_18px_4px_rgba(186,230,253,0.45)]" />
        <div className="absolute left-[76%] top-[24%] size-1.5 rounded-full bg-white shadow-[0_0_22px_6px_rgba(255,255,255,0.42)]" />
        <div className="absolute left-[62%] top-[68%] size-1 rounded-full bg-teal-100 shadow-[0_0_20px_5px_rgba(153,246,228,0.36)]" />
      </div>
    </div>
  );
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

function EyeIcon() {
  return (
    <svg aria-hidden="true" className="size-5" fill="none" viewBox="0 0 24 24">
      <path d="M2.5 12s3.5-6 9.5-6 9.5 6 9.5 6-3.5 6-9.5 6-9.5-6-9.5-6Z" stroke="currentColor" strokeWidth="1.8" />
      <circle cx="12" cy="12" r="3" stroke="currentColor" strokeWidth="1.8" />
    </svg>
  );
}

function EyeOffIcon() {
  return (
    <svg aria-hidden="true" className="size-5" fill="none" viewBox="0 0 24 24">
      <path d="m4 4 16 16" stroke="currentColor" strokeLinecap="round" strokeWidth="1.8" />
      <path d="M9.4 5.4A9.9 9.9 0 0 1 12 5c6 0 9.5 7 9.5 7a16.1 16.1 0 0 1-3.1 4" stroke="currentColor" strokeLinecap="round" strokeWidth="1.8" />
      <path d="M14.1 14.4A3 3 0 0 1 9.6 9.9" stroke="currentColor" strokeLinecap="round" strokeWidth="1.8" />
      <path d="M6.5 7.2A16.6 16.6 0 0 0 2.5 12s3.5 7 9.5 7a9.6 9.6 0 0 0 4.1-.9" stroke="currentColor" strokeLinecap="round" strokeWidth="1.8" />
    </svg>
  );
}
