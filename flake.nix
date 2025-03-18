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
  };

  outputs = { self, nixpkgs, home-manager, stylix, nixcord,  ... }:
  let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    pkgs = nixpkgs.legacyPackages.${system};

    settings = {
      hyprland-enabled = true; # bool
    };

    sharedHomeModules = [
      stylix.homeManagerModules.stylix
      nixcord.homeManagerModules.nixcord
      ./home-modules/home.nix
      ./home-modules/nixcord.nix
      ./home-modules/hyprland.nix
      ./home-modules/git.nix
      ./home-modules/helix.nix
      ./home-modules/syncthing.nix
      ./stylix.nix
    ];

    sharedNixosModules = [
      stylix.nixosModules.stylix
      ./nixos-modules/configuration.nix
      ./stylix.nix
    ];

    sharedArgs = {
      inherit settings;
    };
  in {
    homeConfigurations = {
      zie = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = sharedHomeModules ++ [ ];
        extraSpecialArgs = sharedArgs;
      };
    };

    nixosConfigurations = {
      zie-nixos-laptop = lib.nixosSystem {
        inherit system;
        modules = sharedNixosModules ++ [ ./hosts/laptop/hardware-configuration.nix ];
        specialArgs = sharedArgs;
      };

      zie-nixos-desktop = lib.nixosSystem {
        inherit system;
        modules = sharedNixosModules ++ [ ./hosts/desktop/hardware-configuration.nix ];
        specialArgs = sharedArgs;
      };
    };
  };
}
