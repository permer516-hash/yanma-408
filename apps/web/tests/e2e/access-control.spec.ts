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
