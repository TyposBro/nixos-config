{ ... }:

{
  # Fish shell — common config and aliases
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      fnm env --use-on-cd --shell fish | source
    '';
    shellAliases = {
      # System
      ll  = "ls -la";
      la  = "ls -la";

      # Git
      gs  = "git status";
      ga  = "git add";
      gc  = "git commit";
      gca = "git commit --amend";
      gp  = "git push";
      gpl = "git pull";
      gd  = "git diff";
      gl  = "git log --oneline --graph --decorate";

      # Nix cleanup
      ngc = "sudo nix-collect-garbage -d";
      nopt = "sudo nix-store --optimise";

      # nixos-config dir
      ncd = "cd ~/nixos-config";

      # React Native / Expo
      exs  = "npx expo start";
      exc  = "npx expo start --clear";
      expa = "npx expo run:android";
      expi = "npx expo run:ios";
    };
  };

  # Ghostty terminal (shared config — works on Linux and macOS)
  xdg.configFile."ghostty/config".text = ''
    font-family = JetBrainsMono Nerd Font
    font-size = 17
    theme = Catppuccin Mocha
    background-opacity = 0.9
    cursor-style = bar
    shell-integration = fish
    window-decoration = false
    command = /run/current-system/sw/bin/fish
  '';
}
