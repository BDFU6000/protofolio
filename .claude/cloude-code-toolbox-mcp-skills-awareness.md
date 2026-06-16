# Cloude Code ToolBox — MCP & Skills awareness

_Generated: 2026-06-16T19:06:14.222Z_

## How to use this report

- **Saved copy:** This file is **`.claude/cloude-code-toolbox-mcp-skills-awareness.md`** — refreshed whenever the toolbox runs an MCP & Skills scan (including on workspace open when auto-scan is enabled). It is meant for **Claude Code workspace context** together with `CLAUDE.md` (which gets a shorter replaceable summary when auto-merge is on).
- **MCP:** Lists **configured** servers from Claude Code config (`~/.claude.json` for user scope, `.mcp.json` for project scope). Use `/mcp` in the Claude Code panel to connect servers for your session.
- **Skills:** **On-disk** folders with `SKILL.md`. Claude Code does not auto-load them; attach `SKILL.md` or paths in chat when useful.
- **Task routing:** When the user’s request matches a server’s purpose (e.g. Confluence → Confluence/Atlassian MCP), prefer that **server id** from the tables below.

---

## MCP — workspace

Workspace `mcp.json` _(folder: my_protofolio)_

- **d:\my_protofolio\.mcp.json** — _File missing_

_No active workspace servers in mcp.json._

## MCP — user profile

- **C:\Users\hp\.claude.json** — _File exists — no servers defined_

_No active user-scoped servers in mcp.json._

## Skills (local `SKILL.md` folders)

### Project-scoped

_None found (or no workspace open)._

### User-scoped

- **brand-guidelines** — `C:\Users\hp\.claude\skills\brand-guidelines`
  - Applies Anthropic's official brand colors and typography to any sort of artifact that may benefit from having Anthropic's look-and-feel. Use it when brand colors or style guidelines, visual formatting, or company design 

- **defense-in-depth** — `C:\Users\hp\.claude\skills\defense-in-depth`
  - Use when invalid data causes failures deep in execution, requiring validation at multiple system layers - validates at every layer data passes through to make bugs structurally impossible

- **figma-implement-design** — `C:\Users\hp\.claude\skills\figma-implement-design`
  - Translates Figma designs into production-ready application code with 1:1 visual fidelity. Use when implementing UI code from Figma files, when user mentions "implement design", "generate code", "implement component", pro

- **firebase-appcheck-manager** — `C:\Users\hp\.claude\skills\firebase-appcheck-manager`
  - Use when managing Firebase App Check via CLI. Covers enabling the API, registering Android/iOS attestation providers (Play Integrity, App Attest), managing SHA-256 fingerprints, enforcing services, and managing debug tok

- **firebase-auth-manager** — `C:\Users\hp\.claude\skills\firebase-auth-manager`
  - Use when managing Firebase Authentication sign-in providers, authorized domains, or auth configuration via CLI. Covers enabling Apple/Google/GitHub/Microsoft providers, listing provider status, managing authorized domain

- **firebase-flutter-setup** — `C:\Users\hp\.claude\skills\firebase-flutter-setup`
  - Set up Firebase Authentication (Google Sign-In), AdMob, and RevenueCat IAP for Flutter Android apps. Use when enabling Firebase Auth providers, configuring Google Sign-In with OAuth clients, adding AdMob ad units, or int

- **flutter-listview-viewport-gotchas** — `C:\Users\hp\.claude\skills\flutter-listview-viewport-gotchas`
  - Flutter ListView/CustomScrollView viewport recycling gotchas and debugging patterns. Use when debugging Flutter issues where widget state changes do not reflect in the UI, `didUpdateWidget` is never called, `ScrollContro

- **flutter-mobile-debugging** — `C:\Users\hp\.claude\skills\flutter-mobile-debugging`
  - Debug Flutter apps on real Android devices and iOS Simulators using Mobile MCP tools, adb, and xcrun simctl. Use when testing Flutter UI on devices, verifying widget behavior after code changes, debugging touch interacti

- **flutter-pub-get-stuck** — `C:\Users\hp\.claude\skills\flutter-pub-get-stuck`
  - Diagnose and fix flutter pub get hanging, flutter build stuck, or any Flutter CLI command that hangs with zero output on Windows. Also covers "Can't load Kernel binary Invalid SDK hash" errors. Triggers on keywords like 

- **flutter-social-login** — `C:\Users\hp\.claude\skills\flutter-social-login`
  - Flutter social login (Google + Apple Sign-In) with Firebase Auth. Use when setting up or debugging Google/Apple sign-in in Flutter apps, configuring OAuth client IDs, serverClientId, or handling platform-specific login f

- **flutter-verify** — `C:\Users\hp\.claude\skills\flutter-verify`
  - |

- **release-preflight** — `C:\Users\hp\.claude\skills\release-preflight`
  - Flutter 雙平台發版前的 pre-flight 檢查清單，確保 build number、signing、fastlane config、store metadata 都正確再開始 build

- **systematic-debugging** — `C:\Users\hp\.claude\skills\systematic-debugging`
  - Use when encountering any bug, test failure, or unexpected behavior, before proposing fixes - four-phase framework (root cause investigation, pattern analysis, hypothesis testing, implementation) that ensures understandi

- **verify-ui** — `C:\Users\hp\.claude\skills\verify-ui`
  - Verify Flutter UI matches Figma or reference design on real device. Use when doing UI work, comparing screens to Figma, checking visual fidelity, or before claiming UI is "done". Triggers on keywords like "verify ui", "c

- **visual-verdict** — `C:\Users\hp\.claude\skills\visual-verdict`
  - Structured visual QA verdict for screenshot-to-reference comparisons

---

## Suggested next steps

- **MCP:** Use this extension’s hub **MCP** tab, or `claude mcp list` in the terminal. In Claude Code, use `/mcp` to connect servers for the session.
- **Edit config:** Open `~/.claude.json` (user MCP) or `<workspace>/.mcp.json` (project MCP) via the extension commands.
- **Refresh this report:** run **Intelligence — scan MCP & Skills awareness** again after changing MCP config or adding skills.

_Report from Cloude Code ToolBox extension._
