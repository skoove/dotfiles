{ config, pkgs, osConfig, ... }:
let
  colors = config.lib.stylix.colors;
  bat-icons = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
  net-icons = [ "󰣾" "󰣴" "󰣶" "󰣸" "󰣺" ];
  audio-icons = ["" "" "" "" ];
  generic-percent-icons = [ "▁" "▂" "▃" "▄" "▅" "▆" "▇" "█" ];
  temp-icons = [ "" "" "" ""];
in
{
  home.packages = with pkgs; [
    # required for danials screen recoder script
    socat
    bash
    wf-recorder
    jq
    ffmpeg-full
    slurp
    wl-clipboard
  ];
  
  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings.main-bar = {
      layer = "top";
      
      modules-left = [
        "niri/workspaces"
        "custom/sep"
        "niri/window"
      
        # "hyprland/workspaces"
        # "hyprland/window"
      ];

      modules-center = [
        "mpris"
      ];

      modules-right = [
        "cpu"
        "temperature"
        "memory"
        "backlight"
        "pulseaudio"
        "battery"
        "custom/recorder"
        "clock"
        "tray"
      ];

      "hyprland/window".icon = true;
      "niri/window".icon = true;

      "niri/workspaces" = {
        format = "{icon}";
        format-icons = {
          active = "";
          default = "";
        };
      };

      tray = {
        spacing = 5;
      };

      cava = {
        format-icons = generic-percent-icons;
        bars = 14;
        method = "pulse";
        framerate = 20;
        bar_delimiter = 0;
        stereo = false;
      };

      clock = {
        format = "{:%H:%M %F}";
      };

      battery = {
        format = "{icon} {capacity}%";
        format-icons = bat-icons;
        tooltip-format = "{time}, {cycles} cycles, {health}% health";
      };

      network = {
        format = "{icon}  {ipaddr}";
        format-icons = net-icons;
      };

      pulseaudio = {
        format = "{icon}  {volume}%";
        format-muted = "vol: muted";
        format-icons.default = audio-icons;
        on-click = "pavucontrol";
        scroll-step = 1;
      };

      backlight = {
        format = "󰖨 {icon}";
        format-icons = generic-percent-icons;
        tooltip-format = "{percent}%";
      };

      cpu = {
        interval = 1;
        format = " {icon}";
        format-icons = generic-percent-icons;
        tooltip-format = "usage: {usage}%\nload: {load}";
      };

      memory = {
        interval = 1;
        format = "  {icon}";
        format-icons = generic-percent-icons;
        tooltip-format = "{used} GiB / {total} GiB \n{percentage}%";
      };

      temperature = {
        interval = 1;
        critical-threshold = 80;
        format = "{temperatureC}°C";
        format-icons = temp-icons;
      } // (if osConfig.networking.hostName == "nixos-desktop" then {
        thermal-zone = 2;
      } else {});

      mpris = {
        format = "{status_icon} {dynamic}";
        dynamic-len = 60;
        interval = 5;
        
        status-icons = {
          paused = "";
          playing = "";
        };
      };

      "custom/recorder" = {
        exec = "python ${../scripts/recorder.py}";
        return-type = "json";
        restart-interval = "never";
        on-click = "bash ${../scripts/recorder.sh} screen";
        on-click-right = "bash ${../scripts/recorder.sh} region";
        format = "{}";
      };

    };
  };

  stylix.targets.waybar.enable = false;

  programs.waybar.style = ''
    * {
      border: none;
      font-family: "${config.stylix.fonts.monospace.name}";
      font-size: ${toString config.stylix.fonts.sizes.desktop}pt;
      color: #${colors.base04};
    }

    window#waybar {
      background: #${colors.base00};
    }

    .module {
      background: #${colors.base00};
      margin: 0px 5px 0px 5px;
      padding: 0px 0px 0px 5px;
    }

    #workspaces button {
      padding: 0px;
      border-bottom: 0px none transparent;
    }
  '';
}
