{ config, pkgs, ... }:
{
  stylix.enable = true;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
  stylix.image = ./gruvbox-rainbow-nix.png;
  stylix.fonts = {
    monospace = {
      package = pkgs.nerd-fonts.jetbrains-mono;
      name = "JetBrainsMono Nerd Font";
    };
    # sansSerif = config.stylix.fonts.monospace;
    # serif = config.stylix.fonts.monospace;
    # emoji = config.stylix.fonts.monospace;
  };
}
