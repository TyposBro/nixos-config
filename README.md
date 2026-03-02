# typosbro's Nix Configuration

NixOS 25.05 + macOS (nix-darwin) · Flakes · GNOME / Aerospace · x86_64-linux · aarch64-darwin

## Structure

```
home/
  shared/    # git, vscode, fish, ghostty, packages — used by both platforms
  linux/     # GTK theming, Linux-only packages
  darwin/    # macOS fish aliases
hosts/
  nixos/     # NixOS system config (GDM + GNOME)
  macbook/   # nix-darwin system config (Aerospace tiling WM)
```

## Packages

| Category | Linux | macOS |
|---|---|---|
| Desktop | GNOME | Aerospace |
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
  run nixpkgs#git -- clone https://github.com/TyposBro/nixos-config.git ~/nixos-config

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

### Delete old builds

```bash
ngc    # delete all old generations (sudo nix-collect-garbage -d)
nopt   # deduplicate the store (sudo nix-store --optimise)
```

## macOS (nix-darwin)

### Bootstrap on a fresh Mac

```bash
# 1. Install Nix (Determinate Systems installer recommended)
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

# 2. Clone the repo
git clone https://github.com/TyposBro/nixos-config.git ~/nixos-config

# 3. Apply
cd ~/nixos-config
nix run nix-darwin -- switch --flake .#macbook
```

> If on an Intel Mac, change `system = "aarch64-darwin"` to `"x86_64-darwin"` in `flake.nix` first.
> If your macOS username differs from `typosbro`, update `users.users` in `hosts/macbook/configuration.nix`.

### macOS GUI apps (Homebrew)

Some GUI apps are broken/unavailable in nixpkgs on macOS and are installed via Homebrew casks instead:

```bash
brew install --cask ghostty discord spotify telegram bitwarden qbittorrent android-studio zen-browser
```

### Rebuild / update

```bash
nr   # rebuild (alias)
nru  # flake update + rebuild
```

### Keybindings (Aerospace, CMD modifier — mirrors Hyprland)

| Binding | Action |
|---|---|
| `CMD + Enter` | Terminal (Ghostty) |
| `CMD + SHIFT + Enter` | Zen Browser |
| `CMD + Q` | Close window |
| `CMD + F` | Fullscreen |
| `CMD + SHIFT + T` | Toggle float/tile |
| `CMD + /` | Toggle split direction |
| `CMD + H/J/K/L` | Focus left/down/up/right |
| `CMD + Arrows` | Focus left/down/up/right |
| `CMD + SHIFT + H/J/K/L` | Move window |
| `CMD + SHIFT + Arrows` | Move window |
| `CMD + 1–9` | Switch workspace |
| `CMD + SHIFT + 1–9` | Move window to workspace |
| `CMD + CTRL + arrows` | Resize window |

### Text editing remaps (macOS only)

Since `CMD + Arrow` is used by AeroSpace, text navigation is remapped to `CTRL + Arrow` across native apps, VS Code, and Ghostty:

| Binding | Action |
|---|---|
| `CTRL + Left/Right` | Beginning/end of line |
| `CTRL + Up/Down` | Beginning/end of document |
| `CTRL + SHIFT + Arrow` | Same with selection |

## Mirrors

| Host | URL |
|---|---|
| GitHub | https://github.com/TyposBro/nixos-config |
| GitLab | https://gitlab.com/typosbro/nixos-config |
