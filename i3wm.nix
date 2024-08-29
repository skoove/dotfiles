# file : i3wm.nix
# managed by : home-manager
{ lib , config , pkgs , options , ... }:

let
  modifier = "Mod4";
in
{
  home.sessionPath = [ "/libexec" ];

  xsession.windowManager.i3.enable = true;

  xsession.windowManager.i3.extraConfig = ''
    for_window [window_role="alert"] floating enable
    no_focus [window_role="alert"]
  '';

  ### startup commands ###
  xsession.windowManager.i3.config.startup = [
    {command = "syncthing";}
    {command = "syncthingtray";}
    {command = "vesktop --start-minimized --enable-blink-features=MiddleClickAutoscroll";}
    {command = "steam -silent";} # steam keeps complaining on startup
    {command = "xmousepasteblock";}
    {
      command = "feh --bg-fill /home/zie/.dotfiles/background-image.png";
      always = true;
      notification = false;
    }
  ];

  ### window settings ###
  xsession.windowManager.i3.config.window = {
    border = 2;
    titlebar = false;
  };

  ### gaps ###
  xsession.windowManager.i3.config.gaps = {
    inner = 10;
    outer = 3;
  };

  ### keybinds config ###
  xsession.windowManager.i3.config.modifier = modifier;
  xsession.windowManager.i3.config.keybindings = 
  lib.mkOptionDefault {
    "${modifier}+Return" = "exec kitty";

    # window focusing keybinds #
    "${modifier}+h" = "focus left";
    "${modifier}+j" = "focus down";
    "${modifier}+k" = "focus up";       
    "${modifier}+l" = "focus right";

    # window moving keybinds #
    "${modifier}+shift+h" = "move left";
    "${modifier}+shift+j" = "move down";
    "${modifier}+shift+k" = "move up";       
    "${modifier}+shift+l" = "move right";

    # pressing mod+v changes how new windows get split
    "${modifier}+v" = "split toggle";

    # xclip + maim screenshotting #
    "Print" = "exec maim -s | xclip -t image/png -selection clipboard";

    # audio
    "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +5%"; # up
    "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -5%"; # down
    "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";  # toggle mute

    # media keys
    "XF86AudioPause" = "exec playerctl play-pause";
    "XF86AudioNext" = "exec playerctl next";
    "XF86AudioPrev" = "exec playerctl previous";
  };
  
  ### colors ###
  xsession.windowManager.i3.config.colors = with options.colors.default; {
    focused = {
      border = accent;
      background = surface1;
      text = text;
      indicator = green;
      childBorder = accent;
    };

    focusedInactive = {
      border = accent;
      background = surface1;
      text = text;
      indicator = surface0;
      childBorder = surface0;
    };

    unfocused = {
      border = surface0;
      background = surface0;
      text = text;
      indicator = surface0;
      childBorder = surface0;
    };

    urgent = {
      border = red;
      background = red;
      text = mantle;
      indicator = green;
      childBorder = red;
    };
  };
 
  ### i3bar config  ###
  xsession.windowManager.i3.config.bars = [{
    position = "top";
    statusCommand = "i3blocks -c ~/.config/i3blocks/bar";
    trayOutput = "primary";
    fonts = {
      names = [ "Roboto" ];
      size = 10.0;
      style = "normal";
    };
    colors = with options.colors.default;({
      background = base;
      statusline = text;
      focusedWorkspace = {
        background = accent;
        border = accent;
        text = mantle;
      };
      activeWorkspace = { # workspace that is not focused but is active (second monitor)
        background = surface0;
        border = accent;
        text = text;
      };
      inactiveWorkspace = {
        background = base;
        border = surface0;
        text = text;
      };
      urgentWorkspace = {
        border = surface0;
        background = red;
        text = mantle;
      };
    });
  }];

  ### i3 blocks config ###
  programs.i3blocks.enable = true;
  programs.i3blocks.bars = {
    bar = {
      test = {
        command = "date +\"%A %Y-%m-%d %H:%M:%S %Z\"";
        interval = 1;
      };
    };
  };
  
  ### fonts ###
  xsession.windowManager.i3.config.fonts = {
    names = [ "Roboto" ];
    style = "bold";
    size = 11.0;
  };

  ### misc things ###
  xsession.windowManager.i3.config.menu = "rofi -show drun";
}
