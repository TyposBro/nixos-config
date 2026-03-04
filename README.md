# typosbro's Nix Configuration

NixOS 25.11 + macOS (nix-darwin) · Flakes · GNOME · x86_64-linux · aarch64-darwin

## Structure

```
home/
  shared/    # git, neovim, vscode, fish, ghostty, starship, packages
  linux/     # GTK theming, rofi, GNOME keybindings, Linux-only packages
  darwin/    # macOS fish aliases, Ghostty overrides
hosts/
  nixos/     # NixOS system config (GDM + GNOME)
  macbook/   # nix-darwin system config + declarative Homebrew
```

## Packages

| Category | Linux | macOS |
|---|---|---|
| Desktop | GNOME | macOS default |
| Terminal | Ghostty | Ghostty (Homebrew) |
| Shell | Fish + Starship | Fish + Starship |
| Browser | Zen Browser | Zen, Brave (Homebrew) |
| Editors | VS Code, Neovim | VS Code, Neovim |
| Launcher | Rofi | Raycast (Homebrew) |
| AI | `claude-code`, `antigravity` | `claude-code`, `antigravity` |
| Dev | `git`, `gh`, `glab`, `postman`, `fnm`, `deno` | `git`, `gh`, `glab`, `postman`, `fnm`, `deno` |
| Notes | Obsidian | Obsidian |
| Communication | Telegram, Discord, Bitwarden | Telegram, Discord, Bitwarden (Homebrew) |
| Media | Spotify, mpv, EasyEffects | Spotify (Homebrew), mpv, iina (Homebrew) |
| VPN | ProtonVPN | ProtonVPN, Windscribe (Homebrew) |
| Torrents | qBittorrent | qBittorrent |
| Utils | `btop`, `htop`, `jq`, `fzf`, `lazygit`, `tmux` | `btop`, `htop`, `jq`, `fzf`, `lazygit`, `tmux` |

### Neovim IDE

Fully configured via home-manager with:
- **LSP**: TypeScript, Tailwind CSS, Lua, Nix, Python, ESLint
- **Completion**: nvim-cmp + LuaSnip + friendly-snippets
- **Treesitter**: 15 parsers (tsx, typescript, javascript, json, lua, nix, html, css, etc.)
- **Formatting**: conform.nvim (prettierd, stylua)
- **Linting**: nvim-lint (eslint_d)
- **UI**: lualine, bufferline, gitsigns, indent-blankline, which-key, catppuccin

### VS Code

Declarative extensions via nixpkgs (`mutableExtensionsDir = false`). Vim keybindings with `<Space>` leader.

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
| `Super + Space` | Rofi app launcher |
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

GUI apps not in nixpkgs are managed declaratively via `homebrew` in `configuration.nix`:

```
brave-browser, zen, discord, spotify, android-studio, docker-desktop,
github, claude, alt-tab, raycast, obs, eqmac, iina, kdenlive, lastfm,
protonvpn, windscribe, bitwarden, ghostty, karabiner-elements, ngrok, au-lab
```

Homebrew casks auto-install on rebuild. `cleanup = "zap"` removes anything not declared.

### Rebuild / update

```bash
nr   # rebuild (alias)
nru  # flake update + rebuild
```

## Mirrors

| Host | URL |
|---|---|
| GitHub | https://github.com/TyposBro/nixos-config |
| GitLab | https://gitlab.com/typosbro/nixos-config |
