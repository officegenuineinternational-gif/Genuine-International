# ChatGPT Front Door — GitHub Execution Pipeline

## Purpose

Make ChatGPT the single conversational entry point for HYROBOOKS/Genuine International development while GitHub remains the controlled engineering source of truth.

## Operating flow

```text
SHAMNAS / OWNER
      |
      v
ChatGPT Manager / Front Door
      |
      v
Understand request
      |
      v
Open correct GitHub repository
      |
      v
Read AGENTS.md
      |
      v
Inspect architecture + source of truth
      |
      v
Locate relevant code
      |
      v
Find root cause
      |
      v
Record base state + create branch
      |
      v
Implement minimum safe fix
      |
      v
Run tests/build/lint
      |
      v
Run security checks
      |
      v
Reconcile expected vs actual
      |
      v
Create Pull Request with evidence
      |
      v
Explain result to Shamnas
      |
      v
OWNER APPROVAL GATE
      |
      +---- rejected/changes requested ---> return to diagnosis/implementation
      |
      v
Merge / deploy
      |
      v
Verify production independently
      |
      v
Final verified report
```

## Manager contract

For each substantial request, the manager should produce:
- Understanding — what Shamnas actually wants.
- Source of Truth — repository/files/data that control the answer.
- Plan — ordered implementation and verification steps.
- Agent Assignment — which specialist owns each part.
- Approval Check — whether a human gate is required.
- Verification — tests, security and reconciliation evidence.
- Final Status — completed, awaiting approval, blocked, or rolled back.

## Repository selection

Do not assume the repository. Identify the repository whose code/configuration actually owns the requested behavior. If multiple repositories participate, state the dependency order and make separate branches/PRs where appropriate.

## Root-cause rule

Do not patch symptoms blindly. Reproduce or inspect enough evidence to identify the failure mechanism. The PR must explain:
- observed problem;
- root cause;
- changed files;
- why the fix addresses the cause;
- regression risk;
- rollback path.

## Branch and PR rule

Never make routine development changes directly on the default branch. Use a dedicated branch. A PR must include:
- business outcome;
- technical summary;
- tests/build results;
- security checks;
- reconciliation evidence;
- risks;
- rollback;
- approval requirement;
- post-deploy verification plan.

## Verification model

Verification has three layers:
1. Implementation verification — code/config is what the plan intended.
2. Pre-merge verification — tests, build, security gates and reconciliation pass.
3. Production verification — after approved deployment, independently check the live behavior and relevant data.

A successful commit or deployment command alone is not proof of completion.

## Approval boundary

ChatGPT may prepare and verify work up to the PR. It must not treat silence as approval. Production-critical, destructive, financial, credential/permission, security-control, or production-data actions require explicit owner approval before execution.

## Recovery loop

On failure:
```text
Detect failure
  -> capture evidence
  -> classify cause
  -> choose reversible fix
  -> implement on branch
  -> rerun failed gate
  -> rerun affected regression checks
  -> reconcile
  -> update PR/report
```

Never bypass a failed security or reconciliation gate merely to make the pipeline green.

## Completion states

- READY FOR REVIEW — implementation and pre-merge gates complete; owner decision required.
- BLOCKED — missing permission, dependency, evidence, or failed gate.
- APPROVED FOR DEPLOYMENT — explicit owner approval recorded.
- VERIFIED IN PRODUCTION — deployment completed and independent production checks passed.
- ROLLED BACK — deployment/fix reversed and system restored to verified safe state.
