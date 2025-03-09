{ config, pkgs, ... }:

let
  mod = "SUPER";
  menu = "fuzzel";
in {
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.settings.bind = 
  [
    "${mod}, Q, killactive"
    "${mod}, D, exec, ${menu}"
  ];
}
