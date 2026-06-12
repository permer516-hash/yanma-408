const state = {
  token: localStorage.getItem("workbenchToken") || "",
};

const labels = {
  sourceType: {
    TEXTBOOK: "教材",
    PAST_EXAM: "真题卷",
    MOCK_EXAM: "模拟卷",
    ORIGINAL_DRAFT: "原创草稿",
    OTHER: "其他",
  },
  subject: {
    DATA_STRUCTURE: "数据结构",
    COMPUTER_ORGANIZATION: "计算机组成原理",
    OPERATING_SYSTEM: "操作系统",
    COMPUTER_NETWORK: "计算机网络",
  },
  source: {
    PAST_EXAM: "真题",
    MOCK: "模拟题",
    ORIGINAL: "原创题",
  },
  difficulty: {
    BASIC: "简单",
    MEDIUM: "中等",
    HARD: "困难",
  },
  type: {
    SINGLE_CHOICE: "单选题",
    MULTIPLE_CHOICE: "多选题",
    COMPREHENSIVE: "综合题",
    ALGORITHM: "算法题",
    CALCULATION: "计算题",
  },
};

const $ = (id) => document.getElementById(id);

function apiBaseUrl() {
  return $("apiBaseUrl").value.replace(/\/$/, "");
}

function headers() {
  return state.token ? { Authorization: `Bearer ${state.token}` } : {};
}

function setStateText(id, text, isError = false) {
  const node = $(id);
  node.textContent = text;
  node.style.color = isError ? "#b91c1c" : "#64748b";
}

async function login(event) {
  event.preventDefault();
  setStateText("authState", "登录中...");
  const response = await fetch(`${apiBaseUrl()}/auth/login`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      username: $("username").value,
      password: $("password").value,
    }),
  });
  if (!response.ok) {
    throw new Error(await errorMessage(response));
  }
  const result = await response.json();
  state.token = result.token;
  localStorage.setItem("workbenchToken", result.token);
  await loadCurrentUser(result.username);
  await loadAssets();
  await loadQuotas();
  await loadDrafts();
}

async function loadCurrentUser(fallbackUsername = "") {
  if (!state.token) {
    setStateText("authState", "未登录");
    return;
  }
  const response = await fetch(`${apiBaseUrl()}/auth/me`, {
    headers: headers(),
  });
  if (!response.ok) {
    setStateText("authState", fallbackUsername ? `已登录：${fallbackUsername}` : "已读取本地 token。");
    return;
  }
  const user = await response.json();
  const roles = user.roles && user.roles.length > 0 ? user.roles.join(", ") : "STUDENT";
  setStateText("authState", `已登录：${user.username} · ${roles}`);
}

async function uploadMaterial(event) {
  event.preventDefault();
  if (!state.token) {
    setStateText("uploadState", "请先登录。", true);
    return;
  }
  const form = event.currentTarget;
  const data = new FormData(form);
  if (!data.get("sourceYear")) {
    data.delete("sourceYear");
  }
  setStateText("uploadState", "上传中...");
  const response = await fetch(`${apiBaseUrl()}/workbench/materials/upload`, {
    method: "POST",
    headers: headers(),
    body: data,
  });
  if (!response.ok) {
    throw new Error(await errorMessage(response));
  }
  const asset = await response.json();
  setStateText("uploadState", `上传成功：${asset.objectKey}`);
  form.reset();
  await loadAssets();
}

async function scanLocalMaterials(event) {
  event.preventDefault();
  if (!state.token) {
    setStateText("scanState", "请先登录。", true);
    return;
  }
  const form = event.currentTarget;
  setStateText("scanState", "扫描中...");
  const response = await fetch(`${apiBaseUrl()}/workbench/materials/scan-local`, {
    method: "POST",
    headers: { ...headers(), "Content-Type": "application/json" },
    body: JSON.stringify({ rootPath: form.rootPath.value }),
  });
  if (!response.ok) {
    throw new Error(await errorMessage(response));
  }
  const result = await response.json();
  setStateText("scanState", `扫描 ${result.scannedFiles} 个文件，新登记 ${result.registeredFiles} 个，跳过 ${result.skippedFiles} 个。`);
  await loadAssets();
}

