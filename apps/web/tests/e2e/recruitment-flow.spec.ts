import { expect, test } from "@playwright/test";

test("visitor can submit a diagnostic request and an administrator can view it", async ({ page }) => {
  const suffix = Date.now();
  const contactName = `E2E 诊断同学 ${suffix}`;
  const wechatContact = `e2e-recruitment-${suffix}`;

  await page.goto("/");
  await expect(page.getByRole("heading", { name: "研码408", exact: true })).toBeVisible();
  await page.getByRole("link", { name: "领取 408 学情自测并预约诊断", exact: true }).click();
  await page.getByLabel("称呼 *").fill(contactName);
  await page.getByLabel("微信号 *").fill(wechatContact);
  await page.getByLabel("当前复习阶段 *").selectOption("FIRST_ROUND");
  await page.getByLabel("数据结构").check();
  await page.getByLabel("每周可投入时间").fill("12");
  await page.getByLabel("我同意研码408仅为本次学情诊断与预约联系收集以上信息。").check();
  await page.getByRole("button", { name: "提交学情自测并预约诊断", exact: true }).click();
  await expect(page.getByText("你的学情信息已经进入诊断队列。")).toBeVisible();

  await page.goto("/login");
  await page.getByLabel("用户名").fill("root");
  await page.getByPlaceholder("请输入密码").fill("0516cyb123");
  await page.locator("form").getByRole("button", { name: "登录", exact: true }).click();
  await page.goto("/admin/recruitment-leads");
  await expect(page.getByRole("heading", { name: "招生线索", exact: true })).toBeVisible();
  await expect(page.getByText(contactName, { exact: true })).toBeVisible();
  await expect(page.getByText(wechatContact, { exact: true })).toBeVisible();
});
