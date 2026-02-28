{ config, pkgs, ... }:

{
  home.file."Pictures/wallpaper.png".source = ./assets/wallpaper.png;
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      monitor = ",preferred,auto,1";

      exec-once = [
        "waybar"
        "hyprpaper"
        "hypridle"
        "mako"
        "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
        "nm-applet --indicator"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
      ];

      env = [
        "XCURSOR_SIZE,24"
        "XCURSOR_THEME,Adwaita"
        "QT_QPA_PLATFORM,wayland"
        "GDK_BACKEND,wayland,x11,*"
        "SDL_VIDEODRIVER,wayland"
        "MOZ_ENABLE_WAYLAND,1"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgba(cba6f7ff) rgba(89b4faff) 45deg";
        "col.inactive_border" = "rgba(313244aa)";
        layout = "dwindle";
        allow_tearing = false;
      };

      decoration = {
        rounding = 10;
        blur = {
          enabled = true;
          size = 5;
          passes = 2;
          vibrancy = 0.17;
        };
        shadow = {
          enabled = true;
          range = 8;
          render_power = 2;
          color = "rgba(1a1a1aee)";
        };
      };

      animations = {
        enabled = true;
        bezier = [
          "wind, 0.05, 0.9, 0.1, 1.05"
          "winIn, 0.1, 1.1, 0.1, 1.1"
          "winOut, 0.3, -0.3, 0, 1"
          "liner, 1, 1, 1, 1"
        ];
        animation = [
          "windows, 1, 6, wind, slide"
          "windowsIn, 1, 6, winIn, slide"
          "windowsOut, 1, 5, winOut, slide"
          "windowsMove, 1, 5, wind, slide"
          "border, 1, 1, liner"
          "borderangle, 1, 30, liner, loop"
          "fade, 1, 10, default"
          "workspaces, 1, 5, wind"
        ];
      };

      input = {
        kb_layout = "us";
        follow_mouse = 1;
        sensitivity = 0;
        touchpad = {
          natural_scroll = true;
          disable_while_typing = true;
        };
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };

      "$mod" = "SUPER";

      bind = [
        # Apps
        "$mod, Return, exec, ghostty"
        "$mod, E, exec, nautilus"
        "$mod, Space, exec, wofi --show drun"
        "$mod, V, exec, cliphist list | wofi --dmenu | cliphist decode | wl-copy"

        # Window management
        "$mod, Q, killactive"
        "$mod, F, fullscreen"
        "$mod, T, togglefloating"
        "$mod, P, pseudo"
        "$mod, J, togglesplit"
        "$mod, L, exec, hyprlock"
        "$mod SHIFT, M, exit"

        # Focus — arrow keys
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        # Focus — vim keys (H/J/K only, L is lock)
        "$mod, H, movefocus, l"
        "$mod, K, movefocus, u"

        # Move windows
        "$mod SHIFT, left, movewindow, l"
        "$mod SHIFT, right, movewindow, r"
        "$mod SHIFT, up, movewindow, u"
        "$mod SHIFT, down, movewindow, d"

        # Workspaces
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        # Move to workspace
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"

        # Screenshots
        ", Print, exec, grimblast copy area"
        "$mod, Print, exec, grimblast copy screen"
        "$mod SHIFT, S, exec, grimblast copy area"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      binde = [
        "$mod CTRL, right, resizeactive, 30 0"
        "$mod CTRL, left, resizeactive, -30 0"
        "$mod CTRL, up, resizeactive, 0 -30"
        "$mod CTRL, down, resizeactive, 0 30"
      ];

      bindl = [
        ", XF86AudioMute, exec, pamixer --toggle-mute"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
        ", XF86AudioNext, exec, playerctl next"
      ];

      bindle = [
        ", XF86AudioRaiseVolume, exec, pamixer -i 5"
        ", XF86AudioLowerVolume, exec, pamixer -d 5"
        ", XF86MonBrightnessUp, exec, brightnessctl set 10%+"
        ", XF86MonBrightnessDown, exec, brightnessctl set 10%-"
      ];

      windowrulev2 = [
        "suppressevent maximize, class:.*"
        "float, class:org.gnome.Nautilus"
        "size 900 600, class:org.gnome.Nautilus"
        "center, class:org.gnome.Nautilus"
        "float, class:pavucontrol"
        "center, class:pavucontrol"
      ];
    };
  };

  xdg.configFile."hypr/hyprpaper.conf".text =
    let wp = "${config.home.homeDirectory}/Pictures/wallpaper.png"; in ''
      preload = ${wp}
      wallpaper = ,${wp}
      splash = false
      ipc = on
    '';

  # Hyprlock
  xdg.configFile."hypr/hyprlock.conf".text = ''
    background {
      monitor =
      color = rgba(30, 30, 46, 1.0)
      blur_passes = 3
      blur_size = 8
    }

    input-field {
      monitor =
      size = 300, 50
      outline_thickness = 2
      outer_color = rgb(cba6f7)
      inner_color = rgb(1e1e2e)
      font_color = rgb(cdd6f4)
      fade_on_empty = true
      placeholder_text = <span foreground="##cdd6f4">Password...</span>
      rounding = 10
      position = 0, -80
      halign = center
      valign = center
    }

    label {
      monitor =
      text = cmd[update:1000] echo "$(date +"%H:%M")"
      color = rgba(205, 214, 244, 1.0)
      font_size = 80
      font_family = JetBrainsMono Nerd Font Bold
      position = 0, 80
      halign = center
      valign = center
    }
  '';

  # Hypridle
  xdg.configFile."hypr/hypridle.conf".text = ''
    general {
      lock_cmd = pidof hyprlock || hyprlock
      before_sleep_cmd = loginctl lock-session
      after_sleep_cmd = hyprctl dispatch dpms on
    }

    listener {
      timeout = 300
      on-timeout = brightnessctl -s set 10
      on-resume = brightnessctl -r
    }

    listener {
      timeout = 600
      on-timeout = loginctl lock-session
    }

    listener {
      timeout = 900
      on-timeout = systemctl suspend
    }
  '';
}
