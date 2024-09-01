{ pkgs, inputs , spicetify-nix ,   ...  }:
let
  spicePkgs = spicetify-nix.legacyPackages.${pkgs.system};
in
{
  imports = [spicetify-nix.homeManagerModules.default];

  programs.spicetify = {
    spotifyPackage = pkgs.spotify;
    enable = true;
    theme = spicePkgs.themes.catppuccin; 
    colorScheme = "mocha";
    windowManagerPatch = true; 

    enabledExtensions = with spicePkgs.extensions; [
      shuffle
      adblock
      volumePercentage
      fullAppDisplay
    ];
 };
}
