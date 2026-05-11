export const apiBaseUrl = process.env.NEXT_PUBLIC_API_BASE_URL ?? "http://localhost:18082/api";
const authStorageKey = "yanma408_auth";

export type AuthResult = {
  userId: string;
  username: string;
  displayName: string;
  token: string;
  expiresAt: string;
};

export type CurrentUser = {
  id: string;
  username: string;
  displayName: string;
};

export type AuthTokenView = {
  id: string;
  createdAt: string;
  expiresAt: string;
  lastUsedAt: string | null;
  revoked: boolean;
  active: boolean;
};

export type AuthAuditView = {
  id: string;
  userId: string | null;
  username: string | null;
  eventType: string;
  success: boolean;
  ipAddress: string | null;
  userAgent: string | null;
  details: string | null;
  createdAt: string;
};

export type PasswordResetRequestResult = {
  requested: boolean;
  resetToken: string | null;
  expiresAt: string | null;
};

export type QuestionSummary = {
  id: string;
  subjectCode: string;
  subjectName: string;
  chapterName: string;
  type: string;
  difficulty: string;
  stem: string;
  source: string;
  sourceYear: number | null;
  score: number;
  status: string;
  reviewStatus: string;
  reviewNote: string | null;
  stemFormat: string;
  stemImageUrl: string | null;
  tags: string[];
  knowledgePoints: string[];
};

export type QuestionDetail = Omit<QuestionSummary, "knowledgePoints"> & {
  chapterCode: string;
  answer: string;
  explanation: string;
  options: Array<{
    id: string;
    label: string;
    content: string;
  }>;
  knowledgePoints: Array<{
    id: string;
    code: string;
    name: string;
  }>;
};

export type QuestionPage = {
  items: QuestionSummary[];
  page: number;
  size: number;
  total: number;
  totalPages: number;
};

export type SubmitAnswerResult = {
  attemptId: string;
  questionId: string;
  submittedAnswer: string;
  correctAnswer: string;
  correct: boolean;
  enteredMistakeBook: boolean;
  wrongCount: number;
  explanation: string;
  submittedAt: string;
};

export type MistakeSummary = {
  id: string;
  questionId: string;
  subjectCode: string;
  subjectName: string;
  chapterName: string;
  type: string;
  difficulty: string;
  stem: string;
  source: string;
  sourceYear: number | null;
  score: number;
  wrongCount: number;
  mastered: boolean;
  reason: string | null;
  firstWrongAt: string;
  latestWrongAt: string;
  updatedAt: string;
  knowledgePoints: string[];
};

export type StudyDashboard = {
  todayGoal: {
    completedCount: number;
    targetCount: number;
  };
  continuousStudy: {
    days: number;
  };
  weeklyAccuracy: {
    percent: number;
    deltaPercent: number;
    attemptCount: number;
  };
  subjectMasteries: Array<{
    subjectCode: string;
    subjectName: string;
    practicedCount: number;
    correctCount: number;
    masteryPercent: number;
    weakestKnowledgePoint: string;
  }>;
  todayTasks: Array<{
    id: string;
    title: string;
    subjectCode: string;
    taskType: string;
    targetCount: number;
    estimatedMinutes: number;
    status: string;
    priority: string;
    taskDate: string;
    recurrenceRule: string;
    reminderTime: string | null;
  }>;
  weakKnowledgePoints: Array<{
    id: string;
    code: string;
    name: string;
    subjectCode: string;
    subjectName: string;
    chapterName: string;
    mistakeCount: number;
    wrongCount: number;
    pendingMistakeCount: number;
    latestWrongAt: string;
  }>;
};

export type ExamPaperSummary = {
  id: string;
  title: string;
  paperType: string;
  sourceYear: number | null;
  durationMinutes: number;
  totalScore: number;
  questionCount: number;
};

export type ExamPaperDetail = ExamPaperSummary & {
  questions: QuestionDetail[];
};

export type ExamAttemptView = {
  id: string;
  examPaperId: string;
  status: string;
  startedAt: string;
  expiresAt: string;
  paper: ExamPaperDetail;
};

export type ExamAttemptReport = {
  id: string;
  examPaperId: string;
  paperTitle: string;
  status: string;
  startedAt: string;
  submittedAt: string;
  durationSeconds: number;
  totalScore: number;
  scoredPoints: number;
  correctCount: number;
  questionCount: number;
  accuracyPercent: number;
  results: Array<{
    questionId: string;
    sortOrder: number;
    stem: string;
    submittedAnswer: string;
    correctAnswer: string;
    correct: boolean;
    score: number;
    earnedScore: number;
    explanation: string;
  }>;
};

