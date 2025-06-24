{ config , pkgs , osConfig , ... }:
let
  mod = "Super";
  menu = "fuzzel";
  terminal = "footclient";
  alt_terminal = "foot";

  hostname = osConfig.networking.hostName;

  colors = config.lib.stylix.colors;
in {
  imports = [
    ./waybar.nix # bar
    ./dunst.nix  # notification daemon
    ./fish.nix   # Scripts and such required by several things.
  ];

  home.packages = with pkgs; [
    ksnip
    nur.repos.Vortriz.niriswitcher
    playerctl
    swayidle           
    swaylock-effects   
    xwayland-satellite
  ];


  services.hyprpaper.enable = true;

  programs.niri = {
    settings = {
      prefer-no-csd = true;

      spawn-at-startup =[
        { command = [ "sh" "-c" "systemctl --user enable --now waybar.service" ]; }
        { command = [ "sh" "-c" "systemctl --user enable --now syncthingtray.service" ]; }
        { command = [ "sh" "-c" "systemctl --user enable --now hyprpaper.service" ]; }
        { command = [ "xwayland-satellite" ]; }
        { command = [ "foot" "-s" ]; }
        { command = [ "niriswitcher" ]; }
      ] ++ (
        if hostname == "nixos-desktop" then [
          { command = [ "sh" "-c" "discord --start-minimized" ]; }
          { command = [ "element-desktop" "--hidden" ]; }
          { command = [ "sh" "-c" "steam -silent" ]; }
        ] else []
      );

      environment = {
        QT_QPA_PLATFORM = "wayland";
        ELECTRON_OZONE_PLATFORM_HINT = "wayland";
        DISPLAY = ":0";
        _JAVA_AWT_WM_NONREPARENTING="1";
      };

      input = {
        mouse = {
          accel-profile = "flat";
          accel-speed = 0.3;
        };

        trackpoint = {
          accel-profile = "adaptive";
          accel-speed = 0.6;
        };

        tablet.map-to-output = "HDMI-A-1";
      };

      layout = {
        always-center-single-column = false;
        empty-workspace-above-first = true;
        border.width = 2;
        gaps = 15;

        struts =
        let
        side_struts = 15;
        in {
          left = side_struts;
          right = side_struts;
        };
      };


      window-rules = [
        {
          geometry-corner-radius = let
            r = 10.0;
          in {
            top-left = r;
            top-right = r;
            bottom-left = r;
            bottom-right = r;
          };
          clip-to-geometry = true;
        }
      ];

      outputs = {
        # left desktop monitor
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

        # laptop monitor
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
        "${mod}+Shift+E".action = fish "fish ${../scripts/eddy.fish}";
        # edit clipboard
        "${mod}+E".action = fish "fish ${../scripts/cleddy.fish}";
        
        # open things
        "${mod}+D".action = fish menu;
        "${mod}+Return".action = fish terminal;
        "${mod}+Shift+Return".action = fish alt_terminal;
        "${mod}+Shift+M".action = quit;
        "${mod}+T".action = fish "bemoji -c -n";
        "${mod}+P".action = fish "fish ${../scripts/lock-screen.fish}";
        "${mod}+C".action = fish "fish ${../scripts/command-runner.fish}";
        "${mod}+N".action = spawn "footclient" "numbat";
        "Alt+Tab".action = spawn "pkill" "-USR1" "niriswitcher";
        "Alt+Shift+Tab".action = spawn "pkill" "-USR1" "niriswitcher";
        "${mod}+Y".action = fish "dunstify \"$(niri msg focused-window)\"";
        "${mod}+Z".action = spawn "${pkgs.woomer}/bin/woomer";
        "${mod}+V".action = spawn "pavucontrol";

        # reorient
        "${mod}+Q".action = close-window;
        "${mod}+F".action = maximize-column;
        "${mod}+Shift+F".action = fullscreen-window;
        "${mod}+Ctrl+F".action = toggle-window-floating;
        "${mod}+W".action = toggle-column-tabbed-display;

        # open things but better!!!
        "${mod}+1".action = spawn "floorp";
        "${mod}+2".action = spawn "obsidian";
        "${mod}+3".action = spawn "discord";
        "${mod}+4".action = spawn "steam";

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
        "Mod+Shift+1".action = set-column-width "50%";
        "Mod+Shift+Equal".action = set-window-height "+10%";
        "Mod+Shift+Minus".action = set-window-height "-10%";

        "XF86AudioRaiseVolume".action = fish "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+";
        "XF86AudioLowerVolume".action = fish "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-";
        "XF86AudioMute".action = fish "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        "XF86AudioMicMute".action = fish "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
        "XF86MonBrightnessUp".action = fish "brightnessctl s 10%+";
        "XF86MonBrightnessDown".action = fish "brightnessctl s 10%-";

        "XF86AudioPlay".action = fish "playerctl play-pause";
        "XF86AudioNext".action = fish "playerctl next";
        "XF86AudioPrev".action = fish "playerctl previous";
      };
    };
  };
}
