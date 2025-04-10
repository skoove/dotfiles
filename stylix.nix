{ pkgs, config, ... }:
{
  stylix.enable = true;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
  stylix.image = ./wallpapers/houseonthesideofalake.jpg;
  stylix.fonts = {
    monospace = {
      package = pkgs.nerd-fonts.jetbrains-mono;
      name = "JetBrainsMono Nerd Font";
    };

    sansSerif = config.stylix.fonts.monospace;
    serif = config.stylix.fonts.monospace;
    # emoji = config.stylix.fonts.monospace;

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
