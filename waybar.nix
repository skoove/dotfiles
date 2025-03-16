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

      modules-right = ["clock"];
    };

    style = ''
      window#waybar {
        background-color: #${colors.base01};
      }
    '';
  };
}
