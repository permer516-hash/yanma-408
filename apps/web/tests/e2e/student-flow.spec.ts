import { expect, test } from "@playwright/test";

test("student can browse questions, open a detail, and inspect chapters", async ({ page }) => {
  await page.goto("/login");
  await page.getByLabel("用户名").fill("demo");
  await page.getByPlaceholder("请输入密码").fill("yanma408");
  await page.locator("form").getByRole("button", { name: "登录", exact: true }).click();

  await expect(page.getByRole("heading", { name: "今日学习仪表盘" })).toBeVisible();

  await page.getByRole("link", { name: "题库", exact: true }).click();
  await expect(page.getByRole("heading", { name: "题库", exact: true })).toBeVisible();
  await page.getByRole("button", { name: "数据结构", exact: true }).click();
  await expect(page).toHaveURL(/subject=DATA_STRUCTURE/);

  const firstQuestion = page.locator('a[href^="/practice/"]').first();
  await expect(firstQuestion).toBeVisible();
  await firstQuestion.click();
  await expect(page.getByRole("button", { name: "提交答案" })).toBeVisible();
  await expect(page.getByRole("link", { name: "返回题库" })).toBeVisible();

  await page.goto("/chapters");
  await expect(page.getByRole("heading", { name: "章节练习" })).toBeVisible();
  await page.getByRole("button", { name: "数据结构", exact: true }).click();
  await expect(page.locator("article").first()).toBeVisible();
  await expect(page.getByText("章节数").locator("..").getByText(/^[1-9]\d*$/)).toBeVisible();
});
