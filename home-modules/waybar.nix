{ config, lib, ... }:
let
  colors = config.lib.stylix.colors;
in
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings.main-bar = {
      layer = "top";
      
      modules-left = [
        "hyprland/workspaces"
        "hyprland/window"
      ];

      modules-right = [
        "temperature"
        "cpu"
        "memory"
        "backlight"
        "pulseaudio"
        "network"
        "battery"
        "clock"
        "tray"
      ];

      "hyprland/window".icon = true;

      tray = {
        spacing = 5;
      };

      clock = {
        format = " {:%H:%M   %F}";
      };

      battery = {
        format = "{icon} {capacity}%";
        format-icons = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
        tooltip-format = "{time}, {cycles} cycles, {health}% health";
      };

      network = {
        format = "{icon} {essid}";
        format-icons = [ "󰤟" "󰤢" "󰤥" "󰤨" ];
      };

      pulseaudio = {
        format = "{icon} {volume}%";
        format-muted = " muted";
        format-icons.default = [ "" ""];
        on-click = "pavucontrol";
        scroll-step = 1;
      };

      backlight = {
        format = " {percent}%";
      };

      cpu = {
        interval = 1;
        format = " {usage}%";
      };

      memory = {
        interval = 1;
        format = " {percentage}%";
        tooltip-format = "{used} GiB / {total} GiB";
      };

      temperature = {
        interval = 1;
        thermal-zone = 2;
        critical-threshold = 80;
        format = " {temperatureC}°C";
      };
    };

    style = builtins.readFile ./waybar.css;
  };
}
