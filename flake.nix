{
  description = "my configuration for personal devices";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

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
  };

  outputs = { nixpkgs, home-manager, stylix, ... }@inputs:
  let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    homeConfigurations = {
      zie = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          ./stylix.nix
          ./home-modules/home.nix
          ./home-modules/rust-dev-tools.nix

          stylix.homeManagerModules.stylix
        ];

        extraSpecialArgs = { inherit inputs; };
      };
    };

    nixosConfigurations = {
      zie-nixos-laptop = lib.nixosSystem {
        inherit system;

        modules = [
          ./stylix.nix
          ./hosts/laptop/hardware-configuration.nix
          ./nixos-modules/configuration.nix

          stylix.nixosModules.stylix
        ];

        specialArgs = { inherit inputs; };
      };

      zie-nixos-desktop = lib.nixosSystem {
        inherit system;

        modules = [
          ./stylix.nix
          ./hosts/desktop/hardware-configuration.nix
          ./nixos-modules/configuration.nix

          stylix.nixosModules.stylix
        ];

        specialArgs = { inherit inputs; };
      };
    };
  };
}
