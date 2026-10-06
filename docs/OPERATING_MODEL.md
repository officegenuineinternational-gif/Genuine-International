# HYROBOOKS Controlled Development Operating Model

## Control chain
OWNER / SHAMNAS
→ ChatGPT Manager Orchestrator
→ GitHub controlled repository
→ Specialist agents
→ Tests + security + reconciliation
→ Pull request
→ Owner approval gate
→ Merge / deployment
→ Production verification
→ Owner report

## Principle
GitHub records the durable truth: code, documentation, agent instructions, tests, workflows, decisions, and change history. ChatGPT coordinates work against that truth rather than treating chat history as the codebase.

## Manager responsibilities
The manager translates business language into an executable plan, retrieves repository context, selects workers, limits scope, checks dependencies and approval gates, verifies evidence, handles failure safely, and reports results.

## Worker contract
Every worker receives: goal, source files, constraints, allowed changes, expected output, tests, security considerations, and completion evidence. Workers return artifacts and evidence; they do not declare production success without verification.

## Inspector contract
A change must be inspected using the checks relevant to its risk: unit/integration/e2e tests, build/lint/type checks, authorization and input validation, secret scanning, dependency review, accounting/data reconciliation, idempotency/readback, and rollback readiness.

## Deployment contract
Deployment is downstream of verification and approval. A deployment must identify the exact commit, target environment, required approval, rollback method, and post-deployment verification. Failed verification stops progression.

## Failure behavior
Never hide or work around a failed gate. Diagnose root cause, preserve evidence, roll back or stop safely, repair on the branch, rerun checks, and escalate to the owner when approval or business judgment is required.
