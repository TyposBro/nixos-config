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

  # Caps Lock → Left Command (home-row modifier, matches Linux Caps→Super)
  system.keyboard = {
    enableKeyMapping = true;
    userKeyMapping = [
      {
        HIDKeyboardModifierMappingSrc = 30064771129; # 0x700000039 Caps Lock
        HIDKeyboardModifierMappingDst = 30064771299; # 0x7000000E3 Left Command
      }
    ];
  };

  # Aerospace tiling window manager — vim-style keybindings
  services.aerospace = {
    enable = true;
    settings = {
      default-root-container-layout = "tiles";
      default-root-container-orientation = "auto";

      gaps = {
        inner.horizontal = 0;
        inner.vertical = 0;
        outer.top = 0;
        outer.bottom = 0;
        outer.left = 0;
        outer.right = 0;
      };

      key-mapping.preset = "qwerty";

      mode.main.binding = {
        # Apps
        "cmd-enter"       = "exec-and-forget ghostty";
        "cmd-shift-enter" = ''exec-and-forget open -a "Zen Browser"'';
        "cmd-e"           = "exec-and-forget open -a Finder";

        # Window management
        "cmd-q" = "close";
        "cmd-f" = "fullscreen";

        # Focus — vim keys
        "cmd-h" = "focus left";
        "cmd-j" = "focus down";
        "cmd-k" = "focus up";
        "cmd-l" = "focus right";

        # Move windows
        "cmd-shift-h" = "move left";
        "cmd-shift-j" = "move down";
        "cmd-shift-k" = "move up";
        "cmd-shift-l" = "move right";

        # Workspaces
        "cmd-1" = "workspace 1";
        "cmd-2" = "workspace 2";
        "cmd-3" = "workspace 3";
        "cmd-4" = "workspace 4";
        "cmd-5" = "workspace 5";
        "cmd-6" = "workspace 6";
        "cmd-7" = "workspace 7";
        "cmd-8" = "workspace 8";
        "cmd-9" = "workspace 9";

        # Move window to workspace
        "cmd-shift-1" = "move-node-to-workspace 1";
        "cmd-shift-2" = "move-node-to-workspace 2";
        "cmd-shift-3" = "move-node-to-workspace 3";
        "cmd-shift-4" = "move-node-to-workspace 4";
        "cmd-shift-5" = "move-node-to-workspace 5";
        "cmd-shift-6" = "move-node-to-workspace 6";
        "cmd-shift-7" = "move-node-to-workspace 7";
        "cmd-shift-8" = "move-node-to-workspace 8";
        "cmd-shift-9" = "move-node-to-workspace 9";
      };
    };
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
