import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "研码408",
  description: "面向计算机考研 408 的刷题、复盘与学习分析平台",
  icons: {
    icon: "/icon.svg",
  },
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="zh-CN" className="h-full antialiased">
      <body className="min-h-full flex flex-col">{children}</body>
    </html>
  );
}
