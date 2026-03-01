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

    # Notes
    obsidian

    # Utils
    btop
    unzip
    jq
  ] ++ lib.optionals (!isDarwin) [
    # These are broken or unavailable on macOS in nixpkgs 25.05
    # Install them via Homebrew casks on macOS instead
    ghostty
    telegram-desktop
    discord
    bitwarden-desktop
    spotify
    qbittorrent
  ];
}
