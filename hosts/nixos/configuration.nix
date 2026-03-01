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

  # Hyprland window manager (uses nixpkgs binary — no compilation needed)
  programs.hyprland.enable = true;

  # GPU acceleration
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

  # NVIDIA proprietary driver
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;         # Required for Wayland
    powerManagement.enable = true;     # Better suspend/resume
    open = false;                      # Proprietary (more stable than open module)
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # PRIME Sync — NVIDIA always active (RTX 4060 Max-Q), Intel handles display
  hardware.nvidia.prime = {
    sync.enable = true;
    intelBusId  = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };

  # Kernel parameters for NVIDIA + Wayland
  boot.kernelParams = [
    "nvidia-drm.modeset=1"
    "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
  ];

  # NVIDIA environment variables (Wayland/VA-API/GLX)
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME          = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME  = "nvidia";
    NVD_BACKEND                = "direct";
  };

  # Steam (needs system-level 32-bit support and udev rules)
  programs.steam.enable = true;

  # 16 GB swap file
  swapDevices = [{
    device = "/var/lib/swapfile";
    size   = 16 * 1024; # MiB
  }];

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

  # Enable sudo for wheel group
  security.sudo.enable = true;

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-emoji
    font-awesome
  ];

  # User account
  users.users.typosbro = {
    isNormalUser = true;
    initialPassword = "5454";
    description = "typosbro";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "adbusers" ];
    shell = pkgs.fish;
  };

  # SSH key agent
  programs.ssh.startAgent = true;

  # Fish shell (user config & aliases managed by home-manager)
  programs.fish.enable = true;

  # Android (ADB + fastboot with udev rules)
  programs.adb.enable = true;

  # Key remapping — swap Super and CTRL so physical Super acts like macOS CMD
  # (sends CTRL to apps for copy/paste/save etc.) and physical CTRL acts
  # as the WM modifier (sends Super to Hyprland).
  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings = {
        main = {
          leftmeta = "layer(cmd)";
          rightmeta = "layer(cmd)";
          leftcontrol = "leftmeta";
          rightcontrol = "rightmeta";
        };
      };
      extraConfig = ''
        [cmd]
        a = C-a
        b = C-b
        c = C-c
        d = C-d
        e = C-e
        f = C-f
        g = C-g
        h = C-h
        i = C-i
        j = C-j
        k = C-k
        l = C-l
        m = C-m
        n = C-n
        o = C-o
        p = C-p
        q = C-q
        r = C-r
        s = C-s
        t = C-t
        u = C-u
        v = C-v
        w = C-w
        x = C-x
        y = C-y
        z = C-z
        1 = C-1
        2 = C-2
        3 = C-3
        4 = C-4
        5 = C-5
        6 = C-6
        7 = C-7
        8 = C-8
        9 = C-9
        0 = C-0
        left = home
        right = end
        up = C-home
        down = C-end
        backspace = C-backspace
        slash = C-slash
        equal = C-equal
        minus = C-minus
      '';
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Core system packages only — user apps are managed by home-manager
  environment.systemPackages = with pkgs; [
    git
    gh
    glab
    vim
    curl
    wget
    fnm
  ];

  # Enable nix flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.05";
}
