import { expect, test } from "@playwright/test";

test("question search debounces typing and syncs URL without an RSC navigation", async ({ page }) => {
  await page.goto("/question-bank");
  await expect(page.locator('a[href^="/practice/"]').first()).toBeVisible();

  const searchRequests: string[] = [];
  const rscRequests: string[] = [];
  page.on("request", (request) => {
    const url = request.url();
    if (url.includes("/api/questions/search")) {
      searchRequests.push(url);
    }
    if (url.includes("/_next/") && url.includes("_rsc=")) {
      rscRequests.push(url);
    }
  });

  await page.getByPlaceholder("搜索题干或解析").pressSequentially("二叉树", { delay: 50 });
  await expect(page).toHaveURL(/keyword=%E4%BA%8C%E5%8F%89%E6%A0%91/);
  await expect(page.locator('a[href^="/practice/"]').first()).toBeVisible();

  expect(searchRequests).toHaveLength(1);
  expect(rscRequests).toHaveLength(0);
});

test("question filters retain the previous results while the next request is pending", async ({ page }) => {
  await page.route("**/api/questions/search?**", async (route) => {
    if (route.request().url().includes("subject=OPERATING_SYSTEM")) {
      await new Promise((resolve) => setTimeout(resolve, 800));
    }
    await route.continue();
  });

  await page.goto("/question-bank");
  const firstQuestion = page.locator('a[href^="/practice/"]').first();
  await expect(firstQuestion).toBeVisible();
  const firstQuestionText = await firstQuestion.locator("p").first().innerText();

  await page.getByRole("button", { name: "操作系统", exact: true }).click();

  await expect(page.getByText("正在更新题目...")).toBeVisible();
  await expect(page.getByText(firstQuestionText, { exact: true })).toBeVisible();
  await expect(page).toHaveURL(/subject=OPERATING_SYSTEM/);
  await expect(page.getByText("正在更新题目...")).toBeHidden();
});
