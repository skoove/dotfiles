{ ... }:
{
  programs.bottom = {
    enable = true;

    settings = {
      flags = {
        tree = true;
        battery = true;
      };

      styles.theme = "gruvbox";
    };
  };
}
