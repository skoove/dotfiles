{
  description = "epic gamer";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    catppuccin.url = "github:catppuccin/nix";

    spicetify-nix.url = "github:Greg-L/spicetify-nix";
  };

  outputs = { spicetify-nix , nixpkgs, home-manager, catppuccin,  ... }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
    in {

      nixosConfigurations = {
        nixos = lib.nixosSystem {
          inherit system;
  	      modules = [
            ./configuration.nix
            ./hostname.nix
            /etc/nixos/hardware-configuration.nix	
            catppuccin.nixosModules.catppuccin
          ];
        };
      };

      homeConfigurations = {
        zie = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {inherit spicetify-nix;};
          modules = [
          ./home.nix 
          catppuccin.homeManagerModules.catppuccin
          ./spicetify.nix
          ./i3wm.nix
          ];
        };
      };
    };
}
