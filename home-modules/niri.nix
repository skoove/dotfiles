{ config , pkgs , osConfig , ... }:
let
  mod = "Super";
  menu = "fuzzel";
  terminal = "footclient";
  alt_terminal = "foot";

  hostname = osConfig.networking.hostName;
in {
  imports = [
    ./waybar.nix # bar
    ./dunst.nix  # notification daemon
    ./fish.nix   # Scripts and such required by several things.
  ];

  home.packages = with pkgs; [
    xwayland-satellite
    swaylock-effects   # Lockscreen.
  ];

  xdg.portal ={
    enable = true;
    config.common.default = "*";
    
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };


  services.hyprpaper.enable = true;

  programs.niri = {
    settings = {
      prefer-no-csd = true;

      # TODO: this seriously needs to be cleaned up
      spawn-at-startup =[
        { command = [ "sh" "-c" "systemctl --user enable --now waybar.service" ]; }
        { command = [ "sh" "-c" "systemctl --user enable --now syncthingtray.service" ]; }
        { command = [ "sh" "-c" "systemctl --user enable --now hyprpaper.service" ]; }
        # this (hopefully) fixes waybar being really slow to load
        { command = [ "sh" "-c" "dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY" ]; }
        { command = [ "xwayland-satellite" ]; }
        { command = [ "foot" "-s" ]; }
      ] ++ (
        if hostname == "nixos-desktop" then [
          { command = [ "sh" "-c" "discord --start-minimized" ]; }
          { command = [ "sh" "-c" "steam -silent" ]; }
        ] else []
      );

      environment = {
        QT_QPA_PLATFORM = "wayland";
        ELECTRON_OZONE_PLATFORM_HINT = "wayland";
        DISPLAY = ":0";
      };

      input = {
        mouse = {
          accel-profile = "flat";
          accel-speed = 0.3;
        };

        trackpoint = {
          accel-profile = "adaptive";
          accel-speed = 0.3;
        };

        tablet.map-to-output = "HDMI-A-1";
      };

      layout = {
        always-center-single-column = true;
        empty-workspace-above-first = true;
        border.width = 2;
        gaps = 10;

        struts =
        let
        side_struts = 15;
        in {
          left = side_struts;
          right = side_struts;
        };
      };

      outputs = {
        # laptop monitor
        "HDMI-A-1" = {
          scale = 1.0;
          mode = {
            width = 1920;
            height = 1080;
            refresh = 100.0;
          };
        };

        # primary desktop monitor
        "DVI-D-1" = {
          scale = 1.0;
          mode = {
            width = 1920;
            height = 1080;
            refresh = 100.0;
          };
        };

        # left desktop monitor
        "eDP-1" = {
          scale = 1.0;
          mode = {
            width = 1920;
            height = 1080;
            refresh = 100.0;
          };
        };
      };
      
      binds = with config.lib.niri.actions;
      let
        # for shell scripts remember to actually run them
        # with fish, see cleddy bind
        fish = spawn "fish" "-c";
      in {
        # misc
        # edit text then save to clipboard
        "${mod}+E".action = fish "fish ${../scripts/eddy.fish}";
        # edit clipboard
        "${mod}+Shift+E".action = fish "fish ${../scripts/cleddy.fish}";
        
        # open things
        "${mod}+D".action = fish menu;
        "${mod}+Return".action = fish terminal;
        "${mod}+Shift+Return".action = fish alt_terminal;
        "${mod}+Shift+M".action = quit;
        "${mod}+T".action = fish "bemoji -c -n";
        "${mod}+P".action = fish "../scripts/lock-screen.fish";

        # reorient
        "${mod}+Q".action = close-window;
        "${mod}+F".action = maximize-column;
        "${mod}+Shift+F".action = fullscreen-window;
        "${mod}+C".action = center-column;
        "${mod}+Ctrl+F".action = toggle-window-floating;

        # refocus
        "${mod}+K".action = focus-window-or-workspace-up;
        "${mod}+J".action = focus-window-or-workspace-down;
        "${mod}+H".action = focus-column-or-monitor-left;
        "${mod}+L".action = focus-column-or-monitor-right;

        # move things
        "${mod}+Shift+K".action = move-window-up-or-to-workspace-up;
        "${mod}+Shift+J".action = move-window-down-or-to-workspace-down;
        "${mod}+Shift+H".action = move-column-left-or-to-monitor-left;
        "${mod}+Shift+L".action = move-column-right-or-to-monitor-right;

        # stack and unstack
        "${mod}+Comma".action = consume-or-expel-window-left;
        "${mod}+Period".action = consume-or-expel-window-right;

        # screenshotting
        "${mod}+S".action = screenshot;
        "${mod}+Shift+S".action = screenshot-window;
        "${mod}+A".action = fish "wl-paste | satty -f - --fullscreen --copy-command 'wl-copy'";

        # resize things
        "Mod+Equal".action = set-column-width "+10%";
        "Mod+Minus".action = set-column-width "-10%";
        "Mod+Shift+Equal".action = set-window-height "+10%";
        "Mod+Shift+Minus".action = set-window-height "-10%";

        "XF86AudioRaiseVolume".action = fish "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+";
        "XF86AudioLowerVolume".action = fish "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-";
        "XF86AudioMute".action = fish "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        "XF86AudioMicMute".action = fish "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
        "XF86MonBrightnessUp".action = fish "brightnessctl s 10%+";
        "XF86MonBrightnessDown".action = fish "brightnessctl s 10%-";
      };
    };
  };
}
