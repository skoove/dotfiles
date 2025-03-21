{ pkgs , ... }:
# dwarf-fortress.nix
{
  home.packages = [
    (pkgs.dwarf-fortress-packages.dwarf-fortress-full.override {
      dfVersion = "0.47.05";
      theme = pkgs.dwarf-fortress-packages.themes.wanderlust;
      enableTWBT = true;
    })
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "SDL_ttf-2.0.11" # wont rebuild df otherwise!
  ];
}
