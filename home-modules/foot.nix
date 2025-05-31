{ ... }:
{
  programs.foot = {
    enable = true;
    settings = {
      key-bindings.spawn-terminal = "Mod1+n";
      main.pad = "3x3 center";
    };
  };
}
