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
        "niri/workspaces"
      
        # "hyprland/workspaces"
        # "hyprland/window"
      ];

      modules-center = [
        "niri/window"
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
      "niri/window".icon = false;

      "niri/workspaces" = {
        format = "{icon}";
        format-icons = {
          active = "";
          default = "";
        };
      };

      tray = {
        spacing = 5;
      };

      clock = {
        format = "{:%H:%M  %F}";
      };

      battery = {
        format = "bat: {capacity}%";
        # format-icons = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
        tooltip-format = "{time}, {cycles} cycles, {health}% health";
      };

      network = {
        format = "net: {essid}";
        # format-icons = [ "󰤟" "󰤢" "󰤥" "󰤨" ];
      };

      pulseaudio = {
        format = "vol: {volume}%";
        format-muted = "vol: muted";
        format-icons.default = [ "" ""];
        on-click = "pavucontrol";
        scroll-step = 1;
      };

      backlight = {
        format = "bl: {percent}%";
      };

      cpu = {
        interval = 1;
        format = "cpu: {usage}%";
      };

      memory = {
        interval = 1;
        format = "mem: {percentage}%";
        tooltip-format = "{used} GiB / {total} GiB";
      };

      temperature = {
        interval = 1;
        thermal-zone = 2;
        critical-threshold = 80;
        format = "t: {temperatureC}°C";
      };
    };

    style = builtins.readFile ./waybar.css;
  };
}