async function createAudit(event) {
  event.preventDefault();
  if (!state.token) {
    setStateText("auditState", "请先登录。", true);
    return;
  }
  const form = event.currentTarget;
  const body = {
    sourceName: form.sourceName.value,
    sourceYear: form.sourceYear.value ? Number(form.sourceYear.value) : null,
    authorizationScope: form.authorizationScope.value,
    riskLevel: form.riskLevel.value,
    decision: form.decision.value,
    notes: form.notes.value,
    auditedBy: "workbench",
  };
  setStateText("auditState", "保存审计记录中...");
  const response = await fetch(`${apiBaseUrl()}/workbench/materials/${form.materialAssetId.value}/copyright-audits`, {
    method: "POST",
    headers: { ...headers(), "Content-Type": "application/json" },
    body: JSON.stringify(body),
  });
  if (!response.ok) {
    throw new Error(await errorMessage(response));
  }
  const audit = await response.json();
  setStateText("auditState", `审计已保存：${audit.decision}`);
  form.reset();
}

async function extractCandidates(event) {
  event.preventDefault();
  if (!state.token) {
    setStateText("extractState", "请先登录。", true);
    return;
  }
  const form = event.currentTarget;
  setStateText("extractState", "拆题候选生成中...");
  const response = await fetch(`${apiBaseUrl()}/workbench/materials/${form.materialAssetId.value}/extract-candidates`, {
    method: "POST",
    headers: { ...headers(), "Content-Type": "application/json" },
    body: JSON.stringify({
      startPage: Number(form.startPage.value),
      endPage: Number(form.endPage.value),
    }),
  });
  if (!response.ok) {
    throw new Error(await errorMessage(response));
  }
  const candidates = await response.json();
  renderCandidates(candidates);
  setStateText("extractState", `已生成 ${candidates.length} 条候选。`);
}

async function uploadAuthorizationAttachment(event) {
  event.preventDefault();
  if (!state.token) {
    setStateText("attachmentState", "请先登录。", true);
    return;
  }
  const form = event.currentTarget;
  const data = new FormData(form);
  const materialAssetId = data.get("materialAssetId");
  data.delete("materialAssetId");
  if (!data.get("auditId")) {
    data.delete("auditId");
  }
  setStateText("attachmentState", "授权附件上传中...");
  const response = await fetch(`${apiBaseUrl()}/workbench/materials/${materialAssetId}/authorization-attachments`, {
    method: "POST",
    headers: headers(),
    body: data,
  });
  if (!response.ok) {
    throw new Error(await errorMessage(response));
  }
  const attachment = await response.json();
  setStateText("attachmentState", `附件已归档：${attachment.originalFilename}`);
  form.reset();
}

async function runCandidateOcr() {
  if (!state.token) {
    setStateText("candidateReviewState", "请先登录。", true);
    return;
  }
  const form = $("candidateReviewForm");
  setStateText("candidateReviewState", "OCR 执行中...");
  const response = await fetch(`${apiBaseUrl()}/workbench/extraction-candidates/${form.candidateId.value}/run-ocr`, {
    method: "POST",
    headers: { ...headers(), "Content-Type": "application/json" },
    body: JSON.stringify({ ocrTextOverride: form.ocrTextOverride.value || null }),
  });
  if (!response.ok) {
    throw new Error(await errorMessage(response));
  }
  const candidate = await response.json();
  form.stem.value = candidate.correctedStem || candidate.suggestedStem || candidate.ocrText || candidate.rawText || "";
  setStateText("candidateReviewState", `OCR 状态：${candidate.status}`);
}

async function reviewCandidate(event) {
  event.preventDefault();
  if (!state.token) {
    setStateText("candidateReviewState", "请先登录。", true);
    return;
  }
  const form = event.currentTarget;
  const response = await fetch(`${apiBaseUrl()}/workbench/extraction-candidates/${form.candidateId.value}/review`, {
    method: "PATCH",
    headers: { ...headers(), "Content-Type": "application/json" },
    body: JSON.stringify({
      type: form.type.value,
      stem: form.stem.value,
      answer: form.answer.value,
      explanation: form.explanation.value,
      options: optionCommands(form),
    }),
  });
  if (!response.ok) {
    throw new Error(await errorMessage(response));
  }
  const candidate = await response.json();
  setStateText("candidateReviewState", `候选已校对：${candidate.status}`);
}

async function batchCreateDrafts(event) {
  event.preventDefault();
  if (!state.token) {
    setStateText("batchDraftState", "请先登录。", true);
    return;
  }
  const form = event.currentTarget;
  const response = await fetch(`${apiBaseUrl()}/workbench/extraction-candidates/batch-create-drafts`, {
    method: "POST",
    headers: { ...headers(), "Content-Type": "application/json" },
    body: JSON.stringify({
      candidateIds: splitList(form.candidateIds.value),
      subjectCode: form.subjectCode.value,
      chapterCode: form.chapterCode.value,
      difficulty: form.difficulty.value,
      source: form.source.value,
      score: Number(form.score.value || 2),
      knowledgePointCodes: [form.knowledgePointCodes.value],
      tags: splitList(form.tags.value),
    }),
  });
  if (!response.ok) {
    throw new Error(await errorMessage(response));
  }
  const result = await response.json();
  setStateText("batchDraftState", `已生成 ${result.createdCount} 条草稿。`);
  await loadDrafts();
  await loadQuotas();
}

