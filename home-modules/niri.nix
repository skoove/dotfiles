{ config , ... }:
let
  mod = "Super";
  menu = "wofi --show drun";
  terminal = "foot";
  power-menu = "wofi-power-menu";
in {
  imports = [
    ./waybar.nix
    ./wofi.nix
    ./dunst.nix
  ];

  programs.niri = {
    settings = {
      spawn-at-startup =[
        { command = ["sh" "-c" "systemctl --user enable --now waybar.service"]; }
        { command = ["sh" "-c" "systemctl --user enable --now syncthingtray.service"]; }
      ];
      
      binds = with config.lib.niri.actions;
      let
        sh = spawn "sh" "-c";
      in {
        "${mod}+D".action = sh menu;
        "${mod}+Return".action = sh terminal;
        "${mod}+Shift+D".action = sh power-menu;

        "${mod}+Q".action = close-window;
        "${mod}+F".action = fullscreen-window;

        "${mod}+K".action = focus-workspace-up;
        "${mod}+J".action = focus-workspace-down;
        "${mod}+H".action = focus-column-or-monitor-left;
        "${mod}+L".action = focus-column-or-monitor-right;

        "${mod}+Shift+K".action = move-workspace-up;
        "${mod}+Shift+J".action = move-workspace-down;
        "${mod}+Shift+H".action = move-column-left-or-to-monitor-left;
        "${mod}+Shift+L".action = move-column-right-or-to-monitor-right;

        "Mod+Equal".action = set-column-width "+10%";
        "Mod+Minus".action = set-column-width "-10%";

        "XF86AudioRaiseVolume".action = sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+";
        "XF86AudioLowerVolume".action = sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-";
        XF86AudioMute.action = sh "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        XF86AudioMicMute.action = sh "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
        XF86MonBrightnessUp.action = sh "brightnessctl s 10%+";
        XF86MonBrightnessDown.action = sh "brightnessctl s 10%-";
      };
    };
  };
}
