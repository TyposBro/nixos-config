{ pkgs, pkgs-unstable, zen-browser, ... }:

{
  imports = [
    ../shared/git.nix
    ../shared/vscode.nix
    ../shared/shell.nix
    ../shared/packages.nix
    ../shared/neovim.nix
    ./hyprland.nix
    ./waybar.nix
    ./apps.nix
  ];

  home.username = "typosbro";
  home.homeDirectory = "/home/typosbro";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # Browser (Linux-focused flake)
    zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default

    # AI
    pkgs-unstable.antigravity

    # VPN & Networking
    protonvpn-gui
    networkmanagerapplet

    # Audio
    easyeffects
    pamixer
    pavucontrol
    playerctl

    # Hyprland ecosystem
    hyprpaper
    hyprlock
    hypridle
    grimblast
    cliphist
    wl-clipboard
    brightnessctl
    wofi
    mako

    # Files & system
    nautilus
    polkit_gnome

    # Android
    pkgs-unstable.android-studio
  ];
}
