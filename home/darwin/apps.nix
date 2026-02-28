{ ... }:

{
  # macOS-specific fish aliases
  programs.fish.shellAliases = {
    nr  = "darwin-rebuild switch --flake ~/nixos-config#macbook";
    nru = "cd ~/nixos-config && nix flake update && darwin-rebuild switch --flake ~/nixos-config#macbook";
  };
}
