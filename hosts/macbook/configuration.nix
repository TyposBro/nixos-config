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
  # Mirrors Hyprland keybindings: CTRL as WM modifier, CMD for app shortcuts
  services.aerospace = {
    enable = true;
    settings = {
      # start-at-login managed by launchd, not aerospace itself
      default-root-container-layout = "tiles";
      default-root-container-orientation = "auto";
      accordion-padding = 30;

      gaps = {
        inner.horizontal = 0;
        inner.vertical = 0;
        outer.top = 0;
        outer.bottom = 0;
        outer.left = 0;
        outer.right = 0;
      };

      key-mapping.preset = "qwerty";

      # Float macOS utility apps that shouldn't tile
      on-window-detected = [
        { "if".app-id = "com.apple.finder"; run = "layout floating"; }
      ];

      mode.main.binding = {
        # Apps
        "ctrl-enter" = "exec-and-forget ghostty";
        "ctrl-shift-enter" = "exec-and-forget open -a 'Zen Browser'";

        # Window management
        "ctrl-q"           = "close";
        "ctrl-f"           = "fullscreen";
        "ctrl-shift-t"     = "layout floating tiling";
        "ctrl-slash"       = "layout tiles horizontal vertical";

        # Focus — arrow keys
        "ctrl-left"  = "focus left";
        "ctrl-right" = "focus right";
        "ctrl-up"    = "focus up";
        "ctrl-down"  = "focus down";

        # Move windows
        "ctrl-shift-left"  = "move left";
        "ctrl-shift-right" = "move right";
        "ctrl-shift-up"    = "move up";
        "ctrl-shift-down"  = "move down";

        # Resize
        "ctrl-alt-right" = "resize width +30";
        "ctrl-alt-left"  = "resize width -30";
        "ctrl-alt-up"    = "resize height -30";
        "ctrl-alt-down"  = "resize height +30";

        # Workspaces
        "ctrl-1" = "workspace 1";
        "ctrl-2" = "workspace 2";
        "ctrl-3" = "workspace 3";
        "ctrl-4" = "workspace 4";
        "ctrl-5" = "workspace 5";
        "ctrl-6" = "workspace 6";
        "ctrl-7" = "workspace 7";
        "ctrl-8" = "workspace 8";
        "ctrl-9" = "workspace 9";
        "ctrl-0" = "workspace 10";

        # Move window to workspace
        "ctrl-shift-1" = "move-node-to-workspace 1";
        "ctrl-shift-2" = "move-node-to-workspace 2";
        "ctrl-shift-3" = "move-node-to-workspace 3";
        "ctrl-shift-4" = "move-node-to-workspace 4";
        "ctrl-shift-5" = "move-node-to-workspace 5";
        "ctrl-shift-6" = "move-node-to-workspace 6";
        "ctrl-shift-7" = "move-node-to-workspace 7";
        "ctrl-shift-8" = "move-node-to-workspace 8";
        "ctrl-shift-9" = "move-node-to-workspace 9";
        "ctrl-shift-0" = "move-node-to-workspace 10";
      };
    };
  };

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
