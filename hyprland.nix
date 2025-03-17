# managed by home manager

{ config, pkgs, settings, ... }:

let
  mod = "SUPER";
  menu = "fuzzel";
  terminal = "kitty";
in {
  wayland.windowManager.hyprland.enable = settings.hyprland-enabled;

  wayland.windowManager.hyprland.settings = {
    misc.disable_hyprland_logo = true;
  
    monitor = [
      ", preferred, auto, 1" # default for unspecified monitors
      "HDMI-A-1, 1920x1080@100.0, auto, 1" # main desktop monitor
      "DVI-D-1, 1920x1080@100.0, auto-left, 1" # left desktop monitor
    ];

    device = {
      name = "logitech-g203-lightsync-gaming-mouse";
      accel_profile = "flat";
      sensitivity = 0.3;
    };

    exec-once = [
      "systemctl --user enable --now hyprpaper.service"
      "systemctl --user enable --now waybar.service"
    ];

    bindm = [
      "${mod}, mouse:272, movewindow"
      "${mod}, mouse:273, resizewindow"
    ];

    bind = [
      "${mod}, Q, killactive"
      "${mod}, F, fullscreen"
      "${mod}, W, togglegroup"
      "${mod} SHIFT, M, exit"

      "${mod}, T, exec, bemoji -c -n"
      "${mod}, D, exec, ${menu}"
      "${mod}, RETURN, exec, ${terminal}"

      "${mod}, H, movefocus, l"
      "${mod}, L, movefocus, r"
      "${mod}, J, movefocus, d"
      "${mod}, K, movefocus, u"
      "${mod} SHIFT, H, movewindow, l"
      "${mod} SHIFT, L, movewindow, r"
      "${mod} SHIFT, J, movewindow, d"
      "${mod} SHIFT, K, movewindow, u"

      "${mod}, 1, workspace, 1"
      "${mod}, 2, workspace, 2"
      "${mod}, 3, workspace, 3"
      "${mod}, 4, workspace, 4"
      "${mod}, 5, workspace, 5"
      "${mod}, 6, workspace, 6"
      "${mod}, 7, workspace, 7"
      "${mod}, 8, workspace, 8"
      "${mod}, 9, workspace, 9"
      "${mod}, 0, workspace, 10"
      "${mod} SHIFT, 1, movetoworkspace, 1"
      "${mod} SHIFT, 2, movetoworkspace, 2"
      "${mod} SHIFT, 3, movetoworkspace, 3"
      "${mod} SHIFT, 4, movetoworkspace, 4"
      "${mod} SHIFT, 5, movetoworkspace, 5"
      "${mod} SHIFT, 6, movetoworkspace, 6"
      "${mod} SHIFT, 7, movetoworkspace, 7"
      "${mod} SHIFT, 8, movetoworkspace, 8"
      "${mod} SHIFT, 9, movetoworkspace, 9"
      "${mod} SHIFT, 0, movetoworkspace, 10"
    ];
  };
}
