{ config , pkgs , ... }:
let
  mod = "Super";
  menu = "wofi --show drun";
  terminal = "footclient";
  alt_terminal = "foot";
  power-menu = "wofi-power-menu";
in {
  imports = [
    ./waybar.nix
    ./wofi.nix
    ./dunst.nix
  ];

  home.packages = [ pkgs.xwayland-satellite ];

  services.hyprpaper.enable = true;

  programs.niri = {
    settings = {
      prefer-no-csd = true;
      
      spawn-at-startup =[
        { command = [ "sh" "-c" "systemctl --user enable --now waybar.service" ]; }
        { command = [ "sh" "-c" "systemctl --user enable --now syncthingtray.service" ]; }
        { command = [ "sh" "-c" "systemctl --user enable --now hyprpaper.service"]; }
        { command = [ "xwayland-satellite" ]; }
        { command = [ "foot" "-s" ]; }
      ];

      environment = {
        QT_QPA_PLATFORM = "wayland";
        DISPLAY = ":0";
      };

      window-rules = [
        {
          clip-to-geometry = true;
          geometry-corner-radius =
          let
            rounding = 10.0;
          in {
            top-left = rounding;
            top-right = rounding;
            bottom-left = rounding;
            bottom-right = rounding;
          };
        }
      ];
      
      binds = with config.lib.niri.actions;
      let
        sh = spawn "sh" "-c";
      in {
        "${mod}+D".action = sh menu;
        "${mod}+Return".action = sh terminal;
        "${mod}+Shift+Return".action = sh alt_terminal;
        "${mod}+Shift+M".action = sh power-menu;

        "${mod}+Q".action = close-window;
        "${mod}+F".action = maximize-column;
        "${mod}+Shift+F".action = fullscreen-window;
        "${mod}+C".action = center-column;

        "${mod}+K".action = focus-window-or-workspace-up;
        "${mod}+J".action = focus-window-or-workspace-down;
        "${mod}+H".action = focus-column-or-monitor-left;
        "${mod}+L".action = focus-column-or-monitor-right;

        "${mod}+Shift+K".action = move-window-up-or-to-workspace-up;
        "${mod}+Shift+J".action = move-window-down-or-to-workspace-down;
        "${mod}+Shift+H".action = move-column-left-or-to-monitor-left;
        "${mod}+Shift+L".action = move-column-right-or-to-monitor-right;

        "${mod}+Comma".action = consume-or-expel-window-left;
        "${mod}+Period".action = consume-or-expel-window-right;

        "Mod+Equal".action = set-column-width "+10%";
        "Mod+Minus".action = set-column-width "-10%";
        "Mod+Shift+Equal".action = set-window-height "+10%";
        "Mod+Shift+Minus".action = set-window-height "-10%";

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
