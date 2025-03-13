{
  description = "my configuration for personal devices";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:danth/stylix";
  };

  outputs = { self, nixpkgs, home-manager, stylix,  ... }:
  let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    homeConfigurations = {
      zie = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          stylix.homeManagerModules.stylix
          ./home.nix
          ./stylix.nix
        ];
      };
    };

    nixosConfigurations = {
      nixos-laptop = lib.nixosSystem {
        inherit system;
        modules = [
          stylix.nixosModules.stylix
          ./configuration.nix
          ./stylix.nix
        ];
      };
    };
  };
}
