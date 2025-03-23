{ ... }:
{
  programs.bottom = {
    enable = true;

    settings = {
      flags.battery = true;
      styles.theme = "gruvbox";
    };
  };
}
