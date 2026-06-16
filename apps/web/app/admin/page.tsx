"use client";

import Link from "next/link";
import type { ChangeEvent, FormEvent } from "react";
import { Suspense, useCallback, useEffect, useRef, useState } from "react";
import { usePathname, useRouter, useSearchParams } from "next/navigation";
import {
  CreateQuestionInput,
  ImportValidationResult,
  bulkUpdateQuestions,
  createQuestion,
  deleteQuestion,
  fetchAdminQuestionDetail,
  fetchAdminQuestions,
  fetchCurrentUser,
  fetchQuestionFeedbacks,
  getAuth,
  importQuestionFile,
  importQuestions,
  previewQuestionImportFile,
  previewQuestionImport,
  QuestionFeedback,
  QuestionFeedbackIssueType,
  QuestionFeedbackPage,
  QuestionFeedbackStatus,
  QuestionDetail,
  QuestionPage,
  QuestionSummary,
  updateQuestion,
  updateQuestionFeedbackStatus,
  updateQuestionDifficulty,
  updateQuestionReviewStatus,
  updateQuestionSource,
  updateQuestionStatus,
  uploadQuestionStemImage,
} from "@/app/lib/api";
import { QuestionStemMedia, QuestionStemThumbnail } from "@/app/components/question-stem-media";
import { difficultyLabels, sourceLabels, subjectLabels, typeLabels } from "@/app/lib/question-labels";
import { formatQuestionText } from "@/app/lib/text-format";

const subjects = [
  { label: "数据结构", value: "DATA_STRUCTURE", chapterCode: "DS_TREE", knowledgePointCode: "DS_TREE_TRAVERSAL" },
  { label: "计算机组成与原理", value: "COMPUTER_ORGANIZATION", chapterCode: "CO_CACHE", knowledgePointCode: "CO_CACHE_MAPPING" },
  { label: "操作系统", value: "OPERATING_SYSTEM", chapterCode: "OS_PROCESS", knowledgePointCode: "OS_SCHEDULING" },
  { label: "计算机网络", value: "COMPUTER_NETWORK", chapterCode: "CN_TRANSPORT", knowledgePointCode: "CN_TCP_CONGESTION" },
];

type ShelfStatusFilter = "" | "PUBLISHED" | "DRAFT";
type ReviewStatusFilter = "" | "PENDING" | "APPROVED" | "REJECTED";
type DifficultyValue = "BASIC" | "MEDIUM" | "HARD";
type SourceValue = "PAST_EXAM" | "MOCK" | "ORIGINAL";
type DifficultyFilter = "" | DifficultyValue;
type SourceFilter = "" | SourceValue;
type FeedbackStatusFilter = "" | QuestionFeedbackStatus;
type FeedbackIssueTypeFilter = "" | QuestionFeedbackIssueType;

const DEFAULT_ADMIN_PAGE_SIZE = 30;
const adminPageSizes = [20, 30, 50, 100];

function parsePageParam(value: string | null) {
  const page = Number(value ?? 0);
  return Number.isFinite(page) && page > 0 ? Math.floor(page) : 0;
}

function parsePageSizeParam(value: string | null) {
  const size = Number(value ?? DEFAULT_ADMIN_PAGE_SIZE);
  if (!Number.isFinite(size)) {
    return DEFAULT_ADMIN_PAGE_SIZE;
  }
  return adminPageSizes.includes(size) ? size : DEFAULT_ADMIN_PAGE_SIZE;
}

const initialForm = {
  subjectCode: "DATA_STRUCTURE",
  type: "SINGLE_CHOICE",
  difficulty: "BASIC",
  source: "ORIGINAL",
  sourceYear: "",
  stem: "",
  answer: "A",
  explanation: "",
  score: 2,
  stemFormat: "PLAIN_TEXT",
  stemImageUrl: "",
  tags: "",
  optionA: "",
  optionB: "",
  optionC: "",
  optionD: "",
};

export default function AdminPage() {
  return (
    <Suspense fallback={<main className="min-h-screen bg-[#f6f8f9] px-5 py-10 text-sm text-slate-500">正在加载管理后台...</main>}>
      <AdminPageContent />
    </Suspense>
  );
}

