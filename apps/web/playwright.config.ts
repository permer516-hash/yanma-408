import { defineConfig, devices } from "@playwright/test";
import { resolve } from "node:path";

const browserChannel = process.env.PLAYWRIGHT_CHANNEL || (process.env.CI ? undefined : "chrome");
const appDir = process.cwd();
const serverDir = resolve(appDir, "../server");
const serverPort = process.env.E2E_SERVER_PORT ?? "18083";
const webPort = process.env.E2E_WEB_PORT ?? "3100";
const apiBaseUrl = process.env.E2E_API_BASE_URL ?? `http://localhost:${serverPort}/api`;
const webBaseUrl = process.env.E2E_BASE_URL ?? `http://localhost:${webPort}`;

export default defineConfig({
  testDir: "./tests/e2e",
  timeout: 30_000,
  outputDir: "./test-results",
  use: {
    baseURL: webBaseUrl,
    screenshot: "only-on-failure",
    trace: "retain-on-failure",
  },
  webServer: [
    {
      command: "mvn spring-boot:run -Dspring-boot.run.profiles=e2e",
      cwd: serverDir,
      env: {
        ...process.env,
        APP_CORS_ALLOWED_ORIGINS: webBaseUrl,
        SERVER_PORT: serverPort,
      },
      reuseExistingServer: false,
      timeout: 120_000,
      url: `${apiBaseUrl}/health`,
    },
    {
      command: `npm run dev -- --port ${webPort}`,
      cwd: appDir,
      env: {
        ...process.env,
        NEXT_DIST_DIR: ".next-e2e",
        NEXT_PUBLIC_API_BASE_URL: apiBaseUrl,
      },
      reuseExistingServer: false,
      timeout: 120_000,
      url: `${webBaseUrl}/login`,
    },
  ],
  projects: [
    {
      name: "chromium",
      use: { ...devices["Desktop Chrome"], channel: browserChannel },
    },
  ],
});