export type ExamAttemptSummary = {
  id: string;
  examPaperId: string;
  paperTitle: string;
  submittedAt: string;
  durationSeconds: number;
  totalScore: number;
  scoredPoints: number;
  correctCount: number;
  questionCount: number;
  accuracyPercent: number;
};

export type ExamAttemptComparison = {
  latest: ExamAttemptSummary;
  previous: ExamAttemptSummary;
  scoreDelta: number;
  accuracyDelta: number;
  questions: Array<{
    questionId: string;
    sortOrder: number;
    stem: string;
    latestCorrect: boolean;
    previousCorrect: boolean;
    latestAnswer: string;
    previousAnswer: string;
    correctAnswer: string;
  }>;
};

export type ExamReportOverview = {
  attemptCount: number;
  averageAccuracyPercent: number;
  bestScore: number;
  latestAccuracyPercent: number;
  totalDurationSeconds: number;
  trend: Array<{
    attemptId: string;
    examPaperId: string;
    paperTitle: string;
    submittedAt: string;
    scoredPoints: number;
    accuracyPercent: number;
  }>;
  weakQuestions: Array<{
    questionId: string;
    stem: string;
    wrongCount: number;
    latestWrongAnswer: string;
    correctAnswer: string;
  }>;
};

export type StudyNotification = {
  id: string;
  taskId: string | null;
  notificationDate: string;
  channel: string;
  title: string;
  content: string;
  read: boolean;
  createdAt: string;
};

export type StudyNotificationPreference = {
  channel: string;
  enabled: boolean;
  target: string | null;
  updatedAt: string;
};

export type ImportValidationResult = {
  totalRows: number;
  validRows: number;
  invalidRows: number;
  errors: Array<{
    rowNumber: number;
    field: string;
    message: string;
  }>;
};

export type StudyTaskInput = {
  title: string;
  subjectCode: string;
  taskType: string;
  targetCount: number;
  estimatedMinutes: number;
  priority: string;
  taskDate?: string;
  recurrenceRule?: string;
  reminderTime?: string | null;
};

export type CreateQuestionInput = {
  subjectCode: string;
  chapterCode: string;
  type: string;
  difficulty: string;
  stem: string;
  answer: string;
  explanation: string;
  source: string;
  sourceYear?: number | null;
  score: number;
  stemFormat?: string;
  stemImageUrl?: string | null;
  options: Array<{
    label: string;
    content: string;
  }>;
  knowledgePointCodes: string[];
  tags?: string[];
};

export function saveAuth(auth: AuthResult) {
  localStorage.setItem(authStorageKey, JSON.stringify(auth));
}

export function getAuth(): AuthResult | null {
  if (typeof window === "undefined") {
    return null;
  }
  const raw = localStorage.getItem(authStorageKey);
  return raw ? (JSON.parse(raw) as AuthResult) : null;
}

export function getAuthToken(): string | null {
  return getAuth()?.token ?? null;
}

export function clearAuth() {
  localStorage.removeItem(authStorageKey);
}

function authHeaders(): HeadersInit {
  const token = getAuthToken();
  return token ? { Authorization: `Bearer ${token}` } : {};
}

export async function register(input: {
  username: string;
  displayName: string;
  password: string;
}): Promise<AuthResult> {
  const response = await fetch(`${apiBaseUrl}/auth/register`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify(input),
  });

  if (!response.ok) {
    throw new Error("注册失败");
  }
  return response.json();
}

export async function login(input: { username: string; password: string }): Promise<AuthResult> {
  const response = await fetch(`${apiBaseUrl}/auth/login`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify(input),
  });

  if (!response.ok) {
    throw new Error("登录失败");
  }
  return response.json();
}

export async function fetchCurrentUser(): Promise<CurrentUser> {
  const response = await fetch(`${apiBaseUrl}/auth/me`, {
    headers: authHeaders(),
  });
  if (!response.ok) {
    throw new Error("当前用户加载失败");
  }
  return response.json();
}

export async function logout(): Promise<void> {
  const response = await fetch(`${apiBaseUrl}/auth/logout`, {
    method: "POST",
    headers: authHeaders(),
  });
  clearAuth();
  if (!response.ok) {
    throw new Error("退出登录失败");
  }
}

