{ config, osConfig , ... }:

let
  mod = "SUPER";
  menu = "wofi --show drun";
  terminal = "foot";
  power-menu = "wofi-power-menu";

  hostname = osConfig.networking.hostName;
in {
  imports = [
    ./waybar.nix
    ./wofi.nix
    ./dunst.nix
  ];
  
  wayland.windowManager.hyprland.enable = osConfig.programs.hyprland.enable;
  services.hyprpaper.enable = true;

  wayland.windowManager.hyprland.settings = {
    general.border_size =  3;

    env = "HYPRSHOT_DIR,Photos/screenshots";
  
    monitor = [
      ", preferred, auto, 1" # default for unspecified monitors
      "HDMI-A-1, 1920x1080@100.0, auto, 1" # main desktop monitor
      "DVI-D-1, 1920x1080@100.0, auto-left, 1" # left desktop monitor
    ];

    misc = {
      disable_hyprland_logo = true;
      vfr = true;
    };

    decoration = {
      blur.enabled = false;
      shadow.enabled = false;
    };

    device = {
      name = "logitech-g203-lightsync-gaming-mouse";
      accel_profile = "flat";
      sensitivity = 0.3;
    };

    exec-once = [
      "systemctl --user enable --now hyprpaper.service"
      "systemctl --user enable --now waybar.service"
      "systemctl --user enable --now syncthingtray.service"
    ] ++ (
      if hostname == "nixos-desktop" then [
        "discord --start-minimized"
        "steam -silent"
      ] else []
    );

    animation = [
      # NAME, ONOFF, SPEED, CURVE ,STYLE
      # style is optional
      "windows, 1, 5, default, slide"
      "workspaces, 1, 5, default, slidevert"
      "fade, 0"
    ];

    bindm = [
      "${mod}, mouse:272, movewindow"
      "${mod}, mouse:273, resizewindow"
    ];

    bindel = [
      ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
      ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
      ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
    ];

    bind = [
      "${mod}, S, exec, hyprshot -m region -- ksnip"
      "${mod} SHIFT, S, exec, hyprshot -m window -- ksnip"
      "${mod} CONTROL, S, exec, hyprshot -m output -- ksnip"

      "${mod}, T, exec, bemoji -c -n"
      "${mod}, D, exec, ${menu}"
      "${mod}, RETURN, exec, ${terminal}"
      "${mod} SHIFT, M, exec, ${power-menu}"

      "${mod}, Q, killactive"
      "${mod}, F, fullscreen"
      "${mod}, W, togglegroup"

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