async function loadAssets() {
  if (!state.token) {
    $("assetList").innerHTML = `<p class="state">登录后查看资料资产。</p>`;
    return;
  }
  const params = new URLSearchParams();
  appendParam(params, "keyword", $("keyword").value);
  appendParam(params, "sourceType", $("sourceTypeFilter").value);
  appendParam(params, "subjectCode", $("subjectFilter").value);
  const response = await fetch(`${apiBaseUrl()}/workbench/materials?${params.toString()}`, {
    headers: headers(),
  });
  if (!response.ok) {
    throw new Error(await errorMessage(response));
  }
  const assets = await response.json();
  renderAssets(assets);
}

async function loadQuotas() {
  if (!state.token) {
    $("quotaList").innerHTML = `<p class="state">登录后查看题量配额。</p>`;
    return;
  }
  const response = await fetch(`${apiBaseUrl()}/workbench/content-quotas`, {
    headers: headers(),
  });
  if (!response.ok) {
    throw new Error(await errorMessage(response));
  }
  renderQuotas(await response.json());
}

async function createDraft(event) {
  event.preventDefault();
  if (!state.token) {
    setStateText("draftState", "请先登录。", true);
    return;
  }
  const form = event.currentTarget;
  const body = {
    materialAssetId: form.materialAssetId.value || null,
    subjectCode: form.subjectCode.value,
    chapterCode: form.chapterCode.value,
    type: form.type.value,
    difficulty: form.difficulty.value,
    stem: form.stem.value,
    answer: form.answer.value,
    explanation: form.explanation.value,
    source: form.source.value,
    sourceYear: form.sourceYear.value ? Number(form.sourceYear.value) : null,
    score: 2,
    stemFormat: form.stemFormat.value,
    stemImageUrl: form.stemImageUrl.value || null,
    options: optionCommands(form),
    knowledgePointCodes: [form.knowledgePointCodes.value],
    tags: splitList(form.tags.value),
    pageReferences: draftPageReferences(form),
    createdBy: "workbench",
  };
  setStateText("draftState", "保存草稿中...");
  const response = await fetch(`${apiBaseUrl()}/workbench/question-drafts`, {
    method: "POST",
    headers: { ...headers(), "Content-Type": "application/json" },
    body: JSON.stringify(body),
  });
  if (!response.ok) {
    throw new Error(await errorMessage(response));
  }
  const draft = await response.json();
  setStateText("draftState", `草稿已保存：${draft.id}`);
  form.reset();
  await loadDrafts();
  await loadQuotas();
}

async function loadDrafts() {
  if (!state.token) {
    $("draftList").innerHTML = `<p class="state">登录后查看草稿。</p>`;
    return;
  }
  const response = await fetch(`${apiBaseUrl()}/workbench/question-drafts`, {
    headers: headers(),
  });
  if (!response.ok) {
    throw new Error(await errorMessage(response));
  }
  renderDrafts(await response.json());
}

function renderAssets(assets) {
  const list = $("assetList");
  if (assets.length === 0) {
    list.innerHTML = `<p class="state">暂无资料资产。</p>`;
    return;
  }
  list.innerHTML = assets.map((asset) => `
    <article class="asset">
      <div class="asset-title">
        <strong>${escapeHtml(asset.title)}</strong>
        <span class="badge">${label(labels.sourceType, asset.sourceType)}</span>
      </div>
      <p class="meta">
        ${label(labels.subject, asset.subjectCode) || "未指定科目"} · ${asset.sourceYear || "无年份"} · ${formatBytes(asset.sizeBytes)} · ${asset.status}
      </p>
      <p class="object-key">${escapeHtml(asset.bucket)}/${escapeHtml(asset.objectKey)}</p>
      <p class="meta">ID: ${escapeHtml(asset.id)} · SHA-256: ${escapeHtml(asset.sha256)}</p>
      <a class="download" href="#" data-id="${asset.id}">生成 10 分钟下载链接</a>
    </article>
  `).join("");
}

