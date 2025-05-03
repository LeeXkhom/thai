/** @type {import('tailwindcss').Config} */
module.exports = {
  darkMode: ["class"],
  content: [
    "./pages/**/*.{js,jsx}",
    "./components/**/*.{js,jsx}",
    "./app/**/*.{js,jsx}",
    "./src/**/*.{js,jsx}",
    "*.{js,ts,jsx,tsx,mdx}",
  ],
  theme: {
    container: {
      center: true,
      padding: "2rem",
      screens: {
        "2xl": "1400px",
      },
    },
    extend: {
      fontFamily: {
        heading: ["var(--font-prompt)", "sans-serif"], // ใช้ Prompt สำหรับหัวข้อ
        body: ["var(--font-sarabun)", "sans-serif"], // ใช้ Sarabun สำหรับเนื้อหา
        sans: ["var(--font-inter)", "var(--font-sarabun)", "sans-serif"],
      },
      colors: {
        // โทนสีใหม่ที่เข้ากับภาพพื้นหลังชายหาด
        primary: {
          DEFAULT: "#1E6091", // น้ำเงินเข้ม
          50: "#F0F7FC",
          100: "#D6EAF8",
          200: "#ADD5F1",
          300: "#85C1E9",
          400: "#5DACE2",
          500: "#3498DB",
          600: "#2980B9",
          700: "#1E6091",
          800: "#154360",
          900: "#0B2430",
        },
        secondary: {
          DEFAULT: "#117864", // เขียวเข้ม-ฟ้า
          50: "#E8F8F5",
          100: "#D1F2EB",
          200: "#A3E4D7",
          300: "#76D7C4",
          400: "#48C9B0",
          500: "#1ABC9C",
          600: "#17A589",
          700: "#117864",
          800: "#0E6655",
          900: "#0B5345",
        },
        accent: {
          DEFAULT: "#F39C12", // ส้ม-ทอง
          50: "#FEF9E7",
          100: "#FCF3CF",
          200: "#F9E79F",
          300: "#F7D770",
          400: "#F4C741",
          500: "#F1C40F",
          600: "#D4AC0D",
          700: "#F39C12",
          800: "#D68910",
          900: "#B9770E",
        },
        background: {
          DEFAULT: "#F7F9FC", // เทาอ่อน-ขาว
          50: "#FFFFFF",
          100: "#F7F9FC",
          200: "#EDF2F7",
          300: "#E2E8F0",
          400: "#CBD5E0",
          500: "#A0AEC0",
          600: "#718096",
          700: "#4A5568",
          800: "#2D3748",
          900: "#1A202C",
        },
        border: "hsl(var(--border))",
        input: "hsl(var(--input))",
        ring: "hsl(var(--ring))",
        foreground: "hsl(var(--foreground))",
      },
      borderRadius: {
        lg: "var(--radius)",
        md: "calc(var(--radius) - 2px)",
        sm: "calc(var(--radius) - 4px)",
      },
      keyframes: {
        "accordion-down": {
          from: { height: 0 },
          to: { height: "var(--radix-accordion-content-height)" },
        },
        "accordion-up": {
          from: { height: "var(--radix-accordion-content-height)" },
          to: { height: 0 },
        },
      },
      animation: {
        "accordion-down": "accordion-down 0.2s ease-out",
        "accordion-up": "accordion-up 0.2s ease-out",
      },
    },
  },
  plugins: [require("tailwindcss-animate")],
}
