{ pkgs, ... }:

{
  # Linux-specific fish aliases
  programs.fish.shellAliases = {
    nr  = "sudo nixos-rebuild switch --flake ~/nixos-config#nixos";
    nru = "cd ~/nixos-config && nix flake update && sudo nixos-rebuild switch --flake ~/nixos-config#nixos";
  };

  # Rofi — app launcher (Raycast equivalent for Linux)
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    terminal = "ghostty";
    theme = "catppuccin-mocha";
    extraConfig = {
      modi = "drun,run,window";
      show-icons = true;
      display-drun = "Apps";
      display-run = "Run";
      display-window = "Windows";
    };
  };

  # Catppuccin Mocha theme for rofi
  xdg.configFile."rofi/catppuccin-mocha.rasi".text = ''
    * {
      bg: #1e1e2e;
      bg-alt: #313244;
      fg: #cdd6f4;
      fg-alt: #bac2de;
      accent: #cba6f7;
      urgent: #f38ba8;

      background-color: @bg;
      text-color: @fg;
    }

    window {
      width: 600px;
      border: 2px;
      border-color: @accent;
      border-radius: 12px;
      padding: 20px;
    }

    inputbar {
      children: [ prompt, entry ];
      spacing: 10px;
      padding: 8px 12px;
      background-color: @bg-alt;
      border-radius: 8px;
    }

    prompt {
      text-color: @accent;
    }

    entry {
      placeholder: "Search...";
      placeholder-color: @fg-alt;
    }

    listview {
      lines: 8;
      columns: 1;
      spacing: 4px;
      padding: 8px 0 0 0;
    }

    element {
      padding: 8px 12px;
      border-radius: 6px;
    }

    element selected {
      background-color: @bg-alt;
      text-color: @accent;
    }

    element-icon {
      size: 24px;
      margin: 0 10px 0 0;
    }
  '';

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

  # Cursor theme
  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 24;
    gtk.enable = true;
  };

  # ── dconf: GNOME settings & vim-style keybindings ──────────────────────────
  dconf.settings = {
    # Dark mode
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      cursor-theme = "Adwaita";
      cursor-size = 24;
    };

    # Caps Lock → Super (home-row modifier)
    "org/gnome/desktop/input-sources" = {
      xkb-options = [ "caps:super" ];
    };

    # Fixed workspaces (needed for Super+1–9)
    "org/gnome/mutter" = {
      dynamic-workspaces = false;
    };
    "org/gnome/desktop/wm/preferences" = {
      num-workspaces = 9;
    };

    # Disable default Super+N app-switching (conflicts with workspace switching)
    "org/gnome/shell/keybindings" = {
      switch-to-application-1  = [];
      switch-to-application-2  = [];
      switch-to-application-3  = [];
      switch-to-application-4  = [];
      switch-to-application-5  = [];
      switch-to-application-6  = [];
      switch-to-application-7  = [];
      switch-to-application-8  = [];
      switch-to-application-9  = [];
    };

    # Window management — vim keys
    "org/gnome/desktop/wm/keybindings" = {
      close            = [ "<Super>q" ];
      toggle-fullscreen = [ "<Super>f" ];
      minimize         = [];  # disable

      # hjkl workspace navigation (GNOME workspaces are vertical)
      switch-to-workspace-up   = [ "<Super>k" ];
      switch-to-workspace-down = [ "<Super>j" ];
      move-to-workspace-up     = [ "<Super><Shift>k" ];
      move-to-workspace-down   = [ "<Super><Shift>j" ];

      # Numbered workspaces
      switch-to-workspace-1 = [ "<Super>1" ];
      switch-to-workspace-2 = [ "<Super>2" ];
      switch-to-workspace-3 = [ "<Super>3" ];
      switch-to-workspace-4 = [ "<Super>4" ];
      switch-to-workspace-5 = [ "<Super>5" ];
      switch-to-workspace-6 = [ "<Super>6" ];
      switch-to-workspace-7 = [ "<Super>7" ];
      switch-to-workspace-8 = [ "<Super>8" ];
      switch-to-workspace-9 = [ "<Super>9" ];

      # Move window to workspace
      move-to-workspace-1 = [ "<Super><Shift>1" ];
      move-to-workspace-2 = [ "<Super><Shift>2" ];
      move-to-workspace-3 = [ "<Super><Shift>3" ];
      move-to-workspace-4 = [ "<Super><Shift>4" ];
      move-to-workspace-5 = [ "<Super><Shift>5" ];
      move-to-workspace-6 = [ "<Super><Shift>6" ];
      move-to-workspace-7 = [ "<Super><Shift>7" ];
      move-to-workspace-8 = [ "<Super><Shift>8" ];
      move-to-workspace-9 = [ "<Super><Shift>9" ];
    };

    # Tile windows with h/l
    "org/gnome/mutter/keybindings" = {
      toggle-tiled-left  = [ "<Super>h" ];
      toggle-tiled-right = [ "<Super>l" ];
    };

    # Custom app launchers
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name    = "Terminal";
      command = "ghostty";
      binding = "<Super>Return";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      name    = "Browser";
      command = "zen-beta";
      binding = "<Super><Shift>Return";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
      name    = "File Manager";
      command = "nautilus";
      binding = "<Super>e";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3" = {
      name    = "Rofi";
      command = "rofi -show drun";
      binding = "<Super>space";
    };
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
