{ ... }:

{
  programs.waybar = {
    enable = true;

    settings = [{
      layer = "top";
      position = "top";
      height = 36;
      margin-top = 6;
      margin-left = 12;
      margin-right = 12;
      spacing = 4;

      modules-left = [ "hyprland/workspaces" "hyprland/window" ];
      modules-center = [ "clock" ];
      modules-right = [ "tray" "pulseaudio" "network" "cpu" "memory" "battery" ];

      "hyprland/workspaces" = {
        format = "{id}";
        on-click = "activate";
        sort-by-number = true;
        active-only = false;
      };

      "hyprland/window" = {
        format = "  {}";
        max-length = 50;
        separate-outputs = true;
      };

      clock = {
        format = "  {:%H:%M}";
        format-alt = "  {:%A, %d %B %Y}";
        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      };

      cpu = {
        format = "  {usage}%";
        tooltip = false;
        interval = 2;
      };

      memory = {
        format = "  {percentage}%";
        tooltip-format = "{used:0.1f}G / {total:0.1f}G";
        interval = 5;
      };

      network = {
        format-wifi = "  {essid}";
        format-ethernet = "  {ifname}";
        format-disconnected = "  Offline";
        tooltip-format = "{ifname}: {ipaddr}\n{gwaddr}";
        on-click = "nm-connection-editor";
      };

      pulseaudio = {
        format = "{icon}  {volume}%";
        format-muted = "  Muted";
        format-icons = { default = [ "" "" "" ]; };
        on-click = "pavucontrol";
        scroll-step = 5;
      };

      battery = {
        states = { warning = 30; critical = 15; };
        format = "{icon}  {capacity}%";
        format-charging = "  {capacity}%";
        format-plugged = "  {capacity}%";
        format-icons = [ "" "" "" "" "" ];
      };

      tray = {
        icon-size = 16;
        spacing = 10;
      };
    }];

    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font", "Font Awesome 6 Free", sans-serif;
        font-size: 13px;
        border: none;
        border-radius: 0;
        min-height: 0;
      }

      window#waybar {
        background: rgba(30, 30, 46, 0.85);
        color: #cdd6f4;
        border-radius: 12px;
      }

      #workspaces {
        background: transparent;
        margin: 4px 4px;
        padding: 0;
      }

      #workspaces button {
        padding: 0 10px;
        color: #6c7086;
        background: rgba(49, 50, 68, 0.6);
        border-radius: 8px;
        margin: 4px 2px;
        transition: all 0.2s ease;
      }

      #workspaces button.active {
        color: #cba6f7;
        background: rgba(203, 166, 247, 0.2);
      }

      #workspaces button.occupied {
        color: #89b4fa;
      }

      #workspaces button:hover {
        color: #cdd6f4;
        background: rgba(205, 214, 244, 0.15);
      }

      #window {
        color: #a6adc8;
        padding: 0 10px;
        margin: 4px 0;
      }

      #clock,
      #battery,
      #cpu,
      #memory,
      #network,
      #pulseaudio,
      #tray {
        padding: 0 14px;
        margin: 4px 3px;
        background: rgba(49, 50, 68, 0.8);
        border-radius: 8px;
        color: #cdd6f4;
      }

      #clock { color: #cba6f7; font-weight: bold; }
      #cpu { color: #89b4fa; }
      #memory { color: #a6e3a1; }
      #network { color: #94e2d5; }
      #pulseaudio { color: #f9e2af; }
      #pulseaudio.muted { color: #6c7086; }
      #battery { color: #a6e3a1; }
      #battery.warning { color: #fab387; }
      #battery.critical { color: #f38ba8; animation-name: blink; animation-duration: 0.5s; animation-timing-function: linear; animation-iteration-count: infinite; animation-direction: alternate; }

      @keyframes blink {
        to { color: #f38ba8; background: rgba(243, 139, 168, 0.2); }
      }
    '';
  };
}
