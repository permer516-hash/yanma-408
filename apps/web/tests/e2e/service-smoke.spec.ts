import { expect, test } from "@playwright/test";

const apiBaseUrl = process.env.E2E_API_BASE_URL ?? "http://localhost:18083/api";

test("frontend and backend are reachable", async ({ page, request }) => {
  const healthResponse = await request.get(`${apiBaseUrl}/health`);
  expect(healthResponse.ok()).toBeTruthy();
  await expect(healthResponse.json()).resolves.toMatchObject({
    status: "ok",
    service: "yanma408-server",
  });

  await page.goto("/login");
  await expect(page.getByText("研码408", { exact: true })).toBeVisible();
  await expect(page.getByLabel("用户名")).toBeVisible();
  await expect(page.getByPlaceholder("请输入密码")).toBeVisible();
});