function renderQuotas(quotas) {
  const list = $("quotaList");
  if (quotas.length === 0) {
    list.innerHTML = `<p class="state">暂无配额。</p>`;
    return;
  }
  list.innerHTML = quotas.map((quota) => `
    <article class="asset quota">
      <div class="asset-title">
        <strong>${label(labels.subject, quota.subjectCode)} · ${escapeHtml(quota.knowledgePointCode)}</strong>
        <span class="badge">${label(labels.source, quota.source)} / ${label(labels.difficulty, quota.difficulty)}</span>
      </div>
      <div class="progress-line">
        <span>目标 ${quota.targetCount}</span>
        <span>已发布 ${quota.publishedCount}</span>
        <span>已审草稿 ${quota.approvedDraftCount}</span>
        <span>审核中 ${quota.reviewingDraftCount}</span>
        <span>缺口 ${quota.remainingCount}</span>
      </div>
      <p class="meta">${escapeHtml(quota.notes || "")}</p>
    </article>
  `).join("");
}

function renderDrafts(drafts) {
  const list = $("draftList");
  if (drafts.length === 0) {
    list.innerHTML = `<p class="state">暂无题目草稿。</p>`;
    return;
  }
  list.innerHTML = drafts.map((draft) => `
    <article class="asset">
      <div class="asset-title">
        <strong>${escapeHtml(draft.stem)}</strong>
        <span class="badge">${draft.status} / ${draft.reviewStatus}</span>
      </div>
      <p class="meta">
        ${label(labels.subject, draft.subjectCode)} · ${label(labels.source, draft.source)} · ${label(labels.difficulty, draft.difficulty)} · ${draft.knowledgePointCodes.join(", ")}
      </p>
      <p class="meta">${label(labels.type, draft.type)} · 答案：${escapeHtml(draft.answer)} · 指纹：${escapeHtml(draft.fingerprint.slice(0, 16))}</p>
      <div class="actions">
        <button type="button" data-action="duplicates" data-id="${draft.id}">查重</button>
        <button type="button" data-action="submit" data-id="${draft.id}">送审</button>
        <button type="button" data-action="approve" data-id="${draft.id}">通过</button>
        <button type="button" data-action="reject" data-id="${draft.id}">拒绝</button>
        <button type="button" data-action="publish" data-id="${draft.id}">发布</button>
      </div>
    </article>
  `).join("");
}

function renderCandidates(candidates) {
  const list = $("candidateList");
  if (candidates.length === 0) {
    list.innerHTML = `<p class="state">未生成候选。</p>`;
    return;
  }
  list.innerHTML = candidates.map((candidate) => `
    <article class="asset compact">
      <div class="asset-title">
        <strong>第 ${candidate.pageNumber} 页 · ${candidate.extractionMethod}</strong>
        <span class="badge">${candidate.status}</span>
      </div>
      <p class="meta">候选 ID: ${escapeHtml(candidate.id)} · 置信度 ${Math.round(candidate.confidence * 100)}%</p>
      <p class="meta">${escapeHtml(candidate.correctedStem || candidate.suggestedStem || candidate.ocrText || "待 OCR 后补题干")}</p>
    </article>
  `).join("");
}

async function openDownloadUrl(event) {
  const link = event.target.closest(".download");
  if (!link) {
    return;
  }
  event.preventDefault();
  const response = await fetch(`${apiBaseUrl()}/workbench/materials/${link.dataset.id}/download-url`, {
    headers: headers(),
  });
  if (!response.ok) {
    throw new Error(await errorMessage(response));
  }
  const result = await response.json();
  window.open(result.url, "_blank", "noopener,noreferrer");
}

async function handleDraftAction(event) {
  const button = event.target.closest("button[data-action]");
  if (!button) {
    return;
  }
  const { action, id } = button.dataset;
  if (action === "duplicates") {
    const response = await fetch(`${apiBaseUrl()}/workbench/question-drafts/${id}/duplicates`, {
      headers: headers(),
    });
    if (!response.ok) {
      throw new Error(await errorMessage(response));
    }
    const result = await response.json();
    const first = result.items[0];
    const suffix = first ? `最高相似度 ${Math.round(first.similarityScore * 100)}% · ${first.matchType}` : "";
    setStateText("draftState", result.items.length ? `发现 ${result.items.length} 个疑似重复。${suffix}` : "未发现疑似重复。", result.duplicate);
    return;
  }
  const endpoints = {
    submit: { method: "POST", url: `/workbench/question-drafts/${id}/submit-review` },
    approve: { method: "PATCH", url: `/workbench/question-drafts/${id}/review`, body: { reviewStatus: "APPROVED", reviewNote: "工作台审核通过", reviewerRole: "ADMIN" } },
    reject: { method: "PATCH", url: `/workbench/question-drafts/${id}/review`, body: { reviewStatus: "REJECTED", reviewNote: "工作台审核拒绝", reviewerRole: "ADMIN" } },
    publish: { method: "POST", url: `/workbench/question-drafts/${id}/publish` },
  };
  const config = endpoints[action];
  const response = await fetch(`${apiBaseUrl()}${config.url}`, {
    method: config.method,
    headers: config.body ? { ...headers(), "Content-Type": "application/json" } : headers(),
    body: config.body ? JSON.stringify(config.body) : undefined,
  });
  if (!response.ok) {
    throw new Error(await errorMessage(response));
  }
  setStateText("draftState", "操作完成。");
  await loadDrafts();
  await loadQuotas();
}

