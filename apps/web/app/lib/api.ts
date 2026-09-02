export const apiBaseUrl = process.env.NEXT_PUBLIC_API_BASE_URL ?? "http://localhost:18082/api";
const authStorageKey = "yanma408_auth";

function apiUrl(path: string): URL {
  const origin = typeof window === "undefined" ? "http://localhost" : window.location.origin;
  return new URL(path, origin);
}

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
  roles: string[];
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

type MaterialAsset = {
  id: string;
};

export type QuestionPage = {
  items: QuestionSummary[];
  page: number;
  size: number;
  total: number;
  totalPages: number;
  totalScore: number;
};

export type QuestionFeedbackStatus = "PENDING" | "RESOLVED" | "IGNORED";
export type QuestionFeedbackIssueType =
  | "ANSWER_INCORRECT"
  | "EXPLANATION_UNCLEAR"
  | "STEM_ERROR"
  | "OPTION_ERROR"
  | "IMAGE_DISPLAY_ERROR"
  | "OTHER";

export type QuestionFeedback = {
  id: string;
  questionId: string;
  questionStem: string;
  subjectCode: string;
  subjectName: string;
  chapterName: string;
  reporterUserId: string;
  reporterDisplayName: string;
  issueType: QuestionFeedbackIssueType;
  description: string;
  status: QuestionFeedbackStatus;
  adminNote: string | null;
  handledByUserId: string | null;
  handledByDisplayName: string | null;
  handledAt: string | null;
  createdAt: string;
  updatedAt: string;
};

export type QuestionFeedbackPage = {
  items: QuestionFeedback[];
  page: number;
  size: number;
  total: number;
  totalPages: number;
};

export type RecruitmentLead = {
  id: string;
  contactName: string;
  wechatContact: string;
  examYear: number;
  targetSchool: string | null;
  studyStage: "NOT_STARTED" | "FIRST_ROUND" | "SECOND_ROUND" | "REVIEWING";
  weakSubjects: string[];
  weeklyHours: number | null;
  currentConcern: string | null;
  status: "NEW";
  createdAt: string;
};

export type RecruitmentLeadPage = {
  items: RecruitmentLead[];
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

export type StudentLearningSummary = {
  id: string;
  username: string;
  displayName: string;
  createdAt: string;
  attemptCount: number;
  correctCount: number;
  accuracyPercent: number;
  mistakeCount: number;
  pendingMistakeCount: number;
  masteredMistakeCount: number;
  examAttemptCount: number;
  latestExamAccuracyPercent: number;
  latestActivityAt: string;
};

export type StudentLearningDetail = {
  summary: StudentLearningSummary;
  dashboard: StudyDashboard;
  recentMistakes: MistakeSummary[];
  practiceAttempts: Array<{
    id: string;
    questionId: string;
    subjectCode: string;
    subjectName: string;
    chapterName: string;
    stem: string;
    submittedAnswer: string;
    correctAnswer: string;
    correct: boolean;
    elapsedSeconds: number;
    submittedAt: string;
  }>;
  examAttempts: Array<{
    id: string;
    examPaperId: string;
    paperTitle: string;
    paperType: string;
    sourceYear: number | null;
    submittedAt: string;
    durationSeconds: number;
    totalScore: number;
    scoredPoints: number;
    correctCount: number;
    questionCount: number;
    accuracyPercent: number;
  }>;
  weakKnowledgePoints: StudyDashboard["weakKnowledgePoints"];
};

export type TeacherClassView = {
  id: string;
  teacherId: string;
  teacherUsername: string;
  teacherDisplayName: string;
  name: string;
  courseName: string;
  description: string | null;
  status: string;
  studentCount: number;
  createdAt: string;
  updatedAt: string;
};

export type TeacherUserView = {
  id: string;
  username: string;
  displayName: string;
};

export type TeacherTaskAssignmentView = {
  id: string;
  classId: string;
  teacherId: string;
  title: string;
  subjectCode: string;
  taskType: string;
  targetCount: number;
  estimatedMinutes: number;
  priority: string;
  taskDate: string;
  recurrenceRule: string;
  reminderTime: string | null;
  assignedCount: number;
  createdAt: string;
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

async function errorMessage(response: Response, fallback: string) {
  const payload = await response.json().catch(() => null);
  const message = typeof payload?.message === "string" ? payload.message : fallback;

  return translateAuthMessage(message);
}

function translateAuthMessage(message: string) {
  const translations: Record<string, string> = {
    "Password must be 8 to 128 characters": "密码长度需要在 8 到 128 位之间",
    "Password must include letters and digits": "密码必须同时包含字母和数字",
    "Username already exists": "用户名已存在，请换一个用户名或直接登录",
    "Invalid username or password": "用户名或密码不正确",
    "Too many failed login attempts. Please try again later.": "登录失败次数过多，请稍后再试",
  };

  return translations[message] ?? message;
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
    throw new Error(await errorMessage(response, "注册失败"));
  }
  return response.json();
}

export async function createTeacher(input: {
  username: string;
  displayName: string;
  password: string;
}): Promise<CurrentUser> {
  const response = await fetch(`${apiBaseUrl}/auth/teachers`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      ...authHeaders(),
    },
    body: JSON.stringify(input),
  });

  if (!response.ok) {
    throw new Error(await errorMessage(response, "创建教师失败"));
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
    throw new Error(await errorMessage(response, "登录失败"));
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
  const url = apiUrl(`${apiBaseUrl}/auth/audit-logs`);
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
  const url = apiUrl(`${apiBaseUrl}/questions`);
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
  source?: string;
  knowledgePoint?: string;
  page?: number;
  size?: number;
}): Promise<QuestionPage> {
  const url = apiUrl(`${apiBaseUrl}/questions/search`);
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

export async function submitQuestionFeedback(input: {
  questionId: string;
  issueType: QuestionFeedbackIssueType;
  description: string;
}): Promise<QuestionFeedback> {
  const response = await fetch(`${apiBaseUrl}/questions/${input.questionId}/feedback`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      ...authHeaders(),
    },
    body: JSON.stringify({
      issueType: input.issueType,
      description: input.description,
    }),
  });
  if (!response.ok) {
    throw new Error(await errorMessage(response, "题目反馈提交失败"));
  }
  return response.json();
}

