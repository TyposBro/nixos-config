{ pkgs, ... }:

{
  # Linux-specific fish aliases
  programs.fish.shellAliases = {
    nr  = "sudo nixos-rebuild switch --flake ~/nixos-config#nixos";
    nru = "cd ~/nixos-config && nix flake update && sudo nixos-rebuild switch --flake ~/nixos-config#nixos";
  };

  # Ghostty Linux-specific options (appended to shared config)
  xdg.configFile."ghostty/config".text = ''
    font-family = JetBrainsMono Nerd Font
    font-size = 17
    theme = catppuccin-mocha
    background-opacity = 0.9
    cursor-style = bar
    shell-integration = fish
    window-decoration = false
    gtk-tabs-location = bottom
    gtk-single-instance = true
  '';

  # Mako — notification daemon
  services.mako = {
    enable = true;
    settings = {
      background-color = "#1e1e2e";
      text-color = "#cdd6f4";
      border-color = "#cba6f7";
      progress-color = "over #313244";
      border-radius = 8;
      border-size = 2;
      default-timeout = 5000;
      font = "JetBrainsMono Nerd Font 16";
      width = 380;
      padding = "14";
      margin = "10";
      icons = 1;
      max-icon-size = 48;
    };
  };

  # Wofi — app launcher
  xdg.configFile."wofi/config".text = ''
    width=640
    height=420
    location=center
    show=drun
    prompt=  Search...
    filter_rate=100
    allow_markup=true
    no_actions=true
    halign=fill
    orientation=vertical
    insensitive=true
    allow_images=true
    image_size=36
    gtk_dark=true
  '';

  xdg.configFile."wofi/style.css".text = ''
    window {
      background-color: #1e1e2e;
      border: 2px solid #313244;
      border-radius: 12px;
    }

    #input {
      background-color: #313244;
      color: #cdd6f4;
      border: none;
      border-radius: 8px;
      padding: 12px 16px;
      margin: 10px;
      font-family: "JetBrainsMono Nerd Font";
      font-size: 17px;
    }

    #inner-box { background-color: transparent; }
    #outer-box { padding: 4px; }

    #entry {
      background-color: transparent;
      padding: 10px 12px;
      border-radius: 8px;
    }

    #entry:selected { background-color: #313244; }
    #entry:selected #text { color: #cba6f7; }

    #text {
      color: #cdd6f4;
      font-family: "JetBrainsMono Nerd Font";
      font-size: 17px;
    }

    #img { margin-right: 10px; }
  '';

  # GTK dark theme
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    font = {
      name = "Noto Sans";
      size = 15;
    };
    gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = true;
  };

  # Force dark mode system-wide
  dconf.settings."org/gnome/desktop/interface" = {
    color-scheme = "prefer-dark";
  };

  # Set Zen Browser as the default browser
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html"              = "zen-browser.desktop";
      "x-scheme-handler/http"  = "zen-browser.desktop";
      "x-scheme-handler/https" = "zen-browser.desktop";
      "x-scheme-handler/about" = "zen-browser.desktop";
      "x-scheme-handler/ftp"   = "zen-browser.desktop";
    };
  };

  # XDG user dirs
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };
}