export async function requestPasswordReset(username: string): Promise<PasswordResetRequestResult> {
  const response = await fetch(`${apiBaseUrl}/auth/password-reset/request`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ username }),
  });
  if (!response.ok) {
    throw new Error("密码重置请求失败");
  }
  return response.json();
}

export async function confirmPasswordReset(input: { token: string; newPassword: string }): Promise<void> {
  const response = await fetch(`${apiBaseUrl}/auth/password-reset/confirm`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(input),
  });
  if (!response.ok) {
    throw new Error("密码重置失败");
  }
}

export async function fetchAuthTokens(): Promise<AuthTokenView[]> {
  const response = await fetch(`${apiBaseUrl}/auth/tokens`, {
    headers: authHeaders(),
  });
  if (!response.ok) {
    throw new Error("Token 列表加载失败");
  }
  return response.json();
}

export async function revokeAuthToken(id: string): Promise<void> {
  const response = await fetch(`${apiBaseUrl}/auth/tokens/${id}/revoke`, {
    method: "PATCH",
    headers: authHeaders(),
  });
  if (!response.ok) {
    throw new Error("Token 失效失败");
  }
}

export async function fetchAuthAuditLogs(limit = 30): Promise<AuthAuditView[]> {
  const url = new URL(`${apiBaseUrl}/auth/audit-logs`);
  url.searchParams.set("limit", String(limit));
  const response = await fetch(url, {
    headers: authHeaders(),
  });
  if (!response.ok) {
    throw new Error("账号审计日志加载失败");
  }
  return response.json();
}

export async function fetchQuestions(subject?: string): Promise<QuestionSummary[]> {
  const url = new URL(`${apiBaseUrl}/questions`);
  if (subject) {
    url.searchParams.set("subject", subject);
  }

  const response = await fetch(url);
  if (!response.ok) {
    throw new Error("题目列表加载失败");
  }
  return response.json();
}

export async function searchQuestions(filters: {
  subject?: string;
  keyword?: string;
  difficulty?: string;
  knowledgePoint?: string;
  page?: number;
  size?: number;
}): Promise<QuestionPage> {
  const url = new URL(`${apiBaseUrl}/questions/search`);
  Object.entries(filters).forEach(([key, value]) => {
    if (value !== undefined && value !== "") {
      url.searchParams.set(key, String(value));
    }
  });
  const response = await fetch(url);
  if (!response.ok) {
    throw new Error("题目搜索失败");
  }
  return response.json();
}

export async function fetchQuestionDetail(id: string): Promise<QuestionDetail> {
  const response = await fetch(`${apiBaseUrl}/questions/${id}`);
  if (!response.ok) {
    throw new Error("题目详情加载失败");
  }
  return response.json();
}

export async function submitAnswer(input: {
  questionId: string;
  submittedAnswer: string;
  elapsedSeconds: number;
}): Promise<SubmitAnswerResult> {
  const response = await fetch(`${apiBaseUrl}/practice/attempts`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      ...authHeaders(),
    },
    body: JSON.stringify(input),
  });

  if (!response.ok) {
    throw new Error("答案提交失败");
  }
  return response.json();
}

export async function fetchMistakes(filters?: { subject?: string; mastered?: boolean }): Promise<MistakeSummary[]> {
  const url = new URL(`${apiBaseUrl}/mistakes`);
  if (filters?.subject) {
    url.searchParams.set("subject", filters.subject);
  }
  if (filters?.mastered !== undefined) {
    url.searchParams.set("mastered", String(filters.mastered));
  }

  const response = await fetch(url, {
    headers: authHeaders(),
  });
  if (!response.ok) {
    throw new Error("错题本加载失败");
  }
  return response.json();
}

export async function fetchMistakeReviewQueue(subject?: string): Promise<MistakeSummary[]> {
  const url = new URL(`${apiBaseUrl}/mistakes/review-queue`);
  if (subject) {
    url.searchParams.set("subject", subject);
  }
  const response = await fetch(url, {
    headers: authHeaders(),
  });
  if (!response.ok) {
    throw new Error("错题复习队列加载失败");
  }
  return response.json();
}

export async function updateMistakeMastery(id: string, mastered: boolean): Promise<void> {
  const response = await fetch(`${apiBaseUrl}/mistakes/${id}/mastery`, {
    method: "PATCH",
    headers: {
      "Content-Type": "application/json",
      ...authHeaders(),
    },
    body: JSON.stringify({ mastered }),
  });

  if (!response.ok) {
    throw new Error("掌握状态更新失败");
  }
}