function AdminPageContent() {
  const router = useRouter();
  const pathname = usePathname();
  const searchParams = useSearchParams();
  const [access, setAccess] = useState<"checking" | "login" | "denied" | "allowed">("checking");
  const [questions, setQuestions] = useState<QuestionSummary[]>([]);
  const [questionPage, setQuestionPage] = useState<QuestionPage | null>(null);
  const [subjectFilter, setSubjectFilter] = useState(searchParams.get("subject") ?? "");
  const [shelfStatusFilter, setShelfStatusFilter] = useState<ShelfStatusFilter>((searchParams.get("status") as ShelfStatusFilter) ?? "");
  const [reviewStatusFilter, setReviewStatusFilter] = useState<ReviewStatusFilter>((searchParams.get("reviewStatus") as ReviewStatusFilter) ?? "");
  const [difficultyFilter, setDifficultyFilter] = useState<DifficultyFilter>((searchParams.get("difficulty") as DifficultyFilter) ?? "");
  const [sourceFilter, setSourceFilter] = useState<SourceFilter>((searchParams.get("source") as SourceFilter) ?? "");
  const [keywordFilter, setKeywordFilter] = useState(searchParams.get("keyword") ?? "");
  const [keywordInput, setKeywordInput] = useState(searchParams.get("keyword") ?? "");
  const [pageIndex, setPageIndex] = useState(parsePageParam(searchParams.get("page")));
  const [pageSize, setPageSize] = useState(parsePageSizeParam(searchParams.get("size")));
  const [status, setStatus] = useState<"loading" | "success" | "error">("loading");
  const [form, setForm] = useState(initialForm);
  const [editingQuestionId, setEditingQuestionId] = useState<string | null>(null);
  const [submitting, setSubmitting] = useState(false);
  const [uploadingStemImage, setUploadingStemImage] = useState(false);
  const [stemImageFileName, setStemImageFileName] = useState("");
  const [updatingQuestionId, setUpdatingQuestionId] = useState<string | null>(null);
  const [selectedQuestionIds, setSelectedQuestionIds] = useState<string[]>([]);
  const [bulkTags, setBulkTags] = useState("");
  const [reviewNote, setReviewNote] = useState("");
  const [importText, setImportText] = useState("");
  const [importFile, setImportFile] = useState<File | null>(null);
  const [importPreview, setImportPreview] = useState<ImportValidationResult | null>(null);
  const [message, setMessage] = useState("");
  const latestQuestionRequest = useRef(0);
  const latestDetailRequest = useRef(0);
  const latestFeedbackRequest = useRef(0);
  const [viewingQuestionId, setViewingQuestionId] = useState<string | null>(null);
  const [questionDetail, setQuestionDetail] = useState<QuestionDetail | null>(null);
  const [detailStatus, setDetailStatus] = useState<"idle" | "loading" | "success" | "error">("idle");
  const [feedbacks, setFeedbacks] = useState<QuestionFeedback[]>([]);
  const [feedbackPage, setFeedbackPage] = useState<QuestionFeedbackPage | null>(null);
  const [feedbackStatus, setFeedbackStatus] = useState<"loading" | "success" | "error">("loading");
  const [feedbackStatusFilter, setFeedbackStatusFilter] = useState<FeedbackStatusFilter>("PENDING");
  const [feedbackIssueTypeFilter, setFeedbackIssueTypeFilter] = useState<FeedbackIssueTypeFilter>("");
  const [feedbackUpdatingId, setFeedbackUpdatingId] = useState<string | null>(null);
  const [feedbackAdminNotes, setFeedbackAdminNotes] = useState<Record<string, string>>({});

  const refreshQuestions = useCallback(async () => {
    const requestId = latestQuestionRequest.current + 1;
    latestQuestionRequest.current = requestId;
    setStatus("loading");
    try {
      const result = await fetchAdminQuestions({
        subject: subjectFilter || undefined,
        status: shelfStatusFilter || undefined,
        reviewStatus: reviewStatusFilter || undefined,
        difficulty: difficultyFilter || undefined,
        source: sourceFilter || undefined,
        keyword: keywordFilter || undefined,
        page: pageIndex,
        size: pageSize,
      });
      if (latestQuestionRequest.current === requestId) {
        setQuestionPage(result);
        setQuestions(result.items);
        setSelectedQuestionIds((current) => current.filter((id) => result.items.some((question) => question.id === id)));
        setStatus("success");
      }
    } catch {
      if (latestQuestionRequest.current === requestId) {
        setStatus("error");
      }
    }
  }, [difficultyFilter, keywordFilter, pageIndex, pageSize, reviewStatusFilter, shelfStatusFilter, sourceFilter, subjectFilter]);

  const refreshFeedbacks = useCallback(async () => {
    const requestId = latestFeedbackRequest.current + 1;
    latestFeedbackRequest.current = requestId;
    setFeedbackStatus("loading");
    try {
      const result = await fetchQuestionFeedbacks({
        status: feedbackStatusFilter,
        issueType: feedbackIssueTypeFilter,
        page: 0,
        size: 20,
      });
      if (latestFeedbackRequest.current === requestId) {
        setFeedbackPage(result);
        setFeedbacks(result.items);
        setFeedbackAdminNotes((current) => {
          const next = { ...current };
          result.items.forEach((feedback) => {
            if (next[feedback.id] === undefined) {
              next[feedback.id] = feedback.adminNote ?? "";
            }
          });
          return next;
        });
        setFeedbackStatus("success");
      }
    } catch {
      if (latestFeedbackRequest.current === requestId) {
        setFeedbackStatus("error");
      }
    }
  }, [feedbackIssueTypeFilter, feedbackStatusFilter]);

  function updateFilters(input: {
    subject?: string;
    status?: ShelfStatusFilter;
    reviewStatus?: ReviewStatusFilter;
    difficulty?: DifficultyFilter;
    source?: SourceFilter;
  }) {
    const subject = input.subject ?? subjectFilter;
    const nextStatus = input.status ?? shelfStatusFilter;
    const nextReviewStatus = input.reviewStatus ?? reviewStatusFilter;
    const nextDifficulty = input.difficulty ?? difficultyFilter;
    const nextSource = input.source ?? sourceFilter;
    const next = new URLSearchParams(searchParams.toString());
    if (subject) {
      next.set("subject", subject);
    } else {
      next.delete("subject");
    }
    if (nextStatus) {
      next.set("status", nextStatus);
    } else {
      next.delete("status");
    }
    if (nextReviewStatus) {
      next.set("reviewStatus", nextReviewStatus);
    } else {
      next.delete("reviewStatus");
    }
    if (nextDifficulty) {
      next.set("difficulty", nextDifficulty);
    } else {
      next.delete("difficulty");
    }
    if (nextSource) {
      next.set("source", nextSource);
    } else {
      next.delete("source");
    }
    next.delete("page");
    setSubjectFilter(subject);
    setShelfStatusFilter(nextStatus);
    setReviewStatusFilter(nextReviewStatus);
    setDifficultyFilter(nextDifficulty);
    setSourceFilter(nextSource);
    setPageIndex(0);
    const query = next.toString();
    router.replace(query ? `${pathname}?${query}` : pathname, { scroll: false });
  }

  function updatePage(nextPage: number) {
    const boundedPage = Math.max(0, nextPage);
    const next = new URLSearchParams(searchParams.toString());
    if (boundedPage > 0) {
      next.set("page", String(boundedPage));
    } else {
      next.delete("page");
    }
    setPageIndex(boundedPage);
    const query = next.toString();
    router.replace(query ? `${pathname}?${query}` : pathname, { scroll: false });
  }

  function updatePageSize(nextSize: number) {
    const size = parsePageSizeParam(String(nextSize));
    const next = new URLSearchParams(searchParams.toString());
    if (size === DEFAULT_ADMIN_PAGE_SIZE) {
      next.delete("size");
    } else {
      next.set("size", String(size));
    }
    next.delete("page");
    setPageSize(size);
    setPageIndex(0);
    const query = next.toString();
    router.replace(query ? `${pathname}?${query}` : pathname, { scroll: false });
  }

  useEffect(() => {
    const keyword = keywordInput.trim();
    if (keyword === keywordFilter) {
      return;
    }
    const timeoutId = window.setTimeout(() => {
      const next = new URLSearchParams(searchParams.toString());
      if (keyword) {
        next.set("keyword", keyword);
      } else {
        next.delete("keyword");
      }
      next.delete("page");
      setKeywordFilter(keyword);
      setPageIndex(0);
      const query = next.toString();
      router.replace(query ? `${pathname}?${query}` : pathname, { scroll: false });
    }, 400);
    return () => window.clearTimeout(timeoutId);
  }, [keywordFilter, keywordInput, pathname, router, searchParams]);

  useEffect(() => {
    let cancelled = false;
    Promise.resolve().then(() => {
      if (!cancelled) {
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
      }
    });
    return () => {
      cancelled = true;
    };
  }, []);

  useEffect(() => {
    if (access !== "allowed") {
      return;
    }
    let cancelled = false;
    Promise.resolve().then(() => {
      if (!cancelled) {
        void refreshQuestions();
      }
    });
    return () => {
      cancelled = true;
    };
  }, [access, refreshQuestions]);

  useEffect(() => {
    if (access !== "allowed") {
      return;
    }
    let cancelled = false;
    Promise.resolve().then(() => {
      if (!cancelled) {
        void refreshFeedbacks();
      }
    });
    return () => {
      cancelled = true;
    };
  }, [access, refreshFeedbacks]);

  async function handleSubmitQuestion(event: FormEvent<HTMLFormElement>) {
    event.preventDefault();
    setSubmitting(true);
    setMessage("");
    try {
      const input = toQuestionInput();
      if (editingQuestionId) {
        await updateQuestion(editingQuestionId, input);
        setMessage("题目已更新。");
      } else {
        await createQuestion(input);
        setMessage("题目已创建。");
      }
      resetForm();
      await refreshQuestions();
    } catch {
      setMessage("保存失败，请检查题干、选项、答案和解析。");
    } finally {
      setSubmitting(false);
    }
  }

  async function handleEditQuestion(questionId: string) {
    setUpdatingQuestionId(questionId);
    setMessage("");
    try {
      const detail = await fetchAdminQuestionDetail(questionId);
      setEditingQuestionId(questionId);
      setForm({
        subjectCode: detail.subjectCode,
        type: detail.type,
        difficulty: detail.difficulty,
        source: detail.source,
        sourceYear: detail.sourceYear ? String(detail.sourceYear) : "",
        stem: detail.stem,
        answer: detail.answer,
        explanation: detail.explanation,
        score: detail.score,
        optionA: detail.options.find((option) => option.label === "A")?.content ?? "",
        optionB: detail.options.find((option) => option.label === "B")?.content ?? "",
        optionC: detail.options.find((option) => option.label === "C")?.content ?? "",
        optionD: detail.options.find((option) => option.label === "D")?.content ?? "",
        stemFormat: detail.stemFormat,
        stemImageUrl: detail.stemImageUrl ?? "",
        tags: detail.tags.join(","),
      });
      setReviewNote(detail.reviewNote ?? "");
      window.scrollTo({ top: 0, behavior: "smooth" });
    } catch {
      setMessage("题目详情加载失败。");
    } finally {
      setUpdatingQuestionId(null);
    }
  }

  async function handleViewQuestion(questionId: string) {
    const requestId = latestDetailRequest.current + 1;
    latestDetailRequest.current = requestId;
    setViewingQuestionId(questionId);
    setQuestionDetail(null);
    setDetailStatus("loading");
    try {
      const detail = await fetchAdminQuestionDetail(questionId);
      if (latestDetailRequest.current === requestId) {
        setQuestionDetail(detail);
        setDetailStatus("success");
      }
    } catch {
      if (latestDetailRequest.current === requestId) {
        setDetailStatus("error");
      }
    }
  }

  function closeQuestionDetail() {
    latestDetailRequest.current += 1;
    setViewingQuestionId(null);
    setQuestionDetail(null);
    setDetailStatus("idle");
  }

  function updateQuestionInList(questionId: string, patch: Partial<QuestionSummary>) {
    setQuestions((current) =>
      current.map((question) => (question.id === questionId ? { ...question, ...patch } : question)),
    );
  }

  useEffect(() => {
    if (!viewingQuestionId) {
      return;
    }
    function handleKeyDown(event: KeyboardEvent) {
      if (event.key === "Escape") {
        closeQuestionDetail();
      }
    }
    window.addEventListener("keydown", handleKeyDown);
    return () => window.removeEventListener("keydown", handleKeyDown);
  }, [viewingQuestionId]);

  async function handleReviewQuestion(questionId: string, reviewStatus: "PENDING" | "APPROVED" | "REJECTED") {
    setUpdatingQuestionId(questionId);
      setMessage("");
    try {
      await updateQuestionReviewStatus(questionId, reviewStatus, reviewNote || defaultReviewNote(reviewStatus));
      await refreshQuestions();
    } catch {
      setMessage("审核状态更新失败，请稍后再试。");
    } finally {
      setUpdatingQuestionId(null);
    }
  }

  async function handleBulkUpdate(input: { status?: "PUBLISHED" | "DRAFT"; reviewStatus?: "PENDING" | "APPROVED" | "REJECTED"; tags?: string[] }) {
    if (selectedQuestionIds.length === 0) {
      setMessage("请先勾选题目。");
      return;
    }
    setSubmitting(true);
    setMessage("");
    try {
      await bulkUpdateQuestions({ questionIds: selectedQuestionIds, ...input });
      setSelectedQuestionIds([]);
      setMessage("批量更新已完成。");
      await refreshQuestions();
    } catch {
      setMessage("批量更新失败，请稍后再试。");
    } finally {
      setSubmitting(false);
    }
  }

  async function handleToggleStatus(question: QuestionSummary) {
    const nextStatus = question.status === "PUBLISHED" ? "DRAFT" : "PUBLISHED";
    setUpdatingQuestionId(question.id);
    setMessage("");
    try {
      await updateQuestionStatus(question.id, nextStatus);
      await refreshQuestions();
    } catch {
      setMessage("上下架失败，请稍后再试。");
    } finally {
      setUpdatingQuestionId(null);
    }
  }

  async function handleDifficultyChange(questionId: string, difficulty: DifficultyValue) {
    setUpdatingQuestionId(questionId);
    setMessage("");
    try {
      await updateQuestionDifficulty(questionId, difficulty);
      updateQuestionInList(questionId, { difficulty });
      setMessage("题目难度已更新。");
    } catch {
      setMessage("题目难度更新失败，请稍后再试。");
    } finally {
      setUpdatingQuestionId(null);
    }
  }

  async function handleSourceChange(questionId: string, source: SourceValue) {
    setUpdatingQuestionId(questionId);
    setMessage("");
    try {
      await updateQuestionSource(questionId, source);
      updateQuestionInList(questionId, { source });
      setMessage("题目来源已更新。");
    } catch {
      setMessage("题目来源更新失败，请稍后再试。");
    } finally {
      setUpdatingQuestionId(null);
    }
  }

  async function handleFeedbackStatusChange(feedbackId: string, status: QuestionFeedbackStatus) {
    setFeedbackUpdatingId(feedbackId);
    setMessage("");
    try {
      await updateQuestionFeedbackStatus(feedbackId, status, feedbackAdminNotes[feedbackId] ?? "");
      setMessage(status === "RESOLVED" ? "反馈已标记为已处理。" : status === "IGNORED" ? "反馈已忽略。" : "反馈已退回待处理。");
      await refreshFeedbacks();
    } catch {
      setMessage("反馈状态更新失败，请稍后再试。");
    } finally {
      setFeedbackUpdatingId(null);
    }
  }

  async function handleDeleteQuestion(questionId: string) {
    setUpdatingQuestionId(questionId);
    setMessage("");
    try {
      await deleteQuestion(questionId);
      if (editingQuestionId === questionId) {
        resetForm();
      }
      await refreshQuestions();
    } catch {
      setMessage("删除失败，请稍后再试。");
    } finally {
      setUpdatingQuestionId(null);
    }
  }

  async function handleImportQuestions() {
    setSubmitting(true);
    setMessage("");
    try {
      if (importFile && !importText.trim()) {
        const imported = await importQuestionFile(importFile);
        setImportFile(null);
        setMessage(`已从文件导入 ${imported.length} 道题。`);
      } else {
        const questionsToImport = parseImportText(importText);
        await importQuestions(questionsToImport);
        setImportText("");
        setMessage(`已导入 ${questionsToImport.length} 道题。`);
      }
      setImportPreview(null);
      await refreshQuestions();
    } catch {
      setMessage("批量导入失败，请检查 JSON 或上传文件。");
    } finally {
      setSubmitting(false);
    }
  }

  async function handlePreviewImportQuestions() {
    setSubmitting(true);
    setMessage("");
    try {
      const preview = importFile && !importText.trim()
        ? await previewQuestionImportFile(importFile)
        : await previewQuestionImport(parseImportText(importText));
      setImportPreview(preview);
      setMessage(`预校验完成：${preview.validRows} 行可导入，${preview.invalidRows} 行需修正。`);
    } catch {
      setMessage("预校验失败，请检查 JSON 或文件内容。");
    } finally {
      setSubmitting(false);
    }
  }

  async function handleImportFile(event: ChangeEvent<HTMLInputElement>) {
    const file = event.target.files?.[0];
    if (!file) {
      return;
    }
    setMessage("");
    setImportPreview(null);
    setImportFile(file);
    try {
      setImportText("");
      const preview = await previewQuestionImportFile(file);
      setImportPreview(preview);
      setMessage(`文件预校验完成：${preview.validRows} 行可导入，${preview.invalidRows} 行需修正。`);
    } catch {
      setMessage("文件读取失败，请使用包含题目列的 Excel 或 CSV。");
    }
  }

  async function handleStemImageUpload(event: ChangeEvent<HTMLInputElement>) {
    const file = event.target.files?.[0];
    if (!file) {
      return;
    }
    if (!file.type.startsWith("image/")) {
      setMessage("请选择图片文件。");
      event.target.value = "";
      return;
    }
    setUploadingStemImage(true);
    setMessage("");
    try {
      const stemImageUrl = await uploadQuestionStemImage(file, form.subjectCode);
      setForm((current) => ({
        ...current,
        stemFormat: current.stemFormat === "PLAIN_TEXT" ? "IMAGE" : current.stemFormat,
        stemImageUrl,
      }));
      setStemImageFileName(file.name);
      setMessage("题目图片已上传。");
    } catch {
      setMessage("题目图片上传失败，请稍后重试。");
    } finally {
      setUploadingStemImage(false);
      event.target.value = "";
    }
  }

  function toQuestionInput(): CreateQuestionInput {
    const subject = subjects.find((item) => item.value === form.subjectCode) ?? subjects[0];
    return {
      subjectCode: form.subjectCode,
      chapterCode: subject.chapterCode,
      type: form.type,
      difficulty: form.difficulty,
      stem: form.stem.trim(),
      answer: form.answer,
      explanation: form.explanation.trim(),
      source: form.source,
      sourceYear: form.sourceYear ? Number(form.sourceYear) : null,
      score: form.score,
      stemFormat: form.stemFormat,
      stemImageUrl: form.stemImageUrl.trim() || null,
      options: [
        { label: "A", content: form.optionA.trim() },
        { label: "B", content: form.optionB.trim() },
        { label: "C", content: form.optionC.trim() },
        { label: "D", content: form.optionD.trim() },
      ],
      knowledgePointCodes: [subject.knowledgePointCode],
      tags: splitTags(form.tags),
    };
  }

  function resetForm() {
    setEditingQuestionId(null);
    setForm(initialForm);
    setStemImageFileName("");
  }

  if (access === "checking") {
    return (
      <main className="min-h-screen bg-[#f6f8f9] px-5 py-6 text-slate-950">
        <div className="mx-auto max-w-3xl rounded-lg border border-slate-200 bg-white p-6">
          <h1 className="text-xl font-semibold">题库管理后台</h1>
          <p className="mt-2 text-sm text-slate-500">正在校验管理权限...</p>
        </div>
      </main>
    );
  }

  if (access === "login") {
    return (
      <main className="min-h-screen bg-[#f6f8f9] px-5 py-6 text-slate-950">
        <div className="mx-auto max-w-3xl rounded-lg border border-slate-200 bg-white p-6">
          <h1 className="text-xl font-semibold">题库管理后台</h1>
          <p className="mt-2 text-sm text-slate-500">登录后可以管理题库。</p>
          <Link className="mt-5 inline-flex rounded-md bg-teal-700 px-4 py-2 text-sm font-medium text-white" href="/login">
            去登录
          </Link>
        </div>
      </main>
    );
  }

  if (access === "denied") {
    return (
      <main className="min-h-screen bg-[#f6f8f9] px-5 py-6 text-slate-950">
        <div className="mx-auto max-w-3xl rounded-lg border border-slate-200 bg-white p-6">
          <h1 className="text-xl font-semibold">题库管理后台</h1>
          <p className="mt-2 text-sm text-slate-500">当前账号没有管理权限。</p>
          <Link className="mt-5 inline-flex rounded-md border border-slate-200 px-4 py-2 text-sm font-medium text-slate-700" href="/">
            返回仪表盘
          </Link>
        </div>
      </main>
    );
  }

  return (
    <main className="min-h-screen bg-[#f6f8f9] text-slate-950">
      <div className="mx-auto max-w-7xl px-5 py-6">
        <Link className="text-sm font-medium text-teal-700" href="/">
          返回仪表盘
        </Link>
        <header className="mt-4 border-b border-slate-200 pb-5">
          <h1 className="text-2xl font-semibold">题库管理后台</h1>
          <p className="mt-2 text-sm text-slate-500">管理题目创建、编辑、审核、上下架和批量导入。</p>
        </header>

        <section className="mt-5 rounded-lg border border-slate-200 bg-white p-5">
          <h2 className="text-base font-semibold">{editingQuestionId ? "编辑题目" : "新增题目"}</h2>
          <form className="mt-4 grid gap-3" onSubmit={handleSubmitQuestion}>
            <div className="grid gap-3 md:grid-cols-4 lg:grid-cols-7">
              <select className="field" onChange={(event) => setForm({ ...form, subjectCode: event.target.value })} value={form.subjectCode}>
                {subjects.map((subject) => (
                  <option key={subject.value} value={subject.value}>{subject.label}</option>
                ))}
              </select>
              <select className="field" onChange={(event) => setForm({ ...form, type: event.target.value })} value={form.type}>
                <option value="SINGLE_CHOICE">单选题</option>
              </select>
              <select className="field" onChange={(event) => setForm({ ...form, difficulty: event.target.value })} value={form.difficulty}>
                <option value="BASIC">简单</option>
                <option value="MEDIUM">中等</option>
                <option value="HARD">困难</option>
              </select>
              <select className="field" onChange={(event) => setForm({ ...form, source: event.target.value })} value={form.source}>
                <option value="PAST_EXAM">真题</option>
                <option value="MOCK">模拟题</option>
                <option value="ORIGINAL">原创题</option>
              </select>
              <input className="field" min={2009} onChange={(event) => setForm({ ...form, sourceYear: event.target.value })} placeholder="年份" type="number" value={form.sourceYear} />
              <input className="field" min={1} onChange={(event) => setForm({ ...form, score: Number(event.target.value) })} type="number" value={form.score} />
              <select className="field" onChange={(event) => setForm({ ...form, stemFormat: event.target.value })} value={form.stemFormat}>
                <option value="PLAIN_TEXT">纯文本</option>
                <option value="MARKDOWN">Markdown</option>
                <option value="HTML">HTML</option>
                <option value="IMAGE">题干图片</option>
                <option value="DIAGRAM">结构图表</option>
              </select>
            </div>
            <textarea className="field min-h-24" onChange={(event) => setForm({ ...form, stem: event.target.value })} placeholder="题干" value={form.stem} />
            <div className="grid gap-3 md:grid-cols-2">
              <div className="flex min-h-11 items-center gap-3 rounded-md border border-slate-200 px-3 py-2">
                <label className={`inline-flex cursor-pointer rounded-md border border-teal-700 px-3 py-1.5 text-sm font-medium text-teal-800 ${uploadingStemImage ? "pointer-events-none opacity-50" : ""}`}>
                  {uploadingStemImage ? "上传中..." : "上传题目图片"}
                  <input
                    accept="image/*"
                    className="sr-only"
                    disabled={uploadingStemImage}
                    onChange={(event) => void handleStemImageUpload(event)}
                    type="file"
                  />
                </label>
                <span className="min-w-0 truncate text-xs text-slate-500">
                  {stemImageFileName || (form.stemImageUrl ? "已关联题目图片" : "未上传图片")}
                </span>
                {form.stemImageUrl && !uploadingStemImage && (
                  <button
                    className="ml-auto shrink-0 text-xs font-medium text-slate-500 hover:text-red-700"
                    onClick={() => {
                      setForm({ ...form, stemImageUrl: "" });
                      setStemImageFileName("");
                    }}
                    type="button"
                  >
                    移除
                  </button>
                )}
              </div>
              <input className="field" onChange={(event) => setForm({ ...form, tags: event.target.value })} placeholder="标签，用逗号分隔" value={form.tags} />
            </div>
            <div className="flex flex-wrap gap-2">
              <button className="rounded-md border border-slate-200 px-3 py-1.5 text-xs font-medium text-slate-700" onClick={() => setForm({ ...form, stem: `${form.stem}**加粗**` })} type="button">
                B
              </button>
              <button className="rounded-md border border-slate-200 px-3 py-1.5 text-xs font-medium text-slate-700" onClick={() => setForm({ ...form, stem: `${form.stem}_斜体_` })} type="button">
                I
              </button>
              <button className="rounded-md border border-slate-200 px-3 py-1.5 text-xs font-medium text-slate-700" onClick={() => setForm({ ...form, stem: `${form.stem}\n\n${"`代码`"}` })} type="button">
                Code
              </button>
            </div>
            {form.stemFormat !== "PLAIN_TEXT" && (
              <div className="rounded-md border border-slate-200 bg-slate-50 p-3 text-sm text-slate-700">
                <QuestionStemMedia stem={form.stem || "题干预览"} stemFormat={form.stemFormat} stemImageUrl={form.stemImageUrl} />
              </div>
            )}
            <div className="grid gap-3 md:grid-cols-2">
              {(["A", "B", "C", "D"] as const).map((label) => (
                <input
                  className="field"
                  key={label}
                  onChange={(event) => setForm({ ...form, [`option${label}`]: event.target.value })}
                  placeholder={`${label} 选项`}
                  value={form[`option${label}`]}
                />
              ))}
            </div>
            <div className="grid gap-3 md:grid-cols-[120px_1fr]">
              <select className="field" onChange={(event) => setForm({ ...form, answer: event.target.value })} value={form.answer}>
                <option value="A">答案 A</option>
                <option value="B">答案 B</option>
                <option value="C">答案 C</option>
                <option value="D">答案 D</option>
              </select>
              <input className="field" onChange={(event) => setForm({ ...form, explanation: event.target.value })} placeholder="解析" value={form.explanation} />
            </div>
            <div className="flex flex-wrap items-center gap-3">
              <button className="rounded-md bg-teal-700 px-4 py-2 text-sm font-medium text-white disabled:bg-slate-300" disabled={submitting} type="submit">
                {submitting ? "保存中" : editingQuestionId ? "保存题目" : "创建题目"}
              </button>
              {editingQuestionId && (
                <button className="rounded-md border border-slate-200 px-4 py-2 text-sm font-medium text-slate-700" onClick={resetForm} type="button">
                  取消编辑
                </button>
              )}
              {message && <span className="text-sm text-slate-600">{message}</span>}
            </div>
          </form>
        </section>

        <section className="mt-5 rounded-lg border border-slate-200 bg-white p-5">
          <h2 className="text-base font-semibold">批量导入</h2>
          <div className="mt-4 flex flex-wrap items-center gap-3">
            <input
              accept=".xlsx,.xls,.csv"
              className="field max-w-sm"
              onChange={(event) => void handleImportFile(event)}
              type="file"
            />
            <button className="rounded-md border border-slate-200 px-4 py-2 text-sm font-medium text-slate-700 disabled:opacity-50" disabled={submitting || (!importText.trim() && !importFile)} onClick={handlePreviewImportQuestions} type="button">
              预校验
            </button>
            {importFile && <span className="text-xs text-slate-500">已选择：{importFile.name}</span>}
          </div>
          <textarea
            aria-label="批量导入 JSON"
            className="field mt-4 min-h-32 font-mono text-xs"
            onChange={(event) => {
              setImportText(event.target.value);
              setImportFile(null);
            }}
            value={importText}
          />
          <div className="mt-3 flex flex-wrap items-center gap-2">
            <button className="rounded-md border border-teal-700 px-4 py-2 text-sm font-medium text-teal-800 disabled:opacity-50" disabled={submitting || (!importText.trim() && !importFile)} onClick={handleImportQuestions} type="button">
              {importFile && !importText.trim() ? "导入文件" : "导入 JSON"}
            </button>
            <a className="rounded-md border border-slate-200 px-4 py-2 text-sm font-medium text-slate-700 hover:border-teal-200 hover:text-teal-800" download href="/question-import-template.json">
              下载 JSON 模板
            </a>
          </div>
          {importPreview && (
            <div className="mt-4 rounded-md border border-slate-200 bg-slate-50 p-3 text-sm">
              <p className="font-medium text-slate-700">
                共 {importPreview.totalRows} 行，{importPreview.validRows} 行可导入，{importPreview.invalidRows} 行有问题。
              </p>
              {importPreview.errors.length > 0 && (
                <div className="mt-2 space-y-1 text-xs text-red-700">
                  {importPreview.errors.slice(0, 8).map((error) => (
                    <p key={`${error.rowNumber}-${error.field}-${error.message}`}>第 {error.rowNumber} 行 · {error.field} · {error.message}</p>
                  ))}
                </div>
              )}
            </div>
          )}
        </section>

        <section className="mt-5 overflow-hidden rounded-lg border border-slate-200 bg-white">
          <div className="flex flex-wrap items-center justify-between gap-3 border-b border-slate-200 bg-slate-50 px-5 py-3">
            <div className="flex flex-wrap items-center gap-2">
              <span className="text-sm font-semibold text-slate-600">学生题目反馈</span>
              {feedbackPage && (
                <span className="text-xs text-slate-500">共 {feedbackPage.total} 条</span>
              )}
            </div>
            <div className="flex flex-wrap items-center gap-3">
              <select
                aria-label="按反馈状态筛选"
                className="field h-9 md:w-36"
                onChange={(event) => setFeedbackStatusFilter(event.target.value as FeedbackStatusFilter)}
                value={feedbackStatusFilter}
              >
                <option value="">全部状态</option>
                <option value="PENDING">待处理</option>
                <option value="RESOLVED">已处理</option>
                <option value="IGNORED">已忽略</option>
              </select>
              <select
                aria-label="按反馈类型筛选"
                className="field h-9 md:w-40"
                onChange={(event) => setFeedbackIssueTypeFilter(event.target.value as FeedbackIssueTypeFilter)}
                value={feedbackIssueTypeFilter}
              >
                <option value="">全部类型</option>
                {feedbackIssueOptions.map((option) => (
                  <option key={option.value} value={option.value}>{option.label}</option>
                ))}
              </select>
              <button className="h-9 rounded-md border border-slate-200 px-3 text-xs font-medium text-slate-700" onClick={() => void refreshFeedbacks()} type="button">
                刷新
              </button>
            </div>
          </div>
          {feedbackStatus === "loading" && <StateLine text="正在加载题目反馈..." />}
          {feedbackStatus === "error" && <StateLine text="题目反馈加载失败。" tone="error" />}
          {feedbackStatus === "success" && feedbacks.length === 0 && <StateLine text="暂无符合条件的题目反馈。" />}
          {feedbackStatus === "success" && feedbacks.map((feedback) => (
            <div className="grid gap-3 border-b border-slate-100 px-5 py-4 last:border-b-0 lg:grid-cols-[96px_112px_1fr_180px_220px]" key={feedback.id}>
              <div className="flex flex-col gap-2">
                <span className={feedbackStatusBadgeClass(feedback.status)}>{feedbackStatusLabel(feedback.status)}</span>
                <span className="text-xs text-slate-500">{new Date(feedback.createdAt).toLocaleString("zh-CN")}</span>
              </div>
              <div className="text-sm">
                <p className="font-medium text-slate-800">{feedbackIssueLabel(feedback.issueType)}</p>
                <p className="mt-1 text-xs text-slate-500">{feedback.reporterDisplayName}</p>
              </div>
              <div>
                <p className="line-clamp-2 whitespace-pre-wrap text-sm font-medium text-slate-950">{formatQuestionText(feedback.questionStem)}</p>
                <p className="mt-1 text-xs text-slate-500">
                  {subjectLabels[feedback.subjectCode] ?? feedback.subjectName} · {feedback.chapterName}
                </p>
                <p className="mt-2 whitespace-pre-wrap rounded-md bg-slate-50 px-3 py-2 text-sm leading-6 text-slate-700">{formatQuestionText(feedback.description)}</p>
              </div>
              <label className="grid gap-2 text-xs font-medium text-slate-600">
                处理备注
                <textarea
                  className="min-h-20 rounded-md border border-slate-200 px-3 py-2 text-sm font-normal leading-6 text-slate-950 outline-none focus:border-teal-700"
                  onChange={(event) => setFeedbackAdminNotes((current) => ({ ...current, [feedback.id]: event.target.value }))}
                  placeholder="可选"
                  value={feedbackAdminNotes[feedback.id] ?? ""}
                />
              </label>
              <div className="flex flex-wrap items-center gap-2 self-center">
                <button className="rounded-md border border-slate-200 px-3 py-2 text-xs font-medium text-slate-700" onClick={() => void handleViewQuestion(feedback.questionId)} type="button">
                  看题
                </button>
                <button className="rounded-md border border-teal-700 px-3 py-2 text-xs font-medium text-teal-800" onClick={() => void handleEditQuestion(feedback.questionId)} type="button">
                  处理
                </button>
                <button
                  className="rounded-md bg-teal-700 px-3 py-2 text-xs font-medium text-white disabled:bg-slate-300"
                  disabled={feedbackUpdatingId === feedback.id}
                  onClick={() => void handleFeedbackStatusChange(feedback.id, "RESOLVED")}
                  type="button"
                >
                  已处理
                </button>
                <button
                  className="rounded-md border border-slate-200 px-3 py-2 text-xs font-medium text-slate-700 disabled:opacity-50"
                  disabled={feedbackUpdatingId === feedback.id}
                  onClick={() => void handleFeedbackStatusChange(feedback.id, "IGNORED")}
                  type="button"
                >
                  忽略
                </button>
                {feedback.status !== "PENDING" && (
                  <button
                    className="rounded-md border border-slate-200 px-3 py-2 text-xs font-medium text-slate-700 disabled:opacity-50"
                    disabled={feedbackUpdatingId === feedback.id}
                    onClick={() => void handleFeedbackStatusChange(feedback.id, "PENDING")}
                    type="button"
                  >
                    待处理
                  </button>
                )}
              </div>
            </div>
          ))}
        </section>

        <section className="mt-5 overflow-hidden rounded-lg border border-slate-200 bg-white">
          <div className="flex flex-wrap items-center justify-between gap-3 border-b border-slate-200 bg-slate-50 px-5 py-3">
            <div className="flex flex-wrap items-center gap-2">
              <span className="text-sm font-semibold text-slate-600">题目列表</span>
              {questionPage && (
                <span className="text-xs text-slate-500">
                  共 {questionPage.total} 道 · 第 {questionPage.totalPages === 0 ? 0 : questionPage.page + 1}/{questionPage.totalPages} 页
                </span>
              )}
            </div>
            <div className="flex flex-wrap items-center gap-3">
              <input className="field h-9 w-40" onChange={(event) => setBulkTags(event.target.value)} placeholder="批量标签" value={bulkTags} />
              <input className="field h-9 w-44" onChange={(event) => setReviewNote(event.target.value)} placeholder="审核备注" value={reviewNote} />
              <button className="h-9 rounded-md border border-slate-200 px-3 text-xs font-medium text-slate-700" onClick={() => handleBulkUpdate({ reviewStatus: "APPROVED" })} type="button">
                批量通过
              </button>
              <button className="h-9 rounded-md border border-slate-200 px-3 text-xs font-medium text-slate-700" onClick={() => handleBulkUpdate({ reviewStatus: "REJECTED" })} type="button">
                批量驳回
              </button>
              <button className="h-9 rounded-md border border-slate-200 px-3 text-xs font-medium text-slate-700" onClick={() => handleBulkUpdate({ reviewStatus: "PENDING" })} type="button">
                批量待审
              </button>
              <button className="h-9 rounded-md border border-slate-200 px-3 text-xs font-medium text-slate-700" onClick={() => handleBulkUpdate({ status: "PUBLISHED" })} type="button">
                批量上架
              </button>
              <button className="h-9 rounded-md border border-slate-200 px-3 text-xs font-medium text-slate-700" onClick={() => handleBulkUpdate({ status: "DRAFT" })} type="button">
                批量下架
              </button>
              <button className="h-9 rounded-md border border-slate-200 px-3 text-xs font-medium text-slate-700" onClick={() => handleBulkUpdate({ tags: splitTags(bulkTags) })} type="button">
                批量打标
              </button>
            </div>
            <div className="flex flex-wrap items-center gap-3">
              <input
                aria-label="按题目内容搜索"
                className="field h-9 min-w-56 flex-1"
                onChange={(event) => setKeywordInput(event.target.value)}
                placeholder="搜索题干或解析"
                value={keywordInput}
              />
              <select className="field h-9 md:w-48" aria-label="按科目筛选" onChange={(event) => updateFilters({ subject: event.target.value })} value={subjectFilter}>
                <option value="">全部科目</option>
                {subjects.map((subject) => (
                  <option key={subject.value} value={subject.value}>{subject.label}</option>
                ))}
              </select>
              <select className="field h-9 md:w-36" aria-label="按难度筛选" onChange={(event) => updateFilters({ difficulty: event.target.value as DifficultyFilter })} value={difficultyFilter}>
                <option value="">全部难度</option>
                <option value="BASIC">简单</option>
                <option value="MEDIUM">中等</option>
                <option value="HARD">困难</option>
              </select>
              <select className="field h-9 md:w-36" aria-label="按来源筛选" onChange={(event) => updateFilters({ source: event.target.value as SourceFilter })} value={sourceFilter}>
                <option value="">全部来源</option>
                <option value="PAST_EXAM">真题</option>
                <option value="MOCK">模拟题</option>
                <option value="ORIGINAL">原创题</option>
              </select>
              <select className="field h-9 md:w-36" aria-label="按上下架状态筛选" onChange={(event) => updateFilters({ status: event.target.value as ShelfStatusFilter })} value={shelfStatusFilter}>
                <option value="">全部上下架状态</option>
                <option value="PUBLISHED">已上架</option>
                <option value="DRAFT">已下架</option>
              </select>
              <select className="field h-9 md:w-36" aria-label="按审核状态筛选" onChange={(event) => updateFilters({ reviewStatus: event.target.value as ReviewStatusFilter })} value={reviewStatusFilter}>
                <option value="">全部审核状态</option>
                <option value="PENDING">未审核</option>
                <option value="APPROVED">审核通过</option>
                <option value="REJECTED">审核不通过</option>
              </select>
            </div>
          </div>
          {status === "loading" && <StateLine text="正在加载题目..." />}
          {status === "error" && <StateLine text="题目加载失败。" tone="error" />}
          {status === "success" && questions.length === 0 && <StateLine text="暂无题目。" />}
          {status === "success" && questions.map((question) => (
            <div className="grid gap-3 border-b border-slate-100 px-5 py-4 last:border-b-0 lg:grid-cols-[32px_88px_1fr_88px_88px_88px_160px]" key={question.id}>
              <input
                className="justify-self-center"
                checked={selectedQuestionIds.includes(question.id)}
                onChange={(event) => {
                  setSelectedQuestionIds((current) =>
                    event.target.checked ? [...current, question.id] : current.filter((id) => id !== question.id),
                  );
                }}
                type="checkbox"
              />
              <span className="flex self-stretch items-center justify-center text-center text-sm font-medium text-teal-700">{subjectLabels[question.subjectCode] ?? question.subjectName}</span>
              <div
                aria-label="查看题目详情"
                className="cursor-pointer self-center rounded-md p-2 transition hover:bg-slate-50 focus:outline-none focus:ring-2 focus:ring-teal-600"
                onClick={() => void handleViewQuestion(question.id)}
                onKeyDown={(event) => {
                  if (event.key === "Enter" || event.key === " ") {
                    event.preventDefault();
                    void handleViewQuestion(question.id);
                  }
                }}
                role="button"
                tabIndex={0}
              >
                <QuestionStemMedia
                  className={`line-clamp-3 whitespace-pre-wrap text-sm font-medium ${question.status === "DELETED" ? "text-slate-400 line-through" : ""}`}
                  compact
                  linkImage={false}
                  stem={question.stem}
                  stemFormat={question.stemFormat}
                  stemImageUrl={question.stemImageUrl}
                />
                <QuestionStemThumbnail stemImageUrl={question.stemImageUrl} />
                <p className="mt-1 text-xs text-slate-500">
                  {question.chapterName} · {question.knowledgePoints.join("、")}
                  {` · ${sourceLabels[question.source] ?? question.source}`}
                  {question.sourceYear ? ` · ${question.sourceYear}` : ""}
                  {question.tags.length > 0 ? ` · 标签：${question.tags.join("、")}` : ""}
                  {question.reviewNote ? ` · 审核备注：${question.reviewNote}` : ""}
                </p>
                <span className="mt-2 inline-flex text-xs font-medium text-teal-700">查看题目详情</span>
              </div>
              <label className="flex self-stretch items-center justify-center">
                <span className="sr-only">修改题目来源</span>
                <select
                  aria-label="修改题目来源"
                  className="field h-9 w-full text-sm"
                  disabled={updatingQuestionId === question.id || question.status === "DELETED"}
                  onChange={(event) => void handleSourceChange(question.id, event.target.value as SourceValue)}
                  value={question.source}
                >
                  <option value="PAST_EXAM">真题</option>
                  <option value="MOCK">模拟题</option>
                  <option value="ORIGINAL">原创题</option>
                </select>
              </label>
              <span className="flex self-stretch items-center justify-center text-center text-sm text-slate-600">{typeLabels[question.type] ?? question.type}</span>
              <label className="flex self-stretch items-center justify-center">
                <span className="sr-only">修改题目难度</span>
                <select
                  aria-label="修改题目难度"
                  className="field h-9 w-full text-sm"
                  disabled={updatingQuestionId === question.id || question.status === "DELETED"}
                  onChange={(event) => void handleDifficultyChange(question.id, event.target.value as DifficultyValue)}
                  value={question.difficulty}
                >
                  <option value="BASIC">简单</option>
                  <option value="MEDIUM">中等</option>
                  <option value="HARD">困难</option>
                </select>
              </label>
              <div className="flex flex-wrap gap-2 self-center">
                <span className={statusBadgeClass(question.status)}>{statusLabel(question.status)}</span>
                <span className={reviewBadgeClass(question.reviewStatus)}>{reviewLabel(question.reviewStatus)}</span>
                {question.status !== "DELETED" && (
                  <>
                    <button className="text-xs font-medium text-teal-800" disabled={updatingQuestionId === question.id} onClick={() => handleEditQuestion(question.id)} type="button">
                      编辑
                    </button>
                    <button className="text-xs font-medium text-slate-700" disabled={updatingQuestionId === question.id} onClick={() => handleToggleStatus(question)} type="button">
                      {question.status === "PUBLISHED" ? "下架" : "上架"}
                    </button>
                    <button className="text-xs font-medium text-teal-800 disabled:text-slate-300" disabled={updatingQuestionId === question.id || question.reviewStatus === "APPROVED"} onClick={() => handleReviewQuestion(question.id, "APPROVED")} type="button">
                      通过
                    </button>
                    <button className="text-xs font-medium text-red-700 disabled:text-slate-300" disabled={updatingQuestionId === question.id || question.reviewStatus === "REJECTED"} onClick={() => handleReviewQuestion(question.id, "REJECTED")} type="button">
                      驳回
                    </button>
                    <button className="text-xs font-medium text-slate-700 disabled:text-slate-300" disabled={updatingQuestionId === question.id || question.reviewStatus === "PENDING"} onClick={() => handleReviewQuestion(question.id, "PENDING")} type="button">
                      待审
                    </button>
                    <button className="text-xs font-medium text-red-700" disabled={updatingQuestionId === question.id} onClick={() => handleDeleteQuestion(question.id)} type="button">
                      删除
                    </button>
                  </>
                )}
              </div>
            </div>
          ))}
          {status === "success" && questionPage && (
            <div className="flex flex-wrap items-center justify-between gap-3 bg-white px-5 py-4 text-sm text-slate-600">
              <div className="flex flex-wrap items-center gap-2">
                <span>每页</span>
                <select
                  aria-label="每页题目数量"
                  className="field h-9 w-24"
                  onChange={(event) => updatePageSize(Number(event.target.value))}
                  value={pageSize}
                >
                  {adminPageSizes.map((size) => (
                    <option key={size} value={size}>{size}</option>
                  ))}
                </select>
                <span>条</span>
              </div>
              <div className="flex items-center gap-2">
                <button
                  className="h-9 rounded-md border border-slate-200 px-3 text-xs font-medium text-slate-700 disabled:opacity-40"
                  disabled={questionPage.page <= 0}
                  onClick={() => updatePage(questionPage.page - 1)}
                  type="button"
                >
                  上一页
                </button>
                <span className="min-w-24 text-center text-xs">
                  {questionPage.totalPages === 0 ? "第 0 页" : `第 ${questionPage.page + 1} 页`}
                </span>
                <button
                  className="h-9 rounded-md border border-slate-200 px-3 text-xs font-medium text-slate-700 disabled:opacity-40"
                  disabled={questionPage.page + 1 >= questionPage.totalPages}
                  onClick={() => updatePage(questionPage.page + 1)}
                  type="button"
                >
                  下一页
                </button>
              </div>
            </div>
          )}
        </section>
      </div>
      {viewingQuestionId && (
        <QuestionDetailModal
          detail={questionDetail}
          onClose={closeQuestionDetail}
          status={detailStatus}
        />
      )}
    </main>
  );
}

