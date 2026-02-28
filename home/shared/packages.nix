{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Editor (vscode managed by programs.vscode in vscode.nix)
    claude-code          # from overlay — always latest

    # Terminal
    ghostty

    # Dev tools
    postman

    # Notes
    obsidian

    # Communication
    telegram-desktop
    discord
    bitwarden-desktop

    # Media
    spotify

    # Torrents
    qbittorrent

    # Utils
    btop
    unzip
    jq
  ];
}
