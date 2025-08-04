{
  description = "my configuration for personal devices";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixcord = {
      url = "github:kaylorben/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
   };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    blender = {
      url = "github:edolstra/nix-warez?dir=blender";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wallpapers = {
      url = "github:skoove/wallpapers";
      flake = false;
    };
  };

  outputs = {nixpkgs, niri, ... }@inputs:
  let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations = {
      nixos-laptop = lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };

        modules = [
          ./hosts/laptop/hardware-configuration.nix
          ./nixos-modules/configuration.nix
        ];

      };

      nixos-desktop = lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };

        modules = [
          ./hosts/desktop/hardware-configuration.nix
          ./nixos-modules/configuration.nix
        ];
      };
    };
  };
}
