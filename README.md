# typosbro's Config

NixOS 25.11 · Flakes · GNOME · x86_64-linux
macOS · Homebrew · aarch64-darwin

## Structure

```
home/
  shared/    # git, neovim, vscode, fish, ghostty, starship, packages (Linux)
  linux/     # GTK theming, rofi, GNOME keybindings, Linux-only packages
hosts/
  nixos/     # NixOS system config (GDM + GNOME)
mac/
  Brewfile    # all macOS packages and apps
  setup.sh    # idempotent setup — safe to re-run
  defaults.sh # macOS system settings (dock, finder, key repeat)
  config/     # fish, ghostty, starship dotfiles
```

## macOS

### Fresh install

```bash
git clone https://github.com/TyposBro/nixos-config.git ~/nixos-config
~/nixos-config/mac/setup.sh --clean
```

Runs every step: brew bundle, symlink configs, fish theme, macOS defaults, Rust toolchain, Claude Code, caveman skill, fish as default shell.

### Update / add a package

Edit `mac/Brewfile`, then:

```bash
~/nixos-config/mac/setup.sh
```

Skips already-done steps. Only `brew bundle` runs — picks up new packages.

### Force re-run one step

```bash
rm ~/.local/state/nixos-config-mac/<step>
~/nixos-config/mac/setup.sh
```

Step names: `configs`, `fish-theme`, `defaults`, `rust`, `claude-code`, `caveman`.

### What's managed

| Thing | How |
|---|---|
| Packages & apps | `mac/Brewfile` (`brew bundle`) |
| Dotfiles (fish, ghostty, starship) | `mac/config/` (symlinked to `~/.config/`) |
| macOS defaults | `mac/defaults.sh` (`defaults write`) |
| Rust toolchain | `rustup` |
| Claude Code CLI | `claude.ai/install.sh` |
| Caveman skill | `npx skills add` |

## Linux (NixOS)

### Fresh install

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

> Always regenerate `hardware-configuration.nix` on new hardware — never copy it from another machine.

### Rebuild / update

```bash
nr   # rebuild
nru  # flake update + rebuild
ngc  # delete old generations
```

### Keybindings (GNOME, Caps Lock = Super)

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
| `Super + Shift + j / k` | Move window to workspace |
| `Super + 1–9` | Switch to workspace |
| `Super + Shift + 1–9` | Move window to workspace |

### Neovim

- **LSP**: TypeScript, Tailwind CSS, Lua, Nix, Python, ESLint
- **Completion**: nvim-cmp + LuaSnip
- **Treesitter**: tsx, typescript, javascript, json, lua, nix, html, css, etc.
- **Formatting**: conform.nvim (prettierd, stylua)
- **UI**: lualine, bufferline, gitsigns, catppuccin

## Mirrors

| Host | URL |
|---|---|
| GitHub | https://github.com/TyposBro/nixos-config |
| GitLab | https://gitlab.com/typosbro/nixos-config |
