{ pkgs, pkgs-unstable, ... }:

{
  imports = [
    ../shared/git.nix
    ../shared/vscode.nix
    ../shared/shell.nix
    ../shared/packages.nix
    ../shared/neovim.nix
    ../shared/zed.nix
    ./apps.nix
  ];

  home.username = "typosbro";
  home.homeDirectory = "/Users/typosbro";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # AI
    pkgs-unstable.antigravity
  ];
}