function QuestionDetailModal({
  detail,
  onClose,
  status,
}: {
  detail: QuestionDetail | null;
  onClose: () => void;
  status: "idle" | "loading" | "success" | "error";
}) {
  return (
    <div
      aria-label="关闭题目详情"
      className="fixed inset-0 z-50 flex items-center justify-center bg-slate-950/45 p-4"
      onClick={onClose}
      role="presentation"
    >
      <section
        aria-labelledby="question-detail-title"
        aria-modal="true"
        className="max-h-[min(90vh,860px)] w-full max-w-4xl overflow-y-auto rounded-lg bg-white p-6 shadow-xl"
        onClick={(event) => event.stopPropagation()}
        role="dialog"
      >
        <div className="flex items-start justify-between gap-4 border-b border-slate-200 pb-4">
          <div>
            <h2 className="text-lg font-semibold" id="question-detail-title">题目详情</h2>
            {detail && (
              <p className="mt-1 text-sm text-slate-500">
                {subjectLabels[detail.subjectCode] ?? detail.subjectName} · {detail.chapterName} · {typeLabels[detail.type] ?? detail.type} · {difficultyLabels[detail.difficulty] ?? detail.difficulty}
              </p>
            )}
          </div>
          <button className="rounded-md border border-slate-200 px-3 py-2 text-sm font-medium text-slate-600 hover:bg-slate-50" onClick={onClose} type="button">
            关闭
          </button>
        </div>

        {status === "loading" && <StateLine text="正在加载题目详情..." />}
        {status === "error" && <StateLine text="题目详情加载失败。" tone="error" />}
        {status === "success" && detail && (
          <div className="mt-5">
            <div className="flex flex-wrap gap-2 text-xs">
              <span className={statusBadgeClass(detail.status)}>{statusLabel(detail.status)}</span>
              <span className={reviewBadgeClass(detail.reviewStatus)}>{reviewLabel(detail.reviewStatus)}</span>
              <span className="rounded-md bg-slate-100 px-2 py-1 font-medium text-slate-600">{sourceLabels[detail.source] ?? detail.source}{detail.sourceYear ? ` · ${detail.sourceYear}` : ""}</span>
              <span className="rounded-md bg-slate-100 px-2 py-1 font-medium text-slate-600">{detail.score} 分</span>
            </div>
            <div className="mt-5">
              <QuestionStemMedia
                className="whitespace-pre-wrap text-base font-semibold leading-7"
                stem={detail.stem}
                stemFormat={detail.stemFormat}
                stemImageUrl={detail.stemImageUrl}
              />
            </div>
            {detail.options.length > 0 && (
              <div className="mt-5 grid gap-3 sm:grid-cols-2">
                {detail.options.map((option) => (
                  <div className={`rounded-md border px-4 py-3 text-sm ${option.label === detail.answer ? "border-teal-600 bg-teal-50" : "border-slate-200"}`} key={option.id}>
                    <span className="mr-3 font-semibold text-slate-950">{option.label}</span>
                    <span className="whitespace-pre-wrap text-slate-700">{formatQuestionText(option.content)}</span>
                  </div>
                ))}
              </div>
            )}
            <section className="mt-5 rounded-md border border-teal-100 bg-teal-50/60 p-4">
              <h3 className="text-sm font-semibold text-slate-950">正确答案</h3>
              <p className="mt-2 text-base font-semibold text-teal-800">{detail.answer}</p>
            </section>
            <section className="mt-4 rounded-md border border-slate-200 bg-slate-50 p-4">
              <h3 className="text-sm font-semibold text-slate-950">解析</h3>
              <p className="mt-2 whitespace-pre-wrap text-sm leading-7 text-slate-700">{formatQuestionText(detail.explanation) || "暂无解析。"}</p>
            </section>
          </div>
        )}
      </section>
    </div>
  );
}

