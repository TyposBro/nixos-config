{ pkgs, pkgs-unstable, ... }:

{
  home.packages = with pkgs; [
    # Editor (vscode managed by programs.vscode in vscode.nix)
    claude-code          # from overlay — always latest

    # Dev tools
    nodejs
    deno
    gradle
    python3
    ruby
    git-lfs
    git-filter-repo

    # Rust (toolchain managed by rustup)
    rustup

    # React Native
    bun
    pkgs-unstable.watchman
    nodePackages.typescript
    nodePackages.typescript-language-server

    # Media
    mpv
    tesseract

    # Cloud
    awscli2
    cloudflared
    google-cloud-sdk

    # CLI tools
    aria2
    cloc
    fzf
    htop
    lazygit
    rename
    tectonic
    tmux

    # Utils
    btop
    unzip
    jq

    # GUI
    postman
    obsidian
    qbittorrent
    ghostty
    discord
    bitwarden-desktop
    spotify
    telegram-desktop
  ];
}
