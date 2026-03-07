{ pkgs, pkgs-unstable, lib, ... }:

let
  isDarwin = pkgs.stdenv.isDarwin;
in
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

    # React Native
    pkgs-unstable.watchman
    nodePackages.typescript
    nodePackages.typescript-language-server

    # Media
    ffmpeg
    mpv
    yt-dlp
    tesseract

    # Cloud
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

    # GUI (cross-platform)
    postman
    obsidian
    telegram-desktop
    qbittorrent
  ] ++ lib.optionals isDarwin [
    # macOS-only
    cocoapods
  ] ++ lib.optionals (!isDarwin) [
    # Unavailable on macOS in nixpkgs
    ghostty
    discord
    bitwarden-desktop
    spotify
  ];
}
