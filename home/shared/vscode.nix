{ pkgs, lib, ... }:

let
  isLinux = pkgs.stdenv.isLinux;
in
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;

    profiles.default.extensions = with pkgs.vscode-extensions; [
      # Theme
      catppuccin.catppuccin-vsc
      catppuccin.catppuccin-vsc-icons

      # Git
      eamodio.gitlens

      # Formatting & linting
      esbenp.prettier-vscode
      dbaeumer.vscode-eslint

      # Editor enhancements
      vscodevim.vim
      christian-kohler.path-intellisense
      streetsidesoftware.code-spell-checker

      # Languages
      ms-python.python
      ms-python.vscode-pylance
      bbenoist.nix
    ];

    profiles.default.userSettings = {
      # Theme
      "workbench.colorTheme" = "Catppuccin Mocha";
      "workbench.iconTheme" = "catppuccin-mocha";

      # Font
      "editor.fontFamily" = "'JetBrainsMono Nerd Font', monospace";
      "editor.fontSize" = 14;
      "editor.fontLigatures" = true;
      "editor.lineHeight" = 1.6;

      # Editor behavior
      "editor.formatOnSave" = true;
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
      "editor.tabSize" = 2;
      "editor.wordWrap" = "on";
      "editor.cursorStyle" = "line";
      "editor.cursorBlinking" = "smooth";
      "editor.smoothScrolling" = true;
      "editor.minimap.enabled" = false;

      # Terminal
      "terminal.integrated.fontFamily" = "'JetBrainsMono Nerd Font'";
      "terminal.integrated.fontSize" = 14;

      # Window
      "window.titleBarStyle" = "custom";
      "workbench.startupEditor" = "none";
      "breadcrumbs.enabled" = false;

      # Git
      "git.autofetch" = true;
      "gitlens.mode.active" = "zen";
    };

    # On Linux, keyd remaps physical CTRL to Super, so bind Super+`
    # to toggle terminal (matches physical CTRL+` like macOS)
    profiles.default.keybindings = lib.optionals isLinux [
      { key = "meta+`"; command = "workbench.action.terminal.toggleTerminal"; }
    ];
  };
}
