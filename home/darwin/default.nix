{ ... }:

{
  imports = [
    ../shared/git.nix
    ../shared/vscode.nix
    ../shared/shell.nix
    ../shared/neovim.nix
    ./apps.nix
  ];

  home.username = "typosbro";
  home.homeDirectory = "/Users/typosbro";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;
}
