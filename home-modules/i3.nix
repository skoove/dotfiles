{ config , lib , osConfig , ... }:
{
  xsession.windowManager.i3 = {
    enable = osConfig.services.xserver.windowManager.i3.enable;

    config = {
      modifier = "Mod4";

      startup = [
        {
          always = true;
          command = "xrandr --output HDMI-0 --mode 1920x1080 --rate 100 --primary --output DVI-D-0 --mode 1920x1080 --rate 100 --left-of HDMI-0";
        }
        {
          always = true;
          command = "xinput --set-prop 'Logitech G203 LIGHTSYNC Gaming Mouse' 'libinput Accel Profile Enabled' 0, 1, 0";
        }
        {
          always = true;
          command = "steam";
        }
      ];

      keybindings = let
        mod = config.xsession.windowManager.i3.config.modifier;
      in lib.mkOptionDefault {
        "${mod}+q" = "kill";
        "${mod}+f" = "fullscreen";

        "${mod}+h" = "focus left";
        "${mod}+l" = "focus right";
        "${mod}+j" = "focus down";
        "${mod}+k" = "focus up";

        "${mod}+Shift+h" = "move left";
        "${mod}+Shift+l" = "move right";
        "${mod}+Shift+j" = "move down";
        "${mod}+Shift+k" = "move up";
      };
    };
  };
}
