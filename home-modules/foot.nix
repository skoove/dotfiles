{ ... }:
{
  programs.foot = {
    enable = true;
    settings = {
      key-bindings.spawn-terminal = "Mod1+n";
      mouse.hide-when-typing = true;
      main.pad = "3x3 center";

      cursor = {
        style = "underline";
        blink = true;
        blink-rate = 250;
      };
    };
  };
}
