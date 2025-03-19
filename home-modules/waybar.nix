{ config, ... }:
let
  colors = config.lib.stylix.colors;
in
{
  programs.waybar = {
    enable = true;
    systemd.enable = true; # makes it start with hyprland

    settings.main-bar = {
      modules-left = [
        "hyprland/workspaces"
        "hyprland/window"
      ];

      modules-right = [
        "temperature"
        "cpu"
        "memory"
        "backlight"
        "network"
        "battery"
        "clock"
        "tray"
      ];

      clock = {
        format = " {:%H:%M  %F}";
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
        format = " {temperatureC}°C";
      };
    };

    style = ''
      window#waybar {
        background-color: #${colors.base01};
      }
    '';
  };
}
