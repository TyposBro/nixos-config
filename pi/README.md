# Pi setup

Reproducible pi coding-agent setup for Kubuntu + macOS.

Managed:

- `agent/settings.json` — global pi settings/packages
- `skills/` — global `~/.agents/skills` without duplicates
- `setup.sh` — installs pi CLI and syncs settings/skills

Not managed:

- `~/.pi/agent/auth.json` — provider/OAuth secrets
- `~/.pi/agent/sessions/` — local session history
- `~/.pi/agent/taskplane/` — runtime task state

## Restore

```bash
~/config/pi/setup.sh
```

Clean marker + rerun install step:

```bash
~/config/pi/setup.sh --clean
```

## Current audit

Removed duplicate skill:

- `compress` duplicated `caveman-compress` purpose/scripts.
- Kept `caveman-compress` because name matches trigger family and has README/SECURITY.

Backups:

- `pi/backups/<timestamp>/` contains pre-clean snapshot of non-secret settings + skills.
