# typosbro's NixOS Configuration

NixOS 25.05 · Flakes · GNOME · x86_64-linux

## Packages

| Category | Packages |
|---|---|
| Dev | `git`, `gh`, `android-studio`, `postman` |
| Editors | `vim`, `vscode` |
| AI | `claude-code`, `antigravity` |
| Terminals | `kitty`, `ghostty` |
| Browsers | `firefox`, `zen-browser` (flake) |
| Notes | `obsidian` |
| Communication | `telegram-desktop` |
| Media | `spotify` |
| Networking | `curl`, `wget`, `protonvpn-gui` |
| Torrents | `qbittorrent` |

## Apply on this machine

```bash
cd ~/nixos-config
nix flake update
sudo nixos-rebuild switch --flake ~/nixos-config#nixos
```

## Bootstrap on a fresh NixOS install

```bash
# 1. Clone the repo (flakes not required — git is in nixpkgs)
nix --extra-experimental-features "nix-command flakes" \
  run nixpkgs#git -- clone git@github.com:typosbro/nixos-config.git ~/nixos-config

# 2. Regenerate hardware config for this machine
sudo nixos-generate-config --show-hardware-config \
  > ~/nixos-config/hosts/nixos/hardware-configuration.nix

# 3. Apply
sudo nixos-rebuild switch --flake ~/nixos-config#nixos
```

> **Note:** `hardware-configuration.nix` is machine-specific (UUIDs, kernel modules, CPU).
> Always regenerate it on new hardware with `nixos-generate-config`.

## Update nixpkgs

```bash
cd ~/nixos-config
nix flake update
sudo nixos-rebuild switch --flake ~/nixos-config#nixos
```