export async function submitRecruitmentLead(input: {
  contactName: string;
  wechatContact: string;
  examYear: number;
  targetSchool: string;
  studyStage: RecruitmentLead["studyStage"];
  weakSubjects: string[];
  weeklyHours: number | null;
  currentConcern: string;
  consented: boolean;
}): Promise<RecruitmentLead> {
  const response = await fetch(`${apiBaseUrl}/recruitment/leads`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify(input),
  });
  if (!response.ok) {
    throw new Error(await errorMessage(response, "预约信息提交失败"));
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
  const url = apiUrl(`${apiBaseUrl}/mistakes`);
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
  const url = apiUrl(`${apiBaseUrl}/mistakes/review-queue`);
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

export async function fetchTeacherStudents(filters?: { classId?: string; keyword?: string }): Promise<StudentLearningSummary[]> {
  const url = apiUrl(`${apiBaseUrl}/teacher/students`);
  if (filters?.classId) {
    url.searchParams.set("classId", filters.classId);
  }
  if (filters?.keyword?.trim()) {
    url.searchParams.set("keyword", filters.keyword.trim());
  }
  const response = await fetch(url, {
    headers: authHeaders(),
  });
  if (!response.ok) {
    throw new Error("学生学情列表加载失败");
  }
  return response.json();
}

export async function fetchTeacherStudentDetail(studentId: string, classId?: string): Promise<StudentLearningDetail> {
  const url = apiUrl(`${apiBaseUrl}/teacher/students/${studentId}`);
  if (classId) {
    url.searchParams.set("classId", classId);
  }
  const response = await fetch(url, {
    headers: authHeaders(),
  });
  if (!response.ok) {
    throw new Error("学生学情详情加载失败");
  }
  return response.json();
}

export async function fetchTeacherClasses(): Promise<TeacherClassView[]> {
  const response = await fetch(`${apiBaseUrl}/teacher/classes`, {
    headers: authHeaders(),
  });
  if (!response.ok) {
    throw new Error("班级列表加载失败");
  }
  return response.json();
}

export async function fetchTeacherUsers(): Promise<TeacherUserView[]> {
  const response = await fetch(`${apiBaseUrl}/teacher/teachers`, {
    headers: authHeaders(),
  });
  if (!response.ok) {
    throw new Error("教师列表加载失败");
  }
  return response.json();
}

export async function createTeacherClass(input: {
  teacherId?: string;
  name: string;
  courseName: string;
  description?: string | null;
}): Promise<TeacherClassView> {
  const response = await fetch(`${apiBaseUrl}/teacher/classes`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      ...authHeaders(),
    },
    body: JSON.stringify(input),
  });
  if (!response.ok) {
    throw new Error("班级创建失败");
  }
  return response.json();
}

