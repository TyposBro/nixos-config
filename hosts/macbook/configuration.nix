{ pkgs, ... }:

{
  # Nix settings — Determinate Systems installer manages the Nix daemon,
  # so we disable nix-darwin's Nix management.
  nix.enable = false;
  nixpkgs.config.allowUnfree = true;

  # Required for user-specific options (dock, finder, etc.)
  system.primaryUser = "typosbro";

  # macOS system defaults
  system.defaults = {
    dock.autohide = true;
    dock.show-recents = false;
    dock.minimize-to-application = true;
    finder.AppleShowAllExtensions = true;
    finder.FXPreferredViewStyle = "Nlsv"; # list view
    NSGlobalDomain.AppleInterfaceStyle = "Dark";
    NSGlobalDomain.AppleShowAllFiles = true;
    NSGlobalDomain.KeyRepeat = 2;
    NSGlobalDomain.InitialKeyRepeat = 15;
  };

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-emoji
    font-awesome
  ];

  # Shell
  programs.fish.enable = true;

  # Core system packages
  environment.systemPackages = with pkgs; [
    git
    gh
    glab
    vim
    curl
    wget
    fnm
  ];

  # Primary user — update username/home if different on your Mac
  users.users.typosbro = {
    home = "/Users/typosbro";
    shell = pkgs.fish;
  };

  system.stateVersion = 5;
}
