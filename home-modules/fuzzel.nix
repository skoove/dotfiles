{ ... }:
{
  programs.fuzzel = {
    enable = true;
    settings.main = {
      dpi-aware = false;
      use-bold = true;
    };
  };
}