export async function addTeacherClassStudents(classId: string, studentIds: string[]): Promise<TeacherClassView> {
  const response = await fetch(`${apiBaseUrl}/teacher/classes/${classId}/students`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      ...authHeaders(),
    },
    body: JSON.stringify({ studentIds }),
  });
  if (!response.ok) {
    throw new Error("学生加入班级失败");
  }
  return response.json();
}

export async function removeTeacherClassStudent(classId: string, studentId: string): Promise<TeacherClassView> {
  const response = await fetch(`${apiBaseUrl}/teacher/classes/${classId}/students/${studentId}`, {
    method: "DELETE",
    headers: authHeaders(),
  });
  if (!response.ok) {
    throw new Error("学生移出班级失败");
  }
  return response.json();
}

export async function fetchTeacherStudentCandidates(keyword?: string): Promise<StudentLearningSummary[]> {
  const url = apiUrl(`${apiBaseUrl}/teacher/students/candidates`);
  if (keyword?.trim()) {
    url.searchParams.set("keyword", keyword.trim());
  }
  const response = await fetch(url, {
    headers: authHeaders(),
  });
  if (!response.ok) {
    throw new Error("学生候选列表加载失败");
  }
  return response.json();
}

export async function fetchTeacherAssignments(classId: string): Promise<TeacherTaskAssignmentView[]> {
  const response = await fetch(`${apiBaseUrl}/teacher/classes/${classId}/assignments`, {
    headers: authHeaders(),
  });
  if (!response.ok) {
    throw new Error("任务下发记录加载失败");
  }
  return response.json();
}

export async function assignTeacherClassTask(
  classId: string,
  input: {
    title: string;
    subjectCode: string;
    taskType: string;
    targetCount: number;
    estimatedMinutes: number;
    priority: string;
    taskDate: string;
    recurrenceRule?: string;
    reminderTime?: string | null;
  },
): Promise<TeacherTaskAssignmentView> {
  const response = await fetch(`${apiBaseUrl}/teacher/classes/${classId}/assignments`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      ...authHeaders(),
    },
    body: JSON.stringify(input),
  });
  if (!response.ok) {
    throw new Error("班级任务下发失败");
  }
  return response.json();
}

