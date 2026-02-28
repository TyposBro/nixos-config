{ config, pkgs, hyprland, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Seoul";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Keep Xorg enabled for XWayland compatibility
  services.xserver.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Display manager — SDDM with Wayland
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  # Hyprland window manager
  programs.hyprland = {
    enable = true;
    package = hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  # GPU acceleration
  hardware.graphics.enable = true;

  # Audio via PipeWire
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Printing
  services.printing.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Secrets / keyring (used by many apps)
  services.gnome.gnome-keyring.enable = true;

  # Allow hyprlock to authenticate via PAM
  security.pam.services.hyprlock = {};

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-emoji
    font-awesome
  ];

  # User account
  users.users.ched54 = {
    isNormalUser = true;
    description = "ched54";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
    shell = pkgs.fish;
  };

  # SSH key agent
  programs.ssh.startAgent = true;

  # Fish shell with fnm
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      fnm env --use-on-cd --shell fish | source
    '';
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Firefox
  programs.firefox.enable = true;

  # Core system packages only — user apps are managed by home-manager
  environment.systemPackages = with pkgs; [
    git
    gh
    vim
    curl
    wget
    fnm
  ];

  # Enable nix flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.05";
}
