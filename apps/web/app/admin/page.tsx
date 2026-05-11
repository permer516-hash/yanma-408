"use client";

import Link from "next/link";
import type { ChangeEvent, FormEvent } from "react";
import { useCallback, useEffect, useState } from "react";
import {
  CreateQuestionInput,
  ImportValidationResult,
  bulkUpdateQuestions,
  createQuestion,
  deleteQuestion,
  fetchAdminQuestionDetail,
  fetchAdminQuestions,
  getAuth,
  importQuestionFile,
  importQuestions,
  previewQuestionImportFile,
  previewQuestionImport,
  QuestionSummary,
  updateQuestion,
  updateQuestionReviewStatus,
  updateQuestionStatus,
} from "@/app/lib/api";
import { difficultyLabels, subjectLabels, typeLabels } from "@/app/lib/question-labels";

const subjects = [
  { label: "数据结构", value: "DATA_STRUCTURE", chapterCode: "DS_TREE", knowledgePointCode: "DS_TREE_TRAVERSAL" },
  { label: "计组", value: "COMPUTER_ORGANIZATION", chapterCode: "CO_CACHE", knowledgePointCode: "CO_CACHE_MAPPING" },
  { label: "操作系统", value: "OPERATING_SYSTEM", chapterCode: "OS_PROCESS", knowledgePointCode: "OS_SCHEDULING" },
  { label: "计网", value: "COMPUTER_NETWORK", chapterCode: "CN_TRANSPORT", knowledgePointCode: "CN_TCP_CONGESTION" },
];

