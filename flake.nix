{
  description = "my configuration for personal devices";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:danth/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";

    nixcord.url = "github:kaylorben/nixcord";
    nixcord.inputs.nixpkgs.follows = "nixpkgs";

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    spicetify-nix.inputs.nixpkgs.follows = "nixpkgs";
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
          inputs.stylix.homeManagerModules.stylix
          ./home-modules/home.nix
          ./home-modules/rust-dev-tools.nix
        ];

        extraSpecialArgs = { inherit inputs; };
      };
    };

    nixosConfigurations = {
      zie-nixos-laptop = lib.nixosSystem {
        inherit system;

        modules = [
          inputs.stylix.nixosModules.stylix
          ./hosts/laptop/hardware-configuration.nix
          ./nixos-modules/configuration.nix
        ];

        specialArgs = { inherit inputs; };
      };

      zie-nixos-desktop = lib.nixosSystem {
        inherit system;

        modules = [
          inputs.stylix.nixosModules.stylix
          ./hosts/desktop/hardware-configuration.nix
          ./nixos-modules/configuration.nix
        ];

        specialArgs = { inherit inputs; };
      };
    };
  };
}
