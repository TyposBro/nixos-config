{ pkgs, pkgs-unstable, ... }:

{
  imports = [
    ../shared/git.nix
    ../shared/vscode.nix
    ../shared/shell.nix
    ../shared/packages.nix
    ./apps.nix
  ];

  home.username = "ched54";
  home.homeDirectory = "/Users/ched54";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # AI
    pkgs-unstable.antigravity
  ];
}
