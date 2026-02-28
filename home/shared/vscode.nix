{ pkgs, lib, ... }:

let
  isDarwin = pkgs.stdenv.isDarwin;
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

    # Remap Ctrl+Arrow to line/document navigation on macOS
    # (CMD+Arrow is used by AeroSpace)
    profiles.default.keybindings = lib.optionals isDarwin [
      { key = "ctrl+left";        command = "cursorHome"; }
      { key = "ctrl+right";       command = "cursorEnd"; }
      { key = "ctrl+up";          command = "cursorTop"; }
      { key = "ctrl+down";        command = "cursorBottom"; }
      { key = "ctrl+shift+left";  command = "cursorHomeSelect"; }
      { key = "ctrl+shift+right"; command = "cursorEndSelect"; }
      { key = "ctrl+shift+up";    command = "cursorTopSelect"; }
      { key = "ctrl+shift+down";  command = "cursorBottomSelect"; }
    ];
  };
}
