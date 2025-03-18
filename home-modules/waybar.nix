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
        tooltop-format = "time, {cycles} cycles, {health}% health";
      };

      network = {
        format = "{icon} {essid}  {ipaddr}";
        format-icons = [ "󰤟" "󰤢" "󰤥" "󰤨" ];
      };
    };

    style = ''
      window#waybar {
        background-color: #${colors.base01};
      }
    '';
  };
}
