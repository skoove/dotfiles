{ pkgs, config, ... }:
{
  stylix.enable = true;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
  stylix.image = ./wallpapers/solar-system.jpg;
  stylix.fonts = {
    monospace = {
      package = pkgs.pixel-code;
      name = "Pixel Code";
    };

    # sansSerif = {
    #   package = pkgs.rubik;
    #   name = "Rubik";
    # };

    sansSerif = config.stylix.fonts.monospace;
    serif = config.stylix.fonts.sansSerif;

    sizes = {
      applications = 8;
      desktop = 8;
      popups = 8;
      terminal = 11;
    };
  };

  stylix.targets.qt.enable = true;

  stylix.cursor = {
    package = pkgs.capitaine-cursors-themed;
    name = "Capitaine Cursors (Gruvbox)";
    size = 32;
  };
}
