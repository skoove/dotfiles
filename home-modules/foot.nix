{ ... }:
{
  programs.foot = {
    enable = true;
    settings = {
      key-bindings.spawn-terminal = "Mod1+n";
      main.pad = "3x3 center";

      cursor = {
        style = "underline";
        blink = true;
        blink-rate = 250;
      };
    };
  };
}
