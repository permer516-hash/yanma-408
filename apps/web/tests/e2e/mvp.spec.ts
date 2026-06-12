import { expect, test } from "@playwright/test";

test("MVP smoke: login, study surfaces, exams, admin", async ({ page }) => {
  await page.goto("/login");
  await page.getByLabel("用户名").fill("demo");
  await page.locator('input[type="password"]').fill("yanma408");
  await page.locator("form").getByRole("button", { name: "登录" }).click();
  await expect(page.getByRole("heading", { name: "今日学习仪表盘" })).toBeVisible();

  await page.getByRole("link", { name: "题库", exact: true }).click();
  await expect(page.getByRole("heading", { name: "题库", exact: true })).toBeVisible();
  await page.getByPlaceholder("搜索题干或解析").fill("二叉树");
  await expect(page.getByText("二叉树", { exact: false }).first()).toBeVisible();

  await page.goto("/mistakes");
  await expect(page.getByRole("heading", { name: "错题本" })).toBeVisible();
  await page.getByRole("button", { name: "复习队列" }).click();
  await expect(page.getByRole("button", { name: "复习队列" })).toBeVisible();

  await page.goto("/analysis");
  await expect(page.getByRole("heading", { name: "学习分析" })).toBeVisible();
  await expect(page.getByText("四科掌握度")).toBeVisible();

  await page.goto("/exams");
  await expect(page.getByRole("heading", { name: "历年真题" })).toBeVisible();
  await expect(page.getByText("报告总览")).toBeVisible();

  await page.goto("/admin");
  await expect(page.getByRole("heading", { name: "管理后台" })).toBeVisible();
  await expect(page.getByRole("button", { name: "预校验" })).toBeVisible();

  await page.goto("/account/security");
  await expect(page.getByRole("heading", { name: "账号安全" })).toBeVisible();
  await expect(page.getByText("Token 管理")).toBeVisible();
});