export async function fetchStudyDashboard(): Promise<StudyDashboard> {
  const response = await fetch(`${apiBaseUrl}/study/dashboard`, {
    headers: authHeaders(),
  });
  if (!response.ok) {
    throw new Error("学习分析加载失败");
  }
  return response.json();
}

export async function updateStudyTaskStatus(id: string, status: "PENDING" | "DONE"): Promise<void> {
  const response = await fetch(`${apiBaseUrl}/study/tasks/${id}/status`, {
    method: "PATCH",
    headers: {
      "Content-Type": "application/json",
      ...authHeaders(),
    },
    body: JSON.stringify({ status }),
  });

  if (!response.ok) {
    throw new Error("学习任务状态更新失败");
  }
}

export async function updateStudyTaskOccurrenceStatus(
  id: string,
  date: string,
  status: "PENDING" | "DONE" | "SKIPPED",
): Promise<void> {
  const response = await fetch(`${apiBaseUrl}/study/tasks/${id}/occurrences/${date}/status`, {
    method: "PATCH",
    headers: {
      "Content-Type": "application/json",
      ...authHeaders(),
    },
    body: JSON.stringify({ status }),
  });

  if (!response.ok) {
    throw new Error("学习任务实例状态更新失败");
  }
}

export async function fetchStudyTasks(date?: string): Promise<StudyDashboard["todayTasks"]> {
  const url = new URL(`${apiBaseUrl}/study/tasks`);
  if (date) {
    url.searchParams.set("date", date);
  }
  const response = await fetch(url, {
    headers: authHeaders(),
  });
  if (!response.ok) {
    throw new Error("学习任务加载失败");
  }
  return response.json();
}

export async function fetchStudyTaskRange(start: string, end: string): Promise<StudyDashboard["todayTasks"]> {
  const url = new URL(`${apiBaseUrl}/study/tasks/range`);
  url.searchParams.set("start", start);
  url.searchParams.set("end", end);
  const response = await fetch(url, {
    headers: authHeaders(),
  });
  if (!response.ok) {
    throw new Error("学习任务视图加载失败");
  }
  return response.json();
}

export async function fetchStudyReminders(date?: string): Promise<StudyDashboard["todayTasks"]> {
  const url = new URL(`${apiBaseUrl}/study/reminders`);
  if (date) {
    url.searchParams.set("date", date);
  }
  const response = await fetch(url, {
    headers: authHeaders(),
  });
  if (!response.ok) {
    throw new Error("学习提醒加载失败");
  }
  return response.json();
}

export async function dispatchStudyNotifications(): Promise<{ createdCount: number }> {
  const response = await fetch(`${apiBaseUrl}/study/notifications/dispatch`, {
    method: "POST",
    headers: authHeaders(),
  });
  if (!response.ok) {
    throw new Error("学习通知调度失败");
  }
  return response.json();
}

export async function fetchStudyNotifications(unreadOnly = false): Promise<StudyNotification[]> {
  const url = new URL(`${apiBaseUrl}/study/notifications`);
  url.searchParams.set("unreadOnly", String(unreadOnly));
  const response = await fetch(url, {
    headers: authHeaders(),
  });
  if (!response.ok) {
    throw new Error("学习通知加载失败");
  }
  return response.json();
}

export async function markStudyNotificationRead(id: string): Promise<void> {
  const response = await fetch(`${apiBaseUrl}/study/notifications/${id}/read`, {
    method: "PATCH",
    headers: authHeaders(),
  });
  if (!response.ok) {
    throw new Error("学习通知已读失败");
  }
}

export async function fetchStudyNotificationPreferences(): Promise<StudyNotificationPreference[]> {
  const response = await fetch(`${apiBaseUrl}/study/notifications/preferences`, {
    headers: authHeaders(),
  });
  if (!response.ok) {
    throw new Error("通知渠道配置加载失败");
  }
  return response.json();
}

export async function updateStudyNotificationPreference(input: {
  channel: string;
  enabled: boolean;
  target?: string | null;
}): Promise<void> {
  const response = await fetch(`${apiBaseUrl}/study/notifications/preferences/${input.channel}`, {
    method: "PUT",
    headers: {
      "Content-Type": "application/json",
      ...authHeaders(),
    },
    body: JSON.stringify({ enabled: input.enabled, target: input.target ?? null }),
  });
  if (!response.ok) {
    throw new Error("通知渠道配置更新失败");
  }
}

