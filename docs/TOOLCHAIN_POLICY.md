# Genuine GitHub Agent Toolchain Policy

Last reviewed: 2026-09-29

## Purpose

Keep the minimum audited toolset that materially improves reliability, security, reproducibility, and token efficiency for Genuine International agent, browser, repository, and CI work.

## Selection gates

A tool is accepted only when all are true:

1. It closes a real capability gap.
2. Upstream is active and not archived.
3. A fixed version can be selected.
4. Release artifacts are checksum-verified where binaries are used.
5. No business credential needs to be stored in Git.
6. It does not duplicate another tool without a distinct failure class.
7. Rollback is straightforward.

## Approved baseline

| Tool | Pinned version | Purpose | Routing logic |
| --- | --- | --- | --- |
| microsoft/playwright-cli | v0.1.22 | Browser automation for coding agents | Use for repeatable browser testing/automation. Prefer the live Opera connector when an already-authenticated user session is required. |
| aquasecurity/trivy | v0.74.0 | Vulnerability, secret, license, and misconfiguration scanning | Single broad scanner to reduce overlapping security tooling. |
| rhysd/actionlint | v1.7.12 | GitHub Actions syntax/semantic/security lint | Run before trusting any workflow change. |
| zizmorcore/zizmor | v1.30.1 | GitHub Actions / CI supply-chain security analysis | Detect workflow injection, excessive permissions, credential persistence, and unsafe references. |

## Browser logic

1. Use Opera Browser Connector first when the task depends on the user's existing authenticated browser session.
2. Use Playwright CLI + Skills for repeatable tests, coding-agent browser automation, and isolated sessions.
3. Never copy Opera cookies, browser profiles, tokens, or storage state into Git.
4. Use a separate Playwright session per project.
5. Persistent Playwright sessions are permitted only when explicitly required and must remain outside version control.

## Repository-change logic

1. Read current repository state first.
2. Prefer a dedicated branch and pull request.
3. Record the base SHA before writes.
4. Do not overwrite business source-of-truth data from automation.
5. Run actionlint and zizmor on workflow changes.
6. Run Trivy before release/deployment.
7. Merge only after required checks pass and human approval is explicit.

## Security gate order

1. actionlint — workflow correctness and unsafe expressions.
2. zizmor — CI/CD and workflow security.
3. Trivy — secrets, vulnerabilities, licenses, and misconfiguration.
4. Project-native tests/build.
5. Release/deployment.

## Deferred/rejected

- Gitleaks is not in the baseline because Trivy already covers secret scanning and Gitleaks currently describes itself as feature-complete with future releases focused on security patches.
- StepSecurity Harden Runner is deferred because its free tier is primarily for public repositories on GitHub-hosted runners, while private/self-hosted coverage requires a paid tier.
- Stealth browser, credential-capture, cookie-export, session-copy, and unverified remote-control utilities are prohibited.

## Update logic

- Never use `latest` in production automation.
- Review upstream release notes before changing versions.
- Update one tool at a time.
- Run the full security gate after each update.
- Record every version and digest change in `tools/toolchain.lock.json`.
- Roll back immediately on unexplained network/file behavior or incompatible output.

## Credential rules

- No API keys, cookies, passwords, OAuth refresh tokens, private keys, browser storage state, or session files in Git.
- GitHub Actions use least-privilege `GITHUB_TOKEN` permissions.
- Prefer read-only execution until a write is explicitly required.
- Logs must not print sensitive values.
