{ ... }:
{
  programs.fuzzel = {
    enable = true;
    settings.main = {
      dpi-aware = true;
      use-bold = true;
      width = 40;
      lines = 20;
      border-width = 3;
      border-radius = 20;
    };
  };
}
