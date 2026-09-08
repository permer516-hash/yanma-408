"use client";

import Link from "next/link";
import type { ReactNode } from "react";
import { useEffect, useState, useSyncExternalStore } from "react";
import { ConfirmDialog } from "@/app/components/confirm-dialog";
import {
  AuthAuditView,
  AuthTokenView,
  StudyNotificationPreference,
  UserSecurityView,
  confirmPasswordReset,
  fetchCurrentUser,
  fetchAuthAuditLogs,
  fetchAuthTokens,
  fetchStudyNotificationPreferences,
  fetchSecurityUsers,
  getAuth,
  requestPasswordReset,
  revokeAuthToken,
  updateStudyNotificationPreference,
  updateUserEnabled,
} from "@/app/lib/api";

type SecurityConfirmation =
  | { kind: "revoke-token"; tokenId: string }
  | { kind: "disable-user"; user: UserSecurityView };

export default function AccountSecurityPage() {
  const [tokens, setTokens] = useState<AuthTokenView[]>([]);
  const [logs, setLogs] = useState<AuthAuditView[]>([]);
  const [preferences, setPreferences] = useState<StudyNotificationPreference[]>([]);
  const [users, setUsers] = useState<UserSecurityView[]>([]);
  const [selectedUser, setSelectedUser] = useState<UserSecurityView | null>(null);
  const [username, setUsername] = useState("");
  const [resetToken, setResetToken] = useState("");
  const [newPassword, setNewPassword] = useState("");
  const [message, setMessage] = useState("");
  const [requestingReset, setRequestingReset] = useState(false);
  const [confirmation, setConfirmation] = useState<SecurityConfirmation | null>(null);
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
    const [loadedTokens, loadedLogs, loadedPreferences, loadedUsers] = await Promise.all([
      fetchAuthTokens(),
      fetchAuthAuditLogs(),
      fetchStudyNotificationPreferences(),
      fetchSecurityUsers(),
    ]);
    setTokens(loadedTokens);
    setLogs(loadedLogs);
    setPreferences(loadedPreferences);
    setUsers(loadedUsers);
    setSelectedUser((current) => current ? loadedUsers.find((user) => user.id === current.id) ?? null : null);
  }

  async function handleRequestReset() {
    const normalizedUsername = username.trim();
    if (!normalizedUsername) {
      setMessage("请先填写需要重置密码的用户名。");
      return;
    }

    setMessage("");
    setRequestingReset(true);
    try {
      const result = await requestPasswordReset(normalizedUsername);
      setResetToken(result.resetToken ?? "");
      setMessage(result.resetToken ? "重置 token 已生成。" : "如果账号存在，重置请求已记录。");
    } catch (error) {
      setMessage(error instanceof Error ? error.message : "生成重置 token 失败，请稍后重试。");
    } finally {
      setRequestingReset(false);
    }
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

  async function handleUserEnabled(user: UserSecurityView, enabled: boolean) {
    setMessage("");
    try {
      const updated = await updateUserEnabled(user.id, enabled);
      setUsers((current) => current.map((item) => item.id === updated.id ? updated : item));
      setSelectedUser(updated);
      setMessage(enabled ? `已启用 ${updated.displayName}。` : `已停用 ${updated.displayName}，其现有会话已失效。`);
    } catch (error) {
      setMessage(error instanceof Error ? error.message : "账号状态更新失败");
    }
  }

  function showUserDetail(user: UserSecurityView) {
    setSelectedUser(user);
    setUsername(user.username);
    setMessage("");
  }

  async function handlePreference(channel: string, enabled: boolean, target: string | null) {
    await updateStudyNotificationPreference({ channel, enabled, target });
    await refresh();
  }

  if (hasAuth === null || access === "checking") {
    return <SecurityStatePage />;
  }

  if (hasAuth === false || access === "login") {
    return (
      <SecurityStatePage>
        <Link className="app-button-primary mt-5 inline-flex" href="/login">去登录</Link>
      </SecurityStatePage>
    );
  }

  if (access === "denied") {
    return (
      <SecurityStatePage>
        <p className="mt-2 text-sm text-slate-500">当前账号没有管理权限。</p>
        <Link className="app-button-secondary mt-5 inline-flex" href="/">返回仪表盘</Link>
      </SecurityStatePage>
    );
  }

  return (
    <main className="app-bg">
      <div className="app-container max-w-6xl">
        <header className="app-page-header">
          <Link className="text-sm font-medium text-teal-700" href="/">
            返回仪表盘
          </Link>
          <h1 className="app-page-title">账号安全</h1>
          <p className="app-page-description">集中管理密码重置、访问凭证、通知渠道和安全审计。</p>
        </header>

        <section className="mt-5 grid gap-5 lg:grid-cols-2">
          <div className="app-panel p-5 sm:p-6">
            <h2 className="app-section-title">密码重置</h2>
            <p className="mt-2 text-sm text-slate-500">
              重置 token 是一次性密码重置凭证，管理员生成后交给对应用户，用户凭 token 和新密码完成密码更新。
            </p>
            <div className="mt-4 grid gap-3">
              <input className="field" onChange={(event) => setUsername(event.target.value)} placeholder="用户名" value={username} />
              <button className="app-button-primary" disabled={requestingReset} onClick={handleRequestReset} type="button">
                {requestingReset ? "生成中..." : "生成重置 token"}
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
                    <button className="mt-2 text-xs font-medium text-red-700" onClick={() => setConfirmation({ kind: "revoke-token", tokenId: token.id })} type="button">
                      失效
                    </button>
                  )}
                </div>
              ))}
            </div>
          </div>
        </section>

        <section className="app-panel mt-5 overflow-hidden">
          <div className="flex flex-col gap-3 border-b border-slate-200 px-5 py-4 sm:flex-row sm:items-center sm:justify-between">
            <div>
              <h2 className="app-section-title">注册用户</h2>
              <p className="mt-1 text-sm text-slate-500">当前共 {users.length} 个账号，其中 {users.filter((user) => user.enabled).length} 个启用、{users.filter((user) => !user.enabled).length} 个停用。</p>
            </div>
          </div>
          <div className="divide-y divide-slate-100">
            {users.map((user) => (
              <button
                className="grid w-full gap-2 px-5 py-4 text-left hover:bg-slate-50 md:grid-cols-[minmax(0,1fr)_150px_120px_96px] md:items-center"
                key={user.id}
                onClick={() => showUserDetail(user)}
                type="button"
              >
                <span>
                  <span className="block font-medium text-slate-900">{user.displayName}</span>
                  <span className="mt-1 block text-xs text-slate-500">@{user.username} · 注册于 {new Date(user.createdAt).toLocaleString()}</span>
                </span>
                <span className="text-sm text-slate-600">{user.roles.map(roleLabel).join("、")}</span>
                <span className="text-sm text-slate-600">活跃会话 {user.activeTokenCount}</span>
                <span className={user.enabled ? "text-sm font-medium text-teal-700" : "text-sm font-medium text-red-700"}>{user.enabled ? "已启用" : "已停用"}</span>
              </button>
            ))}
          </div>
        </section>

        {selectedUser && (
          <section className="app-panel mt-5 p-5 sm:p-6">
            <div className="flex flex-col gap-3 sm:flex-row sm:items-start sm:justify-between">
              <div>
                <h2 className="app-section-title">用户详情</h2>
                <p className="mt-1 text-sm text-slate-500">{selectedUser.displayName} · @{selectedUser.username}</p>
              </div>
              <span className={selectedUser.enabled ? "text-sm font-medium text-teal-700" : "text-sm font-medium text-red-700"}>{selectedUser.enabled ? "账号已启用" : "账号已停用"}</span>
            </div>
            <div className="mt-4 grid gap-3 text-sm text-slate-600 sm:grid-cols-3">
              <p>角色：{selectedUser.roles.map(roleLabel).join("、")}</p>
              <p>注册时间：{new Date(selectedUser.createdAt).toLocaleString()}</p>
              <p>活跃会话：{selectedUser.activeTokenCount}</p>
            </div>
            <div className="mt-5 flex flex-wrap gap-3">
              <button
                className={selectedUser.enabled ? "app-button-secondary border-red-200 text-red-700" : "app-button-primary"}
                onClick={() => selectedUser.enabled ? setConfirmation({ kind: "disable-user", user: selectedUser }) : void handleUserEnabled(selectedUser, true)}
                type="button"
              >
                {selectedUser.enabled ? "停用账号" : "启用账号"}
              </button>
              <button className="app-button-secondary" onClick={() => setUsername(selectedUser.username)} type="button">
                使用此账号生成重置 token
              </button>
            </div>
          </section>
        )}

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
          <div className="grid grid-cols-1 gap-x-5 gap-y-1 border-b border-slate-200 bg-slate-50/80 px-5 py-3 text-xs font-semibold uppercase tracking-wide text-slate-500 sm:grid-cols-[minmax(136px,180px)_minmax(160px,0.75fr)_minmax(0,1fr)]">
            <span>时间</span>
            <span>操作</span>
            <span>详情</span>
          </div>
          <div className="divide-y divide-slate-100 px-5">
            {logs.map((log) => (
              <div className="grid grid-cols-1 gap-x-5 gap-y-1 py-3 text-sm sm:grid-cols-[minmax(136px,180px)_minmax(160px,0.75fr)_minmax(0,1fr)]" key={log.id}>
                <span className="text-slate-500">{new Date(log.createdAt).toLocaleString()}</span>
                <span className={`min-w-0 break-words font-medium ${log.success ? "text-teal-700" : "text-red-700"}`}>{log.eventType}</span>
                <span className="min-w-0 break-words text-slate-600">{log.details ?? ""}</span>
              </div>
            ))}
          </div>
        </section>
      </div>
      {confirmation && (
        <ConfirmDialog
          confirmLabel={confirmation.kind === "revoke-token" ? "撤销 token" : "停用账号"}
          description={confirmation.kind === "revoke-token" ? "撤销后该重置 token 将立即失效，不能再次用于修改密码。" : `停用 ${confirmation.user.displayName} 后，该账号的现有会话将立即失效。`}
          onClose={() => setConfirmation(null)}
          onConfirm={() => {
            const action = confirmation;
            setConfirmation(null);
            if (action.kind === "revoke-token") {
              void handleRevoke(action.tokenId);
            } else {
              void handleUserEnabled(action.user, false);
            }
          }}
          open
          title={confirmation.kind === "revoke-token" ? "确认撤销这个 token？" : "确认停用这个账号？"}
        />
      )}
    </main>
  );
}

function channelLabel(channel: string) {
  return channel === "IN_APP" ? "站内" : channel === "BROWSER" ? "浏览器" : channel === "EMAIL" ? "邮件" : channel;
}

function SecurityStatePage({ children }: { children?: ReactNode }) {
  return (
    <main className="app-bg text-slate-950">
      <section className="app-container max-w-3xl">
        <div className="app-page-header">
          <h1 className="app-page-title text-xl sm:text-xl">账号安全</h1>
          {children}
        </div>
      </section>
    </main>
  );
}

function roleLabel(role: string) {
  return role === "ADMIN" ? "管理员" : role === "TEACHER" ? "教师" : role === "STUDENT" ? "学生" : role;
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
