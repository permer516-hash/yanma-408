import { expect, test } from "@playwright/test";

test("章节练习使用完整题目列表构建全部章节", async ({ page }) => {
  const questions = [
    {
      id: "q1",
      subjectCode: "DATA_STRUCTURE",
      subjectName: "数据结构",
      chapterName: "绪论",
      difficulty: "BASIC",
      score: 2,
      knowledgePoints: ["基本概念"],
    },
    {
      id: "q2",
      subjectCode: "DATA_STRUCTURE",
      subjectName: "数据结构",
      chapterName: "线性表",
      difficulty: "MEDIUM",
      score: 2,
      knowledgePoints: ["顺序表"],
    },
    {
      id: "q3",
      subjectCode: "COMPUTER_NETWORK",
      subjectName: "计算机网络",
      chapterName: "传输层",
      difficulty: "HARD",
      score: 2,
      knowledgePoints: ["TCP"],
    },
  ];

  await page.route("**/api/questions", async (route) => {
    await route.fulfill({ contentType: "application/json", json: questions });
  });
  await page.route("**/api/questions/search**", async (route) => {
    await route.fulfill({
      contentType: "application/json",
      json: { items: [questions[0]], total: questions.length, page: 0, size: 50 },
    });
  });

  await page.goto("/chapters");

  await expect(page.getByText("绪论", { exact: true })).toBeVisible();
  await expect(page.getByText("线性表", { exact: true })).toBeVisible();
  await expect(page.getByText("传输层", { exact: true })).toBeVisible();
  await expect(page.getByText("章节数").locator("..").getByText("3", { exact: true })).toBeVisible();
  await expect(page.getByText("题目数").locator("..").getByText("3", { exact: true })).toBeVisible();
});
