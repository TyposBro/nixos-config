{ lib, ... }:

{
  # Ensure nix-darwin and home-manager paths are available on macOS
  programs.fish.interactiveShellInit = lib.mkBefore ''
    fish_add_path --prepend /run/current-system/sw/bin ~/.nix-profile/bin
  '';

  # macOS-specific fish aliases
  programs.fish.shellAliases = {
    nr  = "sudo darwin-rebuild switch --flake ~/nixos-config#macbook";
    nru = "cd ~/nixos-config && nix flake update && sudo darwin-rebuild switch --flake ~/nixos-config#macbook";
  };

  # Ghostty macOS overrides
  xdg.configFile."ghostty/config".text = lib.mkAfter ''
    macos-titlebar-style = tabs
  '';
}
