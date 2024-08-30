{ pkgs, spicetify-nix , ...  }:
let
  spicePkgs = spicetify-nix.packages.${pkgs.system}.default;
in
{
  imports = [ spicetify-nix.homeManagerModule ];

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