const feedbackIssueOptions: Array<{ value: QuestionFeedbackIssueType; label: string }> = [
  { value: "ANSWER_INCORRECT", label: "答案错误" },
  { value: "EXPLANATION_UNCLEAR", label: "解析不清" },
  { value: "STEM_ERROR", label: "题干有错" },
  { value: "OPTION_ERROR", label: "选项有错" },
  { value: "IMAGE_DISPLAY_ERROR", label: "图片显示异常" },
  { value: "OTHER", label: "其他" },
];

function feedbackIssueLabel(issueType: QuestionFeedbackIssueType) {
  return feedbackIssueOptions.find((option) => option.value === issueType)?.label ?? issueType;
}

function feedbackStatusLabel(status: QuestionFeedbackStatus) {
  if (status === "RESOLVED") {
    return "已处理";
  }
  if (status === "IGNORED") {
    return "已忽略";
  }
  return "待处理";
}

function feedbackStatusBadgeClass(status: QuestionFeedbackStatus) {
  if (status === "RESOLVED") {
    return "w-fit rounded-md bg-emerald-50 px-2 py-1 text-xs font-medium text-emerald-800";
  }
  if (status === "IGNORED") {
    return "w-fit rounded-md bg-slate-100 px-2 py-1 text-xs font-medium text-slate-600";
  }
  return "w-fit rounded-md bg-amber-50 px-2 py-1 text-xs font-medium text-amber-800";
}

