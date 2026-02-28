# typosbro's Nix Configuration

NixOS 25.05 + macOS (nix-darwin) · Flakes · Hyprland / Aerospace · x86_64-linux · aarch64-darwin

## Structure

```
home/
  shared/    # git, vscode, fish, ghostty, packages — used by both platforms
  linux/     # Hyprland, Waybar, Mako, Wofi, Linux-only packages
  darwin/    # macOS fish aliases
hosts/
  nixos/     # NixOS system config (SDDM + Hyprland)
  macbook/   # nix-darwin system config (Aerospace tiling WM)
```

## Packages

| Category | Linux | macOS |
|---|---|---|
| WM | Hyprland + Waybar + Wofi + Mako | Aerospace |
| Terminal | Ghostty | Ghostty (Homebrew) |
| Browser | Zen Browser | — (install manually) |
| Editors | VS Code + Vim | VS Code + Vim |
| AI | `claude-code`, `antigravity` | `claude-code`, `antigravity` |
| Dev | `git`, `gh`, `postman`, `fnm` | `git`, `gh`, `postman`, `fnm` |
| Notes | Obsidian | Obsidian |
| Communication | Telegram, Discord, Bitwarden | Telegram, Discord, Bitwarden (Homebrew) |
| Media | Spotify, EasyEffects | Spotify (Homebrew) |
| VPN | ProtonVPN | — |
| Torrents | qBittorrent | qBittorrent (Homebrew) |
| Utils | `btop`, `jq`, `unzip` | `btop`, `jq`, `unzip` |

## Linux (NixOS)

### Bootstrap on a fresh install

```bash
# 1. Clone the repo
nix --extra-experimental-features "nix-command flakes" \
  run nixpkgs#git -- clone git@github.com:TyposBro/nixos-config.git ~/nixos-config

# 2. Regenerate hardware config for this machine
sudo nixos-generate-config --show-hardware-config \
  > ~/nixos-config/hosts/nixos/hardware-configuration.nix

# 3. Apply
sudo nixos-rebuild switch --flake ~/nixos-config#nixos
```

> `hardware-configuration.nix` is machine-specific (UUIDs, kernel modules, CPU).
> Always regenerate it on new hardware — never copy it from another machine.

### Rebuild / update

```bash
nr   # rebuild (alias)
nru  # flake update + rebuild
```

### Keybindings (Hyprland, ALT modifier)

| Binding | Action |
|---|---|
| `ALT + Enter` | Terminal (Ghostty) |
| `ALT + Space` | App launcher (Wofi) |
| `ALT + Q` | Close window |
| `ALT + F` | Fullscreen |
| `ALT + T` | Toggle float |
| `ALT + L` | Lock screen |
| `ALT + H/J/K/L` | Focus left/down/up/right |
| `ALT + 1–9` | Switch workspace |
| `ALT + SHIFT + 1–9` | Move window to workspace |
| `ALT + CTRL + arrows` | Resize window |
| `ALT + SHIFT + S` | Screenshot (area) |

## macOS (nix-darwin)

### Bootstrap on a fresh Mac

```bash
# 1. Install Nix (Determinate Systems installer recommended)
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

# 2. Clone the repo
git clone git@github.com:TyposBro/nixos-config.git ~/nixos-config

# 3. Apply
cd ~/nixos-config
nix run nix-darwin -- switch --flake .#macbook
```

> If on an Intel Mac, change `system = "aarch64-darwin"` to `"x86_64-darwin"` in `flake.nix` first.
> If your macOS username differs from `typosbro`, update `users.users` in `hosts/macbook/configuration.nix`.

### macOS GUI apps (Homebrew)

Some GUI apps are broken/unavailable in nixpkgs on macOS and are installed via Homebrew casks instead:

```bash
brew install --cask ghostty discord spotify telegram bitwarden qbittorrent
```

### Rebuild / update

```bash
nr   # rebuild (alias)
nru  # flake update + rebuild
```

### Keybindings (Aerospace, ALT modifier — mirrors Hyprland)

| Binding | Action |
|---|---|
| `ALT + Enter` | Terminal (Ghostty) |
| `ALT + Q` | Close window |
| `ALT + F` | Fullscreen |
| `ALT + T` | Toggle float/tile |
| `ALT + H/J/K/L` | Focus left/down/up/right |
| `ALT + 1–9` | Switch workspace |
| `ALT + SHIFT + 1–9` | Move window to workspace |
| `ALT + CTRL + arrows` | Resize window |

## Mirrors

| Host | URL |
|---|---|
| GitHub | https://github.com/TyposBro/nixos-config |
| GitLab | https://gitlab.com/typosbro/nixos-config |