function appendParam(params, key, value) {
  if (value) {
    params.set(key, value);
  }
}

function splitList(value) {
  if (!value) {
    return [];
  }
  return value.split(/[，,;；]/).map((item) => item.trim()).filter(Boolean);
}

function draftPageReferences(form) {
  if (!form.materialAssetId.value || !form.referencePageNumber.value) {
    return [];
  }
  return [{
    materialAssetId: form.materialAssetId.value,
    extractionCandidateId: form.extractionCandidateId.value || null,
    pageNumber: Number(form.referencePageNumber.value),
    quote: form.referenceQuote.value || null,
    referenceNote: form.referenceNote.value || null,
  }];
}

function optionCommands(form) {
  return [
    { label: "A", content: form.optionA?.value || "" },
    { label: "B", content: form.optionB?.value || "" },
    { label: "C", content: form.optionC?.value || "" },
    { label: "D", content: form.optionD?.value || "" },
  ].filter((option) => option.content.trim());
}

function label(map, value) {
  return value ? (map[value] || value) : "";
}

function formatBytes(value) {
  if (value >= 1024 * 1024) {
    return `${(value / 1024 / 1024).toFixed(1)} MB`;
  }
  if (value >= 1024) {
    return `${(value / 1024).toFixed(1)} KB`;
  }
  return `${value} B`;
}

function escapeHtml(value) {
  return String(value ?? "")
    .replaceAll("&", "&amp;")
    .replaceAll("<", "&lt;")
    .replaceAll(">", "&gt;")
    .replaceAll('"', "&quot;")
    .replaceAll("'", "&#039;");
}

async function errorMessage(response) {
  try {
    const body = await response.json();
    return body.message || response.statusText;
  } catch {
    return response.statusText;
  }
}

function handleAsync(fn) {
  return (...args) => fn(...args).catch((error) => {
    setStateText("authState", error.message, true);
    setStateText("uploadState", error.message, true);
    setStateText("scanState", error.message, true);
    setStateText("auditState", error.message, true);
    setStateText("extractState", error.message, true);
    setStateText("candidateReviewState", error.message, true);
    setStateText("batchDraftState", error.message, true);
    setStateText("attachmentState", error.message, true);
    setStateText("draftState", error.message, true);
  });
}

$("loginForm").addEventListener("submit", handleAsync(login));
$("uploadForm").addEventListener("submit", handleAsync(uploadMaterial));
$("scanForm").addEventListener("submit", handleAsync(scanLocalMaterials));
$("auditForm").addEventListener("submit", handleAsync(createAudit));
$("extractForm").addEventListener("submit", handleAsync(extractCandidates));
$("runOcrButton").addEventListener("click", handleAsync(runCandidateOcr));
$("candidateReviewForm").addEventListener("submit", handleAsync(reviewCandidate));
$("batchDraftForm").addEventListener("submit", handleAsync(batchCreateDrafts));
$("attachmentForm").addEventListener("submit", handleAsync(uploadAuthorizationAttachment));
$("draftForm").addEventListener("submit", handleAsync(createDraft));
$("refreshButton").addEventListener("click", handleAsync(loadAssets));
$("quotaButton").addEventListener("click", handleAsync(loadQuotas));
$("draftRefreshButton").addEventListener("click", handleAsync(loadDrafts));
$("keyword").addEventListener("input", handleAsync(loadAssets));
$("sourceTypeFilter").addEventListener("change", handleAsync(loadAssets));
$("subjectFilter").addEventListener("change", handleAsync(loadAssets));
$("assetList").addEventListener("click", handleAsync(openDownloadUrl));
$("draftList").addEventListener("click", handleAsync(handleDraftAction));

if (state.token) {
  handleAsync(loadCurrentUser)();
  handleAsync(loadAssets)();
  handleAsync(loadQuotas)();
  handleAsync(loadDrafts)();
}
