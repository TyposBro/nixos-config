{ config, pkgs, ... }:

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

  # Desktop environment (GNOME)
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Printing
  services.printing.enable = true;

  # Audio via PipeWire
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # User account
  users.users.ched54 = {
    isNormalUser = true;
    description = "ched54";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
  };

  # SSH key agent (used by git/GitHub)
  programs.ssh.startAgent = true;

  # Fish shell
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      # fnm — Node version manager (auto-switches on cd with .nvmrc support)
      fnm env --use-on-cd --shell fish | source
    '';
  };

  # Allow unfree packages (VS Code, etc.)
  nixpkgs.config.allowUnfree = true;

  # System packages
  environment.systemPackages = with pkgs; [
    # Version control & GitHub
    git
    gh

    # Editors & IDEs
    vim
    vscode
    android-studio

    # AI
    claude-code

    # Terminal emulators
    kitty
    ghostty

    # Browsers (zen-browser is added via flake in flake.nix)

    # Notes
    obsidian

    # Communication
    telegram-desktop

    # Media
    spotify

    # Networking & VPN
    curl
    wget
    protonvpn-gui

    # Torrents
    qbittorrent

    # API development
    postman

    # Node version manager
    fnm
  ];

  # Firefox
  programs.firefox.enable = true;

  # Enable nix flakes and new CLI
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.05";
}
