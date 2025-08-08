{ pkgs, config, inputs, ... }:
{
  stylix.enable = true;
  stylix.base16Scheme = ./themes/harsh-dark.yaml;
  stylix.image = "${inputs.wallpapers}/farewell-saturn.jpg";
  stylix.fonts = {
    monospace = {
      package = pkgs.nerd-fonts.jetbrains-mono;
      name = "JetBrainsMono NF";
    };

    sansSerif = {
      package = pkgs.rubik;
      name = "Rubik";
    };

    serif = config.stylix.fonts.sansSerif;

    sizes = {
      applications = 9;
      desktop = 9;
      popups = 9;
      terminal = 9;
    };
  };

  stylix.targets.qt.enable = true;

  stylix.cursor = {
    package = pkgs.capitaine-cursors-themed;
    name = "Capitaine Cursors (Gruvbox)";
    size = 32;
  };
}
