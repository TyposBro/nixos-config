# Skills audit — 2026-04-30

Loaded user skill root: `~/.agents/skills`.

## Result

Kept 13 skills:

- `agents-sdk`
- `caveman`
- `caveman-commit`
- `caveman-compress`
- `caveman-help`
- `caveman-review`
- `cloudflare`
- `cloudflare-email-service`
- `durable-objects`
- `sandbox-sdk`
- `web-perf`
- `workers-best-practices`
- `wrangler`

Removed duplicate:

- `compress`

## Why

`compress` and `caveman-compress` had the same purpose and identical `scripts/` implementation. `caveman-compress` is better canonical name because it matches the caveman skill family and includes extra `README.md` + `SECURITY.md`.

No other exact duplicate skill implementations found.