const initialForm = {
  subjectCode: "DATA_STRUCTURE",
  type: "SINGLE_CHOICE",
  difficulty: "BASIC",
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
  const [hasAuth, setHasAuth] = useState<boolean | null>(null);
  const [questions, setQuestions] = useState<QuestionSummary[]>([]);
  const [subjectFilter, setSubjectFilter] = useState("");
  const [status, setStatus] = useState<"loading" | "success" | "error">("loading");
  const [form, setForm] = useState(initialForm);
  const [editingQuestionId, setEditingQuestionId] = useState<string | null>(null);
  const [submitting, setSubmitting] = useState(false);
  const [updatingQuestionId, setUpdatingQuestionId] = useState<string | null>(null);
  const [selectedQuestionIds, setSelectedQuestionIds] = useState<string[]>([]);
  const [bulkTags, setBulkTags] = useState("");
  const [reviewNote, setReviewNote] = useState("");
  const [importText, setImportText] = useState("");
  const [importFile, setImportFile] = useState<File | null>(null);
  const [importPreview, setImportPreview] = useState<ImportValidationResult | null>(null);
  const [message, setMessage] = useState("");

  const refreshQuestions = useCallback(async () => {
    setStatus("loading");
    try {
      setQuestions(await fetchAdminQuestions(subjectFilter || undefined));
      setStatus("success");
    } catch {
      setStatus("error");
    }
  }, [subjectFilter]);

  useEffect(() => {
    let cancelled = false;
    Promise.resolve().then(() => {
      if (!cancelled) {
        setHasAuth(Boolean(getAuth()));
      }
    });
    return () => {
      cancelled = true;
    };
  }, []);

  useEffect(() => {
    if (!hasAuth) {
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
  }, [hasAuth, refreshQuestions]);

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
      source: "ORIGINAL",
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
  }

  if (hasAuth === false) {
    return (
      <main className="min-h-screen bg-[#f6f8f9] px-5 py-6 text-slate-950">
        <div className="mx-auto max-w-3xl rounded-lg border border-slate-200 bg-white p-6">
          <h1 className="text-xl font-semibold">管理后台</h1>
          <p className="mt-2 text-sm text-slate-500">登录后可以管理题库。</p>
          <Link className="mt-5 inline-flex rounded-md bg-teal-700 px-4 py-2 text-sm font-medium text-white" href="/login">
            去登录
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
          <h1 className="text-2xl font-semibold">管理后台</h1>
          <p className="mt-2 text-sm text-slate-500">题目创建、编辑、上下架、软删除和 JSON 批量导入。</p>
        </header>

        <section className="mt-5 rounded-lg border border-slate-200 bg-white p-5">
          <h2 className="text-base font-semibold">{editingQuestionId ? "编辑题目" : "新增题目"}</h2>
          <form className="mt-4 grid gap-3" onSubmit={handleSubmitQuestion}>
            <div className="grid gap-3 md:grid-cols-5">
              <select className="field" onChange={(event) => setForm({ ...form, subjectCode: event.target.value })} value={form.subjectCode}>
                {subjects.map((subject) => (
                  <option key={subject.value} value={subject.value}>{subject.label}</option>
                ))}
              </select>
              <select className="field" onChange={(event) => setForm({ ...form, type: event.target.value })} value={form.type}>
                <option value="SINGLE_CHOICE">单选题</option>
              </select>
              <select className="field" onChange={(event) => setForm({ ...form, difficulty: event.target.value })} value={form.difficulty}>
                <option value="BASIC">基础</option>
                <option value="MEDIUM">中等</option>
                <option value="HARD">困难</option>
              </select>
              <input className="field" min={1} onChange={(event) => setForm({ ...form, score: Number(event.target.value) })} type="number" value={form.score} />
              <select className="field" onChange={(event) => setForm({ ...form, stemFormat: event.target.value })} value={form.stemFormat}>
                <option value="PLAIN_TEXT">纯文本</option>
                <option value="MARKDOWN">Markdown</option>
                <option value="HTML">HTML</option>
              </select>
            </div>
            <textarea className="field min-h-24" onChange={(event) => setForm({ ...form, stem: event.target.value })} placeholder="题干" value={form.stem} />
            <div className="grid gap-3 md:grid-cols-2">
              <input className="field" onChange={(event) => setForm({ ...form, stemImageUrl: event.target.value })} placeholder="题干图片 URL" value={form.stemImageUrl} />
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
                <p className="whitespace-pre-wrap">{form.stem || "富文本预览"}</p>
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
            className="field mt-4 min-h-32 font-mono text-xs"
            onChange={(event) => {
              setImportText(event.target.value);
              setImportFile(null);
            }}
            placeholder='[{"subjectCode":"DATA_STRUCTURE","chapterCode":"DS_TREE","type":"SINGLE_CHOICE","difficulty":"BASIC","stem":"...","answer":"A","explanation":"...","source":"ORIGINAL","score":2,"options":[{"label":"A","content":"..."}],"knowledgePointCodes":["DS_TREE_TRAVERSAL"]}]'
            value={importText}
          />
          <button className="mt-3 rounded-md border border-teal-700 px-4 py-2 text-sm font-medium text-teal-800 disabled:opacity-50" disabled={submitting || (!importText.trim() && !importFile)} onClick={handleImportQuestions} type="button">
            {importFile && !importText.trim() ? "导入文件" : "导入 JSON"}
          </button>
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
          <div className="flex flex-col gap-3 border-b border-slate-200 bg-slate-50 px-5 py-3 md:flex-row md:items-center md:justify-between">
            <span className="text-sm font-semibold text-slate-600">题目列表</span>
            <div className="flex flex-wrap items-center gap-2">
              <input className="field h-9 w-40" onChange={(event) => setBulkTags(event.target.value)} placeholder="批量标签" value={bulkTags} />
              <input className="field h-9 w-44" onChange={(event) => setReviewNote(event.target.value)} placeholder="审核备注" value={reviewNote} />
              <button className="h-9 rounded-md border border-slate-200 px-3 text-xs font-medium text-slate-700" onClick={() => handleBulkUpdate({ reviewStatus: "APPROVED" })} type="button">
                批量通过
              </button>
              <button className="h-9 rounded-md border border-slate-200 px-3 text-xs font-medium text-slate-700" onClick={() => handleBulkUpdate({ status: "DRAFT" })} type="button">
                批量下架
              </button>
              <button className="h-9 rounded-md border border-slate-200 px-3 text-xs font-medium text-slate-700" onClick={() => handleBulkUpdate({ tags: splitTags(bulkTags) })} type="button">
                批量打标
              </button>
              <select className="field h-9 md:w-44" onChange={(event) => setSubjectFilter(event.target.value)} value={subjectFilter}>
                <option value="">全部科目</option>
                {subjects.map((subject) => (
                  <option key={subject.value} value={subject.value}>{subject.label}</option>
                ))}
              </select>
            </div>
          </div>
          {status === "loading" && <StateLine text="正在加载题目..." />}
          {status === "error" && <StateLine text="题目加载失败。" tone="error" />}
          {status === "success" && questions.length === 0 && <StateLine text="暂无题目。" />}
          {status === "success" && questions.map((question) => (
            <div className="grid gap-3 border-b border-slate-100 px-5 py-4 last:border-b-0 lg:grid-cols-[32px_88px_1fr_88px_88px_160px]" key={question.id}>
              <input
                checked={selectedQuestionIds.includes(question.id)}
                onChange={(event) => {
                  setSelectedQuestionIds((current) =>
                    event.target.checked ? [...current, question.id] : current.filter((id) => id !== question.id),
                  );
                }}
                type="checkbox"
              />
              <span className="text-sm font-medium text-teal-700">{subjectLabels[question.subjectCode] ?? question.subjectName}</span>
              <div>
                <p className={`line-clamp-2 text-sm font-medium ${question.status === "DELETED" ? "text-slate-400 line-through" : ""}`}>{question.stem}</p>
                <p className="mt-1 text-xs text-slate-500">
                  {question.chapterName} · {question.knowledgePoints.join("、")}
                  {question.tags.length > 0 ? ` · 标签：${question.tags.join("、")}` : ""}
                  {question.reviewNote ? ` · 审核备注：${question.reviewNote}` : ""}
                </p>
              </div>
              <span className="text-sm text-slate-600">{typeLabels[question.type] ?? question.type}</span>
              <span className="text-sm text-slate-600">{difficultyLabels[question.difficulty] ?? question.difficulty}</span>
              <div className="flex flex-wrap gap-2">
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
                    <button className="text-xs font-medium text-slate-700" disabled={updatingQuestionId === question.id} onClick={() => handleReviewQuestion(question.id, question.reviewStatus === "APPROVED" ? "PENDING" : "APPROVED")} type="button">
                      {question.reviewStatus === "APPROVED" ? "待审" : "通过"}
                    </button>
                    <button className="text-xs font-medium text-red-700" disabled={updatingQuestionId === question.id} onClick={() => handleDeleteQuestion(question.id)} type="button">
                      删除
                    </button>
                  </>
                )}
              </div>
            </div>
          ))}
        </section>
      </div>
    </main>
  );
}

function statusLabel(status: string) {
  return status === "PUBLISHED" ? "已上架" : status === "DRAFT" ? "草稿" : "已删除";
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
    return "已通过";
  }
  if (status === "REJECTED") {
    return "已驳回";
  }
  return "待审核";
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
