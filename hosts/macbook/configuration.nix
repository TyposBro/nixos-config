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
    noto-fonts-color-emoji
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

  # Homebrew — managed declaratively by nix-darwin
  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "zap";       # remove casks not listed here
      autoUpdate = true;
      upgrade = true;
    };
    casks = [
      # Browsers
      "brave-browser"
      "zen"

      # Chat & social
      "discord"
      "spotify"

      # Dev tools
      "android-studio"
      "docker"
      "github"

      # AI
      "claude"

      # Productivity
      "alt-tab"
      "raycast"
      "obs"

      # Media
      "eqmac"
      "iina"
      "kdenlive"
      "lastfm"

      # VPN & networking
      "protonvpn"
      "windscribe"

      # System
      "bitwarden"
      "ghostty"
      "karabiner-elements"
      "ngrok"
      "au-lab"
    ];
  };

  # Create macOS aliases for Nix apps so Spotlight can find them
  # Uses a separate directory to avoid nix-darwin overwriting /Applications/Nix Apps
  system.activationScripts.nixAppsAliases.text = ''
    echo "setting up Spotlight aliases for Nix apps..." >&2
    app_dir="/Applications/Nix Aliases"
    rm -rf "$app_dir"
    mkdir -p "$app_dir"
    for app in /Users/typosbro/Applications/Home\ Manager\ Apps/*.app; do
      [ -e "$app" ] || continue
      app_name=$(basename "$app")
      echo "  aliasing $app_name" >&2
      ${pkgs.mkalias}/bin/mkalias "$app" "$app_dir/$app_name"
    done
  '';

  # Primary user — update username/home if different on your Mac
  users.users.typosbro = {
    home = "/Users/typosbro";
    shell = pkgs.fish;
  };

  system.stateVersion = 5;
}
