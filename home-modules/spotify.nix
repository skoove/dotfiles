{ inputs, pkgs, ... }:
let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in { 
  imports = [ inputs.spicetify-nix.homeManagerModules.default ];

  programs.spicetify = {
    enable = true;

    enabledExtensions = with spicePkgs.extensions; [
      adblock
      autoSkipVideo
      fullAlbumDate
      betterGenres
    ];
  };
}
