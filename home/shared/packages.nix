{ pkgs, lib, ... }:

let
  isDarwin = pkgs.stdenv.isDarwin;
in
{
  home.packages = with pkgs; [
    # Editor (vscode managed by programs.vscode in vscode.nix)
    claude-code          # from overlay — always latest

    # Dev tools
    postman
    cocoapods
    deno
    gradle
    python3
    ruby
    git-lfs
    git-filter-repo

    # Notes
    obsidian

    # React Native
    watchman
    nodePackages.typescript
    nodePackages.typescript-language-server

    # Media
    ffmpeg
    mpv
    yt-dlp
    tesseract

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
    telegram-desktop
    qbittorrent
  ] ++ lib.optionals (!isDarwin) [
    # Unavailable on macOS in nixpkgs 25.05
    ghostty
    discord
    bitwarden-desktop
    spotify
  ];
}
