{ pkgs, ... }:

{
  # Nix settings — Determinate Systems installer manages the Nix daemon,
  # so we disable nix-darwin's Nix management.
  nix.enable = false;
  nixpkgs.config.allowUnfree = true;

  # Required for user-specific options (dock, finder, aerospace, etc.)
  system.primaryUser = "typosbro";

  # macOS system defaults (tiling-WM-friendly)
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

  # Aerospace tiling window manager
  # Mirrors Hyprland keybindings: ALT as modifier, workspaces 1-10, vim keys
  services.aerospace = {
    enable = true;
    settings = {
      # start-at-login managed by launchd, not aerospace itself
      default-root-container-layout = "tiles";
      default-root-container-orientation = "auto";
      accordion-padding = 30;

      gaps = {
        inner.horizontal = 10;
        inner.vertical = 10;
        outer.top = 10;
        outer.bottom = 10;
        outer.left = 10;
        outer.right = 10;
      };

      key-mapping.preset = "qwerty";

      mode.main.binding = {
        # Apps
        "alt-enter" = "exec-and-forget ghostty";

        # Window management
        "alt-q"           = "close";
        "alt-f"           = "fullscreen";
        "alt-t"           = "layout floating tiling";

        # Focus — arrow keys
        "alt-left"  = "focus left";
        "alt-right" = "focus right";
        "alt-up"    = "focus up";
        "alt-down"  = "focus down";

        # Focus — vim keys
        "alt-h" = "focus left";
        "alt-j" = "focus down";
        "alt-k" = "focus up";
        "alt-l" = "focus right";

        # Move windows
        "alt-shift-left"  = "move left";
        "alt-shift-right" = "move right";
        "alt-shift-up"    = "move up";
        "alt-shift-down"  = "move down";
        "alt-shift-h"     = "move left";
        "alt-shift-j"     = "move down";
        "alt-shift-k"     = "move up";
        "alt-shift-l"     = "move right";

        # Resize
        "alt-ctrl-right" = "resize width +30";
        "alt-ctrl-left"  = "resize width -30";
        "alt-ctrl-up"    = "resize height -30";
        "alt-ctrl-down"  = "resize height +30";

        # Workspaces
        "alt-1" = "workspace 1";
        "alt-2" = "workspace 2";
        "alt-3" = "workspace 3";
        "alt-4" = "workspace 4";
        "alt-5" = "workspace 5";
        "alt-6" = "workspace 6";
        "alt-7" = "workspace 7";
        "alt-8" = "workspace 8";
        "alt-9" = "workspace 9";
        "alt-0" = "workspace 10";

        # Move window to workspace
        "alt-shift-1" = "move-node-to-workspace 1";
        "alt-shift-2" = "move-node-to-workspace 2";
        "alt-shift-3" = "move-node-to-workspace 3";
        "alt-shift-4" = "move-node-to-workspace 4";
        "alt-shift-5" = "move-node-to-workspace 5";
        "alt-shift-6" = "move-node-to-workspace 6";
        "alt-shift-7" = "move-node-to-workspace 7";
        "alt-shift-8" = "move-node-to-workspace 8";
        "alt-shift-9" = "move-node-to-workspace 9";
        "alt-shift-0" = "move-node-to-workspace 10";
      };
    };
  };

  # Shell
  programs.fish.enable = true;

  # Core system packages
  environment.systemPackages = with pkgs; [
    git
    gh
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
