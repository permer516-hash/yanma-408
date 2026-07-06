"use client";

import Link from "next/link";
import { useEffect, useState, useSyncExternalStore } from "react";
import {
  AuthAuditView,
  AuthTokenView,
  StudyNotificationPreference,
  confirmPasswordReset,
  fetchCurrentUser,
  fetchAuthAuditLogs,
  fetchAuthTokens,
  fetchStudyNotificationPreferences,
  getAuth,
  requestPasswordReset,
  revokeAuthToken,
  updateStudyNotificationPreference,
} from "@/app/lib/api";

export default function AccountSecurityPage() {
  const [tokens, setTokens] = useState<AuthTokenView[]>([]);
  const [logs, setLogs] = useState<AuthAuditView[]>([]);
  const [preferences, setPreferences] = useState<StudyNotificationPreference[]>([]);
  const [username, setUsername] = useState("demo");
  const [resetToken, setResetToken] = useState("");
  const [newPassword, setNewPassword] = useState("");
  const [message, setMessage] = useState("");
  const [access, setAccess] = useState<"checking" | "login" | "denied" | "allowed">("checking");
  const hasAuth = useSyncExternalStore(subscribeAuth, getAuthSnapshot, getAuthServerSnapshot);

  useEffect(() => {
    if (!hasAuth) {
      return;
    }
    fetchCurrentUser()
      .then((user) => {
        if (!user.roles.includes("ADMIN")) {
          setAccess("denied");
          return;
        }
        setAccess("allowed");
        void refresh();
      })
      .catch(() => setAccess("login"));
  }, [hasAuth]);

  async function refresh() {
    const [loadedTokens, loadedLogs, loadedPreferences] = await Promise.all([
      fetchAuthTokens(),
      fetchAuthAuditLogs(),
      fetchStudyNotificationPreferences(),
    ]);
    setTokens(loadedTokens);
    setLogs(loadedLogs);
    setPreferences(loadedPreferences);
  }

  async function handleRequestReset() {
    setMessage("");
    const result = await requestPasswordReset(username);
    setResetToken(result.resetToken ?? "");
    setMessage(result.resetToken ? "重置 token 已生成。" : "如果账号存在，重置请求已记录。");
  }

  async function handleConfirmReset() {
    setMessage("");
    await confirmPasswordReset({ token: resetToken, newPassword });
    setNewPassword("");
    setMessage("密码已更新。");
    await refresh();
  }

  async function handleRevoke(id: string) {
    await revokeAuthToken(id);
    await refresh();
  }

  async function handlePreference(channel: string, enabled: boolean, target: string | null) {
    await updateStudyNotificationPreference({ channel, enabled, target });
    await refresh();
  }

  if (hasAuth === null || access === "checking") {
    return (
      <main className="min-h-screen bg-[#f6f8f9] px-5 py-6 text-slate-950">
        <section className="mx-auto max-w-3xl rounded-lg border border-slate-200 bg-white p-6">
          <h1 className="text-xl font-semibold">账号安全</h1>
        </section>
      </main>
    );
  }

  if (hasAuth === false || access === "login") {
    return (
      <main className="min-h-screen bg-[#f6f8f9] px-5 py-6 text-slate-950">
        <section className="mx-auto max-w-3xl rounded-lg border border-slate-200 bg-white p-6">
          <h1 className="text-xl font-semibold">账号安全</h1>
          <Link className="mt-5 inline-flex rounded-md bg-teal-700 px-4 py-2 text-sm font-medium text-white" href="/login">
            去登录
          </Link>
        </section>
      </main>
    );
  }

  if (access === "denied") {
    return (
      <main className="min-h-screen bg-[#f6f8f9] px-5 py-6 text-slate-950">
        <section className="mx-auto max-w-3xl rounded-lg border border-slate-200 bg-white p-6">
          <h1 className="text-xl font-semibold">账号安全</h1>
          <p className="mt-2 text-sm text-slate-500">当前账号没有管理权限。</p>
          <Link className="mt-5 inline-flex rounded-md border border-slate-200 px-4 py-2 text-sm font-medium text-slate-700" href="/">
            返回仪表盘
          </Link>
        </section>
      </main>
    );
  }

  return (
    <main className="app-bg">
      <div className="mx-auto max-w-6xl px-4 py-6 sm:px-6 lg:py-8">
        <header className="app-panel px-5 py-5 sm:px-6 sm:py-6">
          <Link className="text-sm font-medium text-teal-700" href="/">
            返回仪表盘
          </Link>
          <h1 className="mt-3 text-3xl font-semibold">账号安全</h1>
          <p className="mt-2 text-sm text-slate-500">集中管理密码重置、访问凭证、通知渠道和安全审计。</p>
        </header>

        <section className="mt-5 grid gap-5 lg:grid-cols-2">
          <div className="app-panel p-5 sm:p-6">
            <h2 className="app-section-title">密码重置</h2>
            <p className="mt-2 text-sm text-slate-500">
              重置 token 是一次性密码重置凭证，管理员生成后交给对应用户，用户凭 token 和新密码完成密码更新。
            </p>
            <div className="mt-4 grid gap-3">
              <input className="field" onChange={(event) => setUsername(event.target.value)} placeholder="用户名" value={username} />
              <button className="app-button-primary" onClick={handleRequestReset} type="button">
                生成重置 token
              </button>
              <input className="field" onChange={(event) => setResetToken(event.target.value)} placeholder="重置 token" value={resetToken} />
              <input className="field" onChange={(event) => setNewPassword(event.target.value)} placeholder="新密码" type="password" value={newPassword} />
              <button className="app-button-secondary border-teal-700 text-teal-800" onClick={handleConfirmReset} type="button">
                更新密码
              </button>
              {message && <p className="text-sm text-slate-600">{message}</p>}
            </div>
          </div>

          <div className="app-panel p-5 sm:p-6">
            <h2 className="app-section-title">Token 管理</h2>
            <p className="mt-2 text-sm text-slate-500">
              这里展示已生成的重置 token，可查看是否仍然有效，也可以手动将未使用的 token 失效。
            </p>
            <div className="mt-4 space-y-3">
              {tokens.map((token) => (
                <div className="rounded-md border border-slate-200 bg-slate-50/60 p-3" key={token.id}>
                  <p className="truncate text-xs font-medium text-slate-600">{token.id}</p>
                  <p className="mt-1 text-xs text-slate-500">
                    {token.active ? "活跃" : token.revoked ? "已失效" : "已过期"} · {new Date(token.createdAt).toLocaleString()}
                  </p>
                  {token.active && (
                    <button className="mt-2 text-xs font-medium text-red-700" onClick={() => handleRevoke(token.id)} type="button">
                      失效
                    </button>
                  )}
                </div>
              ))}
            </div>
          </div>
        </section>

        <section className="app-panel mt-5 p-5 sm:p-6">
          <h2 className="app-section-title">通知渠道</h2>
          <div className="mt-4 grid gap-3 md:grid-cols-3">
            {preferences.map((preference) => (
              <label className="rounded-md border border-slate-200 bg-slate-50/50 p-4 text-sm" key={preference.channel}>
                <span className="font-medium text-slate-700">{channelLabel(preference.channel)}</span>
                <span className="mt-3 flex items-center gap-2 text-slate-600">
                  <input
                    checked={preference.enabled}
                    onChange={(event) => void handlePreference(preference.channel, event.target.checked, preference.target)}
                    type="checkbox"
                  />
                  启用
                </span>
                <input
                  className="field mt-3"
                  onBlur={(event) => void handlePreference(preference.channel, preference.enabled, event.target.value)}
                  placeholder="地址或订阅标识"
                  defaultValue={preference.target ?? ""}
                />
              </label>
            ))}
          </div>
        </section>

        <section className="app-panel mt-5 overflow-hidden">
          <div className="app-table-header px-5 py-3">审计日志</div>
          <div className="divide-y divide-slate-100 px-5">
            {logs.map((log) => (
              <div className="grid gap-2 py-3 text-sm md:grid-cols-[180px_120px_1fr]" key={log.id}>
                <span className="text-slate-500">{new Date(log.createdAt).toLocaleString()}</span>
                <span className={log.success ? "font-medium text-teal-700" : "font-medium text-red-700"}>{log.eventType}</span>
                <span className="text-slate-600">{log.details ?? ""}</span>
              </div>
            ))}
          </div>
        </section>
      </div>
    </main>
  );
}

function channelLabel(channel: string) {
  return channel === "IN_APP" ? "站内" : channel === "BROWSER" ? "浏览器" : channel === "EMAIL" ? "邮件" : channel;
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
