import { expect, test, type APIRequestContext, type Page } from "@playwright/test";

const apiBaseUrl = process.env.E2E_API_BASE_URL ?? "http://localhost:18083/api";

async function rootToken(request: APIRequestContext) {
  const response = await request.post(`${apiBaseUrl}/auth/login`, {
    data: { username: "root", password: "0516cyb123" },
  });
  expect(response.ok()).toBeTruthy();
  const body = (await response.json()) as { token: string };
  return body.token;
}

async function createAdminQuestion(request: APIRequestContext) {
  const token = await rootToken(request);
  const suffix = Date.now();
  const marker = `E2E 管理后台筛选详情 ${suffix}`;
  const response = await request.post(`${apiBaseUrl}/questions`, {
    headers: { Authorization: `Bearer ${token}` },
    data: {
      subjectCode: "DATA_STRUCTURE",
      chapterCode: "DS_TREE",
      type: "SINGLE_CHOICE",
      difficulty: "BASIC",
      stem: `${marker}：下列哪个入口用于验证题目详情？`,
      answer: "A",
      explanation: `${marker} 解析内容。`,
      source: "ORIGINAL",
      sourceYear: 2027,
      score: 2,
      stemFormat: "PLAIN_TEXT",
      stemImageUrl: null,
      options: [
        { label: "A", content: "查看题目详情" },
        { label: "B", content: "只刷新页面" },
        { label: "C", content: "隐藏答案" },
        { label: "D", content: "跳过解析" },
      ],
      knowledgePointCodes: ["DS_TREE_TRAVERSAL"],
      tags: ["e2e-admin"],
    },
  });
  expect(response.ok()).toBeTruthy();
  const question = (await response.json()) as { id: string };
  return { id: question.id, marker };
}

async function loginRoot(page: Page) {
  await page.goto("/login");
  await page.getByLabel("用户名").fill("root");
  await page.getByPlaceholder("请输入密码").fill("0516cyb123");
  await page.locator("form").getByRole("button", { name: "登录", exact: true }).click();
  await expect(page.getByRole("heading", { name: "今日学习仪表盘" })).toBeVisible();
}

test("管理员可以搜索筛选、查看详情并行内修改题目来源和难度", async ({ page, request }) => {
  const { id, marker } = await createAdminQuestion(request);
  await loginRoot(page);
  await page.goto("/admin");

  await expect(page.getByRole("heading", { name: "题库管理后台", exact: true })).toBeVisible();
  await page.getByLabel("按题目内容搜索").fill(marker);
  await expect(page).toHaveURL(/keyword=/);
  await page.getByLabel("按科目筛选").selectOption("DATA_STRUCTURE");
  await page.getByLabel("按难度筛选").selectOption("BASIC");
  await page.getByLabel("按来源筛选").selectOption("ORIGINAL");
  await expect(page).toHaveURL(/subject=DATA_STRUCTURE/);
  await expect(page).toHaveURL(/difficulty=BASIC/);
  await expect(page).toHaveURL(/source=ORIGINAL/);

  const row = page.locator(".app-row").filter({ hasText: marker }).first();
  await expect(row).toBeVisible();
  await row.getByRole("button", { name: "查看题目详情" }).click();
  const dialog = page.getByRole("dialog", { name: "题目详情" });
  await expect(dialog).toBeVisible();
  await expect(dialog.getByText(`${marker}：下列哪个入口用于验证题目详情？`)).toBeVisible();
  await expect(dialog.getByText("正确答案")).toBeVisible();
  await expect(dialog.getByText("查看题目详情", { exact: true })).toBeVisible();
  await expect(dialog.getByText(`${marker} 解析内容。`)).toBeVisible();
  await dialog.getByRole("button", { name: "关闭" }).click();
  await expect(dialog).toBeHidden();

  const rscRequests: string[] = [];
  page.on("request", (requestEvent) => {
    const url = requestEvent.url();
    if (url.includes("/_next/") && url.includes("_rsc=")) {
      rscRequests.push(url);
    }
  });

  await Promise.all([
    page.waitForResponse((response) => response.url().includes(`/admin/questions/${id}/source`) && response.request().method() === "PATCH"),
    row.getByLabel("修改题目来源").selectOption("MOCK"),
  ]);
  await expect(page.getByText("题目来源已更新。")).toBeVisible();
  await expect(row.getByLabel("修改题目来源")).toHaveValue("MOCK");

  await Promise.all([
    page.waitForResponse((response) => response.url().includes(`/admin/questions/${id}/difficulty`) && response.request().method() === "PATCH"),
    row.getByLabel("修改题目难度").selectOption("MEDIUM"),
  ]);
  await expect(page.getByText("题目难度已更新。")).toBeVisible();
  await expect(row.getByLabel("修改题目难度")).toHaveValue("MEDIUM");
  expect(rscRequests).toHaveLength(0);
});