function statusLabel(status: string) {
  return status === "PUBLISHED" ? "已上架" : status === "DRAFT" ? "已下架" : "已删除";
}

function statusBadgeClass(status: string) {
  if (status === "PUBLISHED") {
    return "rounded-md bg-teal-50 px-2 py-1 text-xs font-medium text-teal-800";
  }
  if (status === "DRAFT") {
    return "rounded-md bg-amber-50 px-2 py-1 text-xs font-medium text-amber-800";
  }
  return "rounded-md bg-slate-100 px-2 py-1 text-xs font-medium text-slate-500";
}

function reviewLabel(status: string) {
  if (status === "APPROVED") {
    return "审核通过";
  }
  if (status === "REJECTED") {
    return "审核不通过";
  }
  return "未审核";
}

function reviewBadgeClass(status: string) {
  if (status === "APPROVED") {
    return "rounded-md bg-emerald-50 px-2 py-1 text-xs font-medium text-emerald-800";
  }
  if (status === "REJECTED") {
    return "rounded-md bg-red-50 px-2 py-1 text-xs font-medium text-red-700";
  }
  return "rounded-md bg-blue-50 px-2 py-1 text-xs font-medium text-blue-800";
}

function defaultReviewNote(status: "PENDING" | "APPROVED" | "REJECTED") {
  if (status === "APPROVED") {
    return "审核通过";
  }
  if (status === "REJECTED") {
    return "审核驳回";
  }
  return "退回待审";
}

function splitTags(value: string) {
  return value
    .split(/[,，]/)
    .map((tag) => tag.trim())
    .filter(Boolean);
}

function parseImportText(value: string): CreateQuestionInput[] {
  const parsed = JSON.parse(value) as CreateQuestionInput[] | { questions: CreateQuestionInput[] };
  return Array.isArray(parsed) ? parsed : parsed.questions;
}

function StateLine({ text, tone = "default" }: { text: string; tone?: "default" | "error" }) {
  return <div className={`px-5 py-10 text-center text-sm ${tone === "error" ? "text-red-700" : "text-slate-500"}`}>{text}</div>;
}