export async function createStudyTask(input: StudyTaskInput): Promise<StudyDashboard["todayTasks"][number]> {
  const response = await fetch(`${apiBaseUrl}/study/tasks`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      ...authHeaders(),
    },
    body: JSON.stringify(input),
  });

  if (!response.ok) {
    throw new Error("学习任务创建失败");
  }
  return response.json();
}

export async function updateStudyTask(
  id: string,
  input: StudyTaskInput,
): Promise<StudyDashboard["todayTasks"][number]> {
  const response = await fetch(`${apiBaseUrl}/study/tasks/${id}`, {
    method: "PUT",
    headers: {
      "Content-Type": "application/json",
      ...authHeaders(),
    },
    body: JSON.stringify(input),
  });

  if (!response.ok) {
    throw new Error("学习任务更新失败");
  }
  return response.json();
}

export async function deleteStudyTask(id: string): Promise<void> {
  const response = await fetch(`${apiBaseUrl}/study/tasks/${id}`, {
    method: "DELETE",
    headers: authHeaders(),
  });

  if (!response.ok) {
    throw new Error("学习任务删除失败");
  }
}

export async function fetchExamPapers(): Promise<ExamPaperSummary[]> {
  const response = await fetch(`${apiBaseUrl}/exams`);
  if (!response.ok) {
    throw new Error("套卷列表加载失败");
  }
  return response.json();
}

export async function fetchExamPaperDetail(id: string): Promise<ExamPaperDetail> {
  const response = await fetch(`${apiBaseUrl}/exams/${id}`);
  if (!response.ok) {
    throw new Error("套卷详情加载失败");
  }
  return response.json();
}

export async function startExamAttempt(examPaperId: string): Promise<ExamAttemptView> {
  const response = await fetch(`${apiBaseUrl}/exams/${examPaperId}/attempts`, {
    method: "POST",
    headers: authHeaders(),
  });
  if (!response.ok) {
    throw new Error("套卷作答创建失败");
  }
  return response.json();
}

export async function submitExamAttempt(
  attemptId: string,
  input: { answers: Record<string, string>; durationSeconds: number },
): Promise<ExamAttemptReport> {
  const response = await fetch(`${apiBaseUrl}/exams/attempts/${attemptId}/submit`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      ...authHeaders(),
    },
    body: JSON.stringify(input),
  });
  if (!response.ok) {
    throw new Error("套卷交卷失败");
  }
  return response.json();
}

export async function fetchExamAttemptReport(attemptId: string): Promise<ExamAttemptReport> {
  const response = await fetch(`${apiBaseUrl}/exams/attempts/${attemptId}/report`, {
    headers: authHeaders(),
  });
  if (!response.ok) {
    throw new Error("套卷报告加载失败");
  }
  return response.json();
}

export async function fetchExamAttemptHistory(paperId?: string): Promise<ExamAttemptSummary[]> {
  const url = new URL(`${apiBaseUrl}/exams/attempts`);
  if (paperId) {
    url.searchParams.set("paperId", paperId);
  }
  const response = await fetch(url, {
    headers: authHeaders(),
  });
  if (!response.ok) {
    throw new Error("套卷历史加载失败");
  }
  return response.json();
}

export async function fetchExamAttemptComparison(paperId: string): Promise<ExamAttemptComparison> {
  const response = await fetch(`${apiBaseUrl}/exams/${paperId}/attempts/compare`, {
    headers: authHeaders(),
  });
  if (!response.ok) {
    throw new Error("套卷对比加载失败");
  }
  return response.json();
}

export async function fetchExamReportOverview(): Promise<ExamReportOverview> {
  const response = await fetch(`${apiBaseUrl}/exams/reports/overview`, {
    headers: authHeaders(),
  });
  if (!response.ok) {
    throw new Error("套卷报告总览加载失败");
  }
  return response.json();
}

export async function backfillExamAttemptMistakes(attemptId: string): Promise<{ createdCount: number }> {
  const response = await fetch(`${apiBaseUrl}/exams/attempts/${attemptId}/mistakes/backfill`, {
    method: "POST",
    headers: authHeaders(),
  });
  if (!response.ok) {
    throw new Error("套卷错题回灌失败");
  }
  return response.json();
}

export async function fetchAdminQuestions(subject?: string): Promise<QuestionSummary[]> {
  const url = new URL(`${apiBaseUrl}/admin/questions`);
  if (subject) {
    url.searchParams.set("subject", subject);
  }
  const response = await fetch(url, {
    headers: authHeaders(),
  });
  if (!response.ok) {
    throw new Error("管理题库加载失败");
  }
  return response.json();
}

