{ config , lib , osConfig , ... }:
{
  xsession.windowManager.i3 = {
    enable = osConfig.services.xserver.windowManager.i3.enable;

    config = {
      modifier = "Mod4";

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
