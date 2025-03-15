# managed by home manager

{ config, pkgs, settings, ... }:

let
  mod = "SUPER";
  menu = "fuzzel";
in {
  wayland.windowManager.hyprland.enable = settings.hyprland-enabled;
  wayland.windowManager.hyprland.settings.bind = 
  [
    "${mod}, Q, killactive"
    "${mod}, D, exec, ${menu}"
  ];
}
