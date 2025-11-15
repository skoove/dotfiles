{ pkgs, config, inputs, ... }:
{
  stylix.enable = true;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
  # stylix.image = "${inputs.wallpapers}/forest.jpg";
  stylix.fonts = {
    monospace = {
      package = pkgs.annotation-mono;
      name = "annotation mono";
    };

    sansSerif = {
      package = pkgs.rubik;
      name = "Rubik";
    };

    serif = config.stylix.fonts.sansSerif;

    sizes = {
      applications = 10;
      desktop = 10;
      popups = 10;
      terminal = 10;
    };
  };

  stylix.targets.qt.enable = true;

  stylix.cursor = {
    package = pkgs.capitaine-cursors-themed;
    name = "Capitaine Cursors (Gruvbox)";
    size = 32;
  };
}
