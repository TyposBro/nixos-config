# Kubuntu setup

Mirror of `mac/setup.sh` for Kubuntu 24.04 (noble).

## Fresh install

```bash
git clone https://github.com/TyposBro/nixos-config.git ~/nixos-config
~/nixos-config/linux/kubuntu/setup.sh --clean
```

Runs every step: apt install, third-party repos, Ghostty, Zen Browser (Flatpak), fonts, starship, fnm, bun, rustup, deno, lazygit, glab, cloudflared, awscli, gcloud, VS Code, Brave, Docker, ProtonVPN, snap apps (Spotify/Discord/Postman/Obsidian/Android Studio/ngrok), Bitwarden (Flatpak), Claude Code, Codex CLI, tectonic, configs, git config, fish theme, SSH key + GitHub/GitLab key upload, fish as default shell, Ghostty as KDE default terminal.

## Update / re-run

```bash
~/nixos-config/linux/kubuntu/setup.sh
```

Skips already-done steps. Markers live in `~/.local/state/nixos-config-kubuntu/`.

## Force re-run one step

```bash
rm ~/.local/state/nixos-config-kubuntu/<step>
~/nixos-config/linux/kubuntu/setup.sh
```

Step names: `apt`, `flathub`, `ghostty`, `zen`, `fonts-nerd`, `starship`, `fnm`, `bun`, `rust`, `deno`, `lazygit`, `glab`, `cloudflared`, `awscli`, `gcloud`, `vscode`, `brave`, `docker`, `protonvpn`, `snap-apps`, `bitwarden`, `claude-code`, `codex`, `tectonic`, `configs`, `git-config`, `fish-theme`, `ssh-key`, `gh-ssh`, `glab-ssh`, `kde-terminal`.

## After install

Log out and back in for: docker group, default shell change.

## What's skipped vs Mac/NixOS

macOS-only (skipped): karabiner-elements, raycast, alt-tab, iina, au-lab, eqmac, t3-code, github-desktop cask.
No Linux build (skipped): antigravity (Google).
Use Linux equivalent: Konsole/Ghostty replaces iTerm; krunner/rofi replaces Raycast.
