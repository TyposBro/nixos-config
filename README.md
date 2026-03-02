# typosbro's Nix Configuration

NixOS 25.05 + macOS (nix-darwin) · Flakes · GNOME / Aerospace · x86_64-linux · aarch64-darwin

## Structure

```
home/
  shared/    # git, vscode, zed, fish, ghostty, packages — used by both platforms
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
| Editors | VS Code, Zed, Neovim | VS Code, Zed, Neovim |
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

### Keybindings (GNOME, Caps Lock = Super)

Caps Lock is remapped to Super so the modifier stays on the home row.

| Binding | Action |
|---|---|
| `Super + Return` | Terminal (Ghostty) |
| `Super + Shift + Return` | Browser (Zen) |
| `Super + e` | File Manager (Nautilus) |
| `Super + q` | Close window |
| `Super + f` | Fullscreen |
| `Super + h / l` | Tile window left / right |
| `Super + j / k` | Workspace down / up |
| `Super + Shift + j / k` | Move window to workspace down / up |
| `Super + 1–9` | Switch to workspace 1–9 |
| `Super + Shift + 1–9` | Move window to workspace 1–9 |
| `Super` (tap) | GNOME Activities / app search |

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

### Keybindings (Aerospace, Caps Lock = CMD)

Caps Lock is remapped to Command so the modifier stays on the home row.

| Binding | Action |
|---|---|
| `CMD + Return` | Terminal (Ghostty) |
| `CMD + Shift + Return` | Browser (Zen) |
| `CMD + e` | Finder |
| `CMD + q` | Close window |
| `CMD + f` | Fullscreen |
| `CMD + h / j / k / l` | Focus left / down / up / right |
| `CMD + Shift + h / j / k / l` | Move window left / down / up / right |
| `CMD + 1–9` | Switch to workspace 1–9 |
| `CMD + Shift + 1–9` | Move window to workspace 1–9 |

## Mirrors

| Host | URL |
|---|---|
| GitHub | https://github.com/TyposBro/nixos-config |
| GitLab | https://gitlab.com/typosbro/nixos-config |