export async function exportTeacherStudentsCsv(filters?: { classId?: string; keyword?: string }): Promise<Blob> {
  const url = apiUrl(`${apiBaseUrl}/teacher/students/export.csv`);
  if (filters?.classId) {
    url.searchParams.set("classId", filters.classId);
  }
  if (filters?.keyword?.trim()) {
    url.searchParams.set("keyword", filters.keyword.trim());
  }
  const response = await fetch(url, {
    headers: authHeaders(),
  });
  if (!response.ok) {
    throw new Error("学生学情导出失败");
  }
  return response.blob();
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
  const url = apiUrl(`${apiBaseUrl}/study/tasks`);
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
  const url = apiUrl(`${apiBaseUrl}/study/tasks/range`);
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
  const url = apiUrl(`${apiBaseUrl}/study/reminders`);
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
  const url = apiUrl(`${apiBaseUrl}/study/notifications`);
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
  const url = apiUrl(`${apiBaseUrl}/exams/attempts`);
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

export async function fetchAdminQuestions(filters?: {
  subject?: string;
  status?: "PUBLISHED" | "DRAFT";
  reviewStatus?: "PENDING" | "APPROVED" | "REJECTED";
  difficulty?: "BASIC" | "MEDIUM" | "HARD";
  source?: "PAST_EXAM" | "MOCK" | "ORIGINAL";
  keyword?: string;
  page?: number;
  size?: number;
}): Promise<QuestionPage> {
  const url = apiUrl(`${apiBaseUrl}/admin/questions`);
  if (filters?.subject) {
    url.searchParams.set("subject", filters.subject);
  }
  if (filters?.status) {
    url.searchParams.set("status", filters.status);
  }
  if (filters?.reviewStatus) {
    url.searchParams.set("reviewStatus", filters.reviewStatus);
  }
  if (filters?.difficulty) {
    url.searchParams.set("difficulty", filters.difficulty);
  }
  if (filters?.source) {
    url.searchParams.set("source", filters.source);
  }
  if (filters?.keyword?.trim()) {
    url.searchParams.set("keyword", filters.keyword.trim());
  }
  if (filters?.page !== undefined) {
    url.searchParams.set("page", String(filters.page));
  }
  if (filters?.size !== undefined) {
    url.searchParams.set("size", String(filters.size));
  }
  const response = await fetch(url, {
    headers: authHeaders(),
  });
  if (!response.ok) {
    throw new Error("管理题库加载失败");
  }
  return response.json();
}

export async function fetchQuestionFeedbacks(filters?: {
  status?: QuestionFeedbackStatus | "";
  issueType?: QuestionFeedbackIssueType | "";
  page?: number;
  size?: number;
}): Promise<QuestionFeedbackPage> {
  const url = apiUrl(`${apiBaseUrl}/admin/question-feedbacks`);
  if (filters?.status) {
    url.searchParams.set("status", filters.status);
  }
  if (filters?.issueType) {
    url.searchParams.set("issueType", filters.issueType);
  }
  if (filters?.page !== undefined) {
    url.searchParams.set("page", String(filters.page));
  }
  if (filters?.size !== undefined) {
    url.searchParams.set("size", String(filters.size));
  }
  const response = await fetch(url, {
    headers: authHeaders(),
  });
  if (!response.ok) {
    throw new Error("题目反馈加载失败");
  }
  return response.json();
}

export async function fetchRecruitmentLeads(filters?: { page?: number; size?: number }): Promise<RecruitmentLeadPage> {
  const url = apiUrl(`${apiBaseUrl}/admin/recruitment/leads`);
  if (filters?.page !== undefined) {
    url.searchParams.set("page", String(filters.page));
  }
  if (filters?.size !== undefined) {
    url.searchParams.set("size", String(filters.size));
  }
  const response = await fetch(url, {
    headers: authHeaders(),
  });
  if (!response.ok) {
    throw new Error("招生线索加载失败");
  }
  return response.json();
}

export async function updateQuestionFeedbackStatus(
  id: string,
  status: QuestionFeedbackStatus,
  adminNote?: string,
): Promise<QuestionFeedback> {
  const response = await fetch(`${apiBaseUrl}/admin/question-feedbacks/${id}/status`, {
    method: "PATCH",
    headers: {
      "Content-Type": "application/json",
      ...authHeaders(),
    },
    body: JSON.stringify({ status, adminNote }),
  });
  if (!response.ok) {
    throw new Error("题目反馈状态更新失败");
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

export async function uploadQuestionStemImage(file: File, subjectCode: string): Promise<string> {
  const formData = new FormData();
  formData.append("title", file.name);
  formData.append("subjectCode", subjectCode);
  formData.append("sourceType", "OTHER");
  formData.append("notes", "题干配图");
  formData.append("file", file);
  const response = await fetch(`${apiBaseUrl}/workbench/materials/upload`, {
    method: "POST",
    headers: authHeaders(),
    body: formData,
  });
  if (!response.ok) {
    throw new Error("题干图片上传失败");
  }
  const asset: MaterialAsset = await response.json();
  return `${apiBaseUrl}/workbench/materials/${asset.id}/image`;
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

export async function updateQuestionDifficulty(
  id: string,
  difficulty: "BASIC" | "MEDIUM" | "HARD",
): Promise<QuestionDetail> {
  const response = await fetch(`${apiBaseUrl}/admin/questions/${id}/difficulty`, {
    method: "PATCH",
    headers: {
      "Content-Type": "application/json",
      ...authHeaders(),
    },
    body: JSON.stringify({ difficulty }),
  });
  if (!response.ok) {
    throw new Error("题目难度更新失败");
  }
  return response.json();
}

export async function updateQuestionSource(
  id: string,
  source: "PAST_EXAM" | "MOCK" | "ORIGINAL",
): Promise<QuestionDetail> {
  const response = await fetch(`${apiBaseUrl}/admin/questions/${id}/source`, {
    method: "PATCH",
    headers: {
      "Content-Type": "application/json",
      ...authHeaders(),
    },
    body: JSON.stringify({ source }),
  });
  if (!response.ok) {
    throw new Error("题目来源更新失败");
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
