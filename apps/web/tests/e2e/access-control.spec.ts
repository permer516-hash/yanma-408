import { expect, test } from "@playwright/test";

const apiBaseUrl = process.env.E2E_API_BASE_URL ?? "http://localhost:18083/api";

async function login(page: import("@playwright/test").Page, username: string, password: string) {
  await page.goto("/login");
  await page.getByLabel("用户名").fill(username);
  await page.getByPlaceholder("请输入密码").fill(password);
  await page.locator("form").getByRole("button", { name: "登录", exact: true }).click();
  await expect(page.getByRole("heading", { name: "今日学习仪表盘" })).toBeVisible();
}

test("student navigation hides administration entries", async ({ page, request }) => {
  const username = `e2e_student_${Date.now()}`;
  const password = "e2e-student-408";
  const response = await request.post(`${apiBaseUrl}/auth/register`, {
    data: { username, displayName: "E2E 学生", password },
  });
  expect(response.ok()).toBeTruthy();

  await login(page, username, password);

  await expect(page.getByRole("link", { name: "题库管理", exact: true })).toHaveCount(0);
  await expect(page.getByRole("link", { name: "师生绑定", exact: true })).toHaveCount(0);
  await expect(page.getByRole("link", { name: "添加教师", exact: true })).toHaveCount(0);
});

test("administrator can open question administration", async ({ page }) => {
  await login(page, "root", "0516cyb123");

  const adminLink = page.getByRole("link", { name: "题库管理", exact: true });
  await expect(adminLink).toBeVisible();
  await adminLink.click();
  await expect(page.getByRole("heading", { name: "题库管理后台", exact: true })).toBeVisible();
});

test("administrator can inspect registered user security details", async ({ page }) => {
  await login(page, "root", "0516cyb123");

  await page.goto("/account/security");
  await expect(page.getByRole("heading", { name: "账号安全", exact: true })).toBeVisible();
  await expect(page.getByRole("heading", { name: "注册用户", exact: true })).toBeVisible();

  await page.getByRole("button", { name: /超级用户.*@root/ }).click();
  await expect(page.getByRole("heading", { name: "用户详情", exact: true })).toBeVisible();
  await expect(page.getByText("超级用户 · @root", { exact: true })).toBeVisible();
  await expect(page.getByRole("button", { name: "停用账号", exact: true })).toBeVisible();
});

test("administrator receives password reset token feedback", async ({ page }) => {
  await login(page, "root", "0516cyb123");

  await page.goto("/account/security");
  await page.getByRole("button", { name: "生成重置 token", exact: true }).click();
  await expect(page.getByText("请先填写需要重置密码的用户名。", { exact: true })).toBeVisible();

  await page.getByRole("button", { name: /超级用户.*@root/ }).click();
  await page.getByRole("button", { name: "使用此账号生成重置 token", exact: true }).click();
  await page.getByRole("button", { name: "生成重置 token", exact: true }).click();

  await expect(page.getByText("重置 token 已生成。", { exact: true })).toBeVisible();
  await expect(page.getByPlaceholder("重置 token")).not.toHaveValue("");
});
