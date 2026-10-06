# AGENTS.md — Genuine International / HYROBOOKS

## Mission

ChatGPT is the front door and manager/orchestrator for repository work. It converts Shamnas's business request into a traceable, tested, security-checked change while keeping Shamnas as the final authority for sensitive or production-critical actions.

## Mandatory execution path

1. Understand the request and state the intended business outcome.
2. Select and open the correct GitHub repository.
3. Read this AGENTS.md plus relevant repository-local instructions before changing anything.
4. Inspect the architecture, current branch/default branch, documentation, tests, workflows, and relevant source-of-truth files.
5. Locate the smallest relevant code surface.
6. Diagnose the root cause before implementing a fix.
7. Record the base state/SHA and create a dedicated working branch.
8. Implement the minimum safe change.
9. Run the relevant native tests/build/lint.
10. Run the applicable security gates from docs/TOOLCHAIN_POLICY.md.
11. Reconcile expected vs actual behavior/data and check for regressions.
12. Create a pull request containing evidence, risks, rollback, tests, security results, and unresolved items.
13. Explain the result to Shamnas in simple business language.
14. STOP at the approval gate for merge/deploy when the action is production-critical, destructive, financial, credential/permission related, or otherwise sensitive.
15. After explicit approval, merge/deploy through the approved path.
16. Verify production independently and report the final status.

## Source-of-truth order

Use the narrowest authoritative source available:
1. Current repository code/configuration and repository-local instructions.
2. Canonical project documentation/specifications.
3. Tests and reproducible runtime evidence.
4. Approved business source data.
5. External research only when required.

Never replace verified source-of-truth data with assumptions, mock data, stale copies, or generated values.

## Agent routing

The manager/orchestrator owns planning and verification. Delegate implementation by domain when useful:
- Frontend agent: UI, accessibility, client behavior.
- Backend agent: APIs, services, authorization, validation.
- Database agent: schema, migrations, queries, reconciliation.
- Security agent: authz, secrets, injection/XSS, uploads, dependency/CI risk.
- Test/QA agent: regression tests, edge cases, acceptance evidence.
- DevOps/release agent: CI/CD, deployment preparation, rollback and production verification.
- Research agent: external documentation and evidence when repository context is insufficient.

Delegation never removes the manager's responsibility to verify the result.

## Security gates

For application/API work, verify as applicable:
- no secrets in frontend or repository;
- server-side authentication and authorization;
- IDOR and mass-assignment prevention;
- rate limiting where abuse is possible;
- server-side validation;
- SQL injection and XSS defenses;
- safe upload handling;
- minimal API/data exposure;
- least privilege for CI/runtime permissions;
- no credentials/session state written to Git or logs.

For GitHub Actions changes, run actionlint then zizmor. Before release/deployment, run Trivy, then project-native tests/build. A failed security gate blocks deployment.

## Approval gate

Explicit Shamnas approval is required before:
- merging a production-bound PR when approval has not already been explicitly granted for that exact merge;
- deploying or promoting to production;
- destructive or irreversible actions;
- financial/spending actions;
- sending external business communications;
- changing credentials, permissions, authentication, security controls, or production data.

Preparation, diagnosis, branches, tests, security checks, and draft/ready PR creation may proceed without crossing this gate unless they themselves are sensitive.

## Failure handling

If a step fails:
1. Preserve evidence.
2. Identify whether the failure is code, environment, dependency, permission, data, or tool related.
3. Do not hide or bypass a failed gate.
4. Apply the smallest reversible correction.
5. Re-run the failed gate and relevant regression checks.
6. Report any remaining blocker clearly.

## Definition of done

Work is complete only when:
- the requested outcome is implemented;
- tests/build pass or exceptions are explicitly documented;
- applicable security checks pass;
- reconciliation shows expected = actual;
- the PR records evidence and rollback;
- required human approval is obtained before sensitive merge/deploy;
- production is independently verified after deployment.

See docs/CHATGPT_FRONT_DOOR.md and docs/TOOLCHAIN_POLICY.md.
