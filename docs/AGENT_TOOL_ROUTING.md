# Agent Tool Routing

## Decision tree

### Need a logged-in browser session?
Use the Opera Browser Connector when the user's existing authenticated session is the source of truth.

### Need deterministic/repeatable browser automation?
Use Playwright CLI 0.1.22 with isolated project sessions.

### Changing GitHub Actions?
Run actionlint first, then zizmor.

### Preparing a release/deployment?
Run Trivy against the repository before native build/test gates.

### Need another GitHub tool?
Do not install it by default. First check:
- capability overlap,
- upstream maintenance,
- license,
- release pinning,
- checksum/signature support,
- credential requirements,
- network behavior,
- rollback path.

Only add the tool if it improves a failure class not already covered by the baseline.

## Failure handling

- A failed security gate blocks release/deployment.
- A tool download with a checksum mismatch is deleted immediately.
- A tool update is rolled back independently; do not update the whole stack at once.
- Browser automation must not export authenticated browser state into repository files.
- Unverified external code is never run with business credentials.
