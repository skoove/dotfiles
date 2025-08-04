{ ... }:
{
  programs.fuzzel = {
    enable = true;
    settings.main = {
      dpi-aware = true;
      use-bold = true;
      width = 40;
      lines = 20;
    };

    settings.border = {
      width = 3;
      radius = 20;
    };
  };
}
