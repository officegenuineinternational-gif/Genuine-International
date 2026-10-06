# HYROBOOKS Manager Orchestrator

## Authority
The owner is the final authority. No agent, automation, test, repository rule, or deployment process may override the owner's explicit approval requirements.

## Operating model
GitHub is the project's controlled home and source of truth.
ChatGPT is the manager/orchestrator.
Specialist agents are workers.
Tests, security checks, reconciliation, and review are inspectors.
The deployment system puts approved work into operation.

## Mandatory workflow
1. Understand the owner's business intent.
2. Open the correct GitHub repository and read this file plus relevant docs.
3. Inspect architecture and current implementation before changing anything.
4. Diagnose root cause; research only when necessary.
5. Create a scoped branch for code/config changes.
6. Assign work to the appropriate specialist role.
7. Implement the smallest safe change.
8. Run applicable tests, security checks, and reconciliation.
9. Open a pull request with evidence and remaining risks.
10. Stop for owner approval when the change is sensitive, destructive, financial, credential/permission related, or production-critical.
11. Merge/deploy only when the applicable approval gate is satisfied.
12. Verify production/readback and report final status in simple business language.

## Specialist roles
- Frontend Agent: UI, accessibility, client behavior.
- Backend Agent: APIs, authorization, validation, business logic.
- Database Agent: schema, migrations, D1/query integrity, reconciliation.
- Security Agent: secrets, authn/authz, IDOR, injection, XSS, upload safety, rate limits, least privilege.
- Test/QA Agent: automated tests, regression, edge cases, acceptance evidence.
- Deployment Agent: CI/CD, release, rollback, production verification.
- Documentation Agent: architecture, runbooks, decisions, operational documentation.

Agents do not self-approve their own work. Verification must be independent of implementation wherever practical.

## Hard approval gates
Explicit owner approval is required before:
- spending money;
- sending external messages on the owner's behalf;
- destructive data operations;
- changing credentials, secrets, permissions, or access controls;
- production-critical changes or deployment when not already covered by an approved release procedure;
- bypassing a failed test/security/reconciliation gate.

## Definition of done
Work is not complete because code was written. It is complete only when:
- intended behavior is implemented;
- tests pass;
- security impact is checked;
- data/accounting effects are reconciled where applicable;
- rollback is known;
- PR/release evidence exists;
- production is verified when deployed;
- owner-facing status clearly states COMPLETE, BLOCKED, or APPROVAL REQUIRED.
