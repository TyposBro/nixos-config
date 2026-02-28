{ pkgs, pkgs-unstable, zen-browser, hyprland, ... }:

{
  imports = [
    ./hyprland.nix
    ./waybar.nix
    ./apps.nix
  ];

  home.username = "ched54";
  home.homeDirectory = "/home/ched54";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # Editors & IDEs
    vscode
    claude-code          # from overlay — always latest

    # Browsers
    zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default

    # AI
    pkgs-unstable.antigravity

    # Terminal
    ghostty

    # Dev tools
    postman

    # Notes
    obsidian

    # Communication
    telegram-desktop

    # Media
    spotify

    # VPN & Networking
    protonvpn-gui
    networkmanagerapplet

    # Torrents
    qbittorrent

    # Hyprland ecosystem
    hyprpaper
    hyprlock
    hypridle
    grimblast
    cliphist
    wl-clipboard
    pamixer
    pavucontrol
    playerctl
    brightnessctl
    wofi
    mako

    # Files & system
    nautilus
    polkit_gnome
    btop

    # Utils
    unzip
    jq
  ];
}