export async function fetchAdminQuestionDetail(id: string): Promise<QuestionDetail> {
  const response = await fetch(`${apiBaseUrl}/admin/questions/${id}`, {
    headers: authHeaders(),
  });
  if (!response.ok) {
    throw new Error("管理题目详情加载失败");
  }
  return response.json();
}

export async function createQuestion(input: CreateQuestionInput): Promise<QuestionDetail> {
  const response = await fetch(`${apiBaseUrl}/questions`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      ...authHeaders(),
    },
    body: JSON.stringify(input),
  });
  if (!response.ok) {
    throw new Error("题目创建失败");
  }
  return response.json();
}

export async function updateQuestion(id: string, input: CreateQuestionInput): Promise<QuestionDetail> {
  const response = await fetch(`${apiBaseUrl}/admin/questions/${id}`, {
    method: "PUT",
    headers: {
      "Content-Type": "application/json",
      ...authHeaders(),
    },
    body: JSON.stringify(input),
  });
  if (!response.ok) {
    throw new Error("题目更新失败");
  }
  return response.json();
}

export async function updateQuestionStatus(id: string, status: "PUBLISHED" | "DRAFT"): Promise<QuestionDetail> {
  const response = await fetch(`${apiBaseUrl}/admin/questions/${id}/status`, {
    method: "PATCH",
    headers: {
      "Content-Type": "application/json",
      ...authHeaders(),
    },
    body: JSON.stringify({ status }),
  });
  if (!response.ok) {
    throw new Error("题目状态更新失败");
  }
  return response.json();
}

export async function updateQuestionReviewStatus(
  id: string,
  reviewStatus: "PENDING" | "APPROVED" | "REJECTED",
  reviewNote?: string,
): Promise<QuestionDetail> {
  const response = await fetch(`${apiBaseUrl}/admin/questions/${id}/review`, {
    method: "PATCH",
    headers: {
      "Content-Type": "application/json",
      ...authHeaders(),
    },
    body: JSON.stringify({ reviewStatus, reviewNote }),
  });
  if (!response.ok) {
    throw new Error("题目审核状态更新失败");
  }
  return response.json();
}

export async function bulkUpdateQuestions(input: {
  questionIds: string[];
  status?: "PUBLISHED" | "DRAFT";
  reviewStatus?: "PENDING" | "APPROVED" | "REJECTED";
  tags?: string[];
}): Promise<void> {
  const response = await fetch(`${apiBaseUrl}/admin/questions/bulk`, {
    method: "PATCH",
    headers: {
      "Content-Type": "application/json",
      ...authHeaders(),
    },
    body: JSON.stringify(input),
  });
  if (!response.ok) {
    throw new Error("题目批量更新失败");
  }
}

export async function deleteQuestion(id: string): Promise<void> {
  const response = await fetch(`${apiBaseUrl}/admin/questions/${id}`, {
    method: "DELETE",
    headers: authHeaders(),
  });
  if (!response.ok) {
    throw new Error("题目删除失败");
  }
}

export async function importQuestions(questions: CreateQuestionInput[]): Promise<QuestionDetail[]> {
  const response = await fetch(`${apiBaseUrl}/admin/questions/import`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      ...authHeaders(),
    },
    body: JSON.stringify({ questions }),
  });
  if (!response.ok) {
    throw new Error("题目批量导入失败");
  }
  return response.json();
}

export async function previewQuestionImport(questions: CreateQuestionInput[]): Promise<ImportValidationResult> {
  const response = await fetch(`${apiBaseUrl}/admin/questions/import/preview`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      ...authHeaders(),
    },
    body: JSON.stringify({ questions }),
  });
  if (!response.ok) {
    throw new Error("题目导入预校验失败");
  }
  return response.json();
}

export async function importQuestionFile(file: File): Promise<QuestionDetail[]> {
  const formData = new FormData();
  formData.append("file", file);
  const response = await fetch(`${apiBaseUrl}/admin/questions/import/file`, {
    method: "POST",
    headers: authHeaders(),
    body: formData,
  });
  if (!response.ok) {
    throw new Error("题目文件导入失败");
  }
  return response.json();
}

export async function previewQuestionImportFile(file: File): Promise<ImportValidationResult> {
  const formData = new FormData();
  formData.append("file", file);
  const response = await fetch(`${apiBaseUrl}/admin/questions/import/preview-file`, {
    method: "POST",
    headers: authHeaders(),
    body: formData,
  });
  if (!response.ok) {
    throw new Error("题目文件预校验失败");
  }
  return response.json();
}
