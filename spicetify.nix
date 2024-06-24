{ pkgs, spicetify-nix , ...  }:
let
  spicePkgs = spicetify-nix.packages.${pkgs.system}.default;
in
{
  imports = [ spicetify-nix.homeManagerModule ];

  programs.spicetify = {
    spotifyPackage = pkgs.spotifywm;
    enable = true;
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";
    # windowManagerPatch = true; # trying to use the default spotify package seems to break things

    enabledExtensions = with spicePkgs.extensions; [
      shuffle
      adblock
      volumePercentage
      fullAppDisplay
      # genre # borked
    ];
  };
}
