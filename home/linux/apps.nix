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
    window-decoration = true
    gtk-tabs-location = bottom
    gtk-single-instance = true
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
