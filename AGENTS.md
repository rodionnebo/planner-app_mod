# Agent Guidelines for Planner App

This document provides essential information for AI agents working in the `planner-app` repository to ensure efficient and error-free operation. Focus on these points to avoid common pitfalls.

## 🚀 Key Commands

-   **Install Dependencies:** `npm install`
-   **Start Development Server:** `npm run dev`
-   **Build for Production:** `npm run build`
-   **Run Unit Tests (Vitest):** `npm test`
-   **Run E2E Tests (Playwright):** `npx playwright test` (Optional, requires Playwright setup)
-   **Lint Code:** `npm run lint`
-   **Format Code:** `npm run format`

## 📁 Project Structure

-   `src/`: Contains the main application source code (React components, utilities).
-   `supabase_setup.sql`: Database schema and RLS policies for Supabase. This file is crucial for understanding the data model and security rules.
-   `dist/`: Build output directory for production.

## 🛠 Toolchain & Framework Quirks

-   **Frontend:** React with Vite.
-   **State Management:** No explicit global state management library is evident, likely handled component-wise or via React Context.
-   **Styling:** Custom CSS or TailwindCSS (not explicitly mentioned but implied by minimal styling setup in `package.json` dev dependencies). Review existing components for style patterns.
-   **Database:** Supabase for backend and authentication.
    -   **RLS:** Row Level Security is enabled on the `tasks` table, restricting users to their own data. All data operations must respect `auth.uid()`.
    -   **Atomic Upserts:** Application uses atomic upserts with Supabase for cloud synchronization.
-   **AI Integration:** Optional Anthropic API for AI suggestions, configured via `VITE_ANTHROPIC_API_KEY`.
-   **Environment Variables:**
    -   `VITE_SUPABASE_URL`
    -   `VITE_SUPABASE_ANON_KEY`
    -   `VITE_ANTHROPIC_API_KEY` (optional)
    These are loaded via `.env` and prefixed with `VITE_` for client-side exposure.

## ✅ Testing Strategy

-   **Unit Tests:** Handled by Vitest (`npm test`). Tests are expected to reside near the code they test or in a `__tests__` directory.
-   **E2E Tests:** Playwright is mentioned as optional (`npx playwright test`). If E2E tests exist, they will be in an `e2e/` directory or similar.

## ⛔ Boundaries & Conventions

-   **Database Schema:** Do not modify `supabase_setup.sql` or Supabase schema without explicit review. RLS policies are critical.
-   **Dependencies:** Avoid adding new major dependencies without checking `package.json` for existing alternatives and confirming with the user.
-   **UI:** Adhere to the "True Black" UI aesthetic. Review existing components in `src/components` for styling and structural patterns.
-   **Data Synchronization:** Any new feature involving data persistence must integrate with Supabase, respecting RLS and atomic upsert patterns.
-   **No Hardcoded Secrets:** Never hardcode API keys or sensitive information directly in the code. Use environment variables.
