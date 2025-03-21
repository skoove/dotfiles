{ pkgs , ... }:
# dwarf-fortress.nix
{
  home.packages = [
    (pkgs.dwarf-fortress-packages.dwarf-fortress-full.override {
      dfVersion = "0.47.05";
      theme = pkgs.dwarf-fortress-packages.themes.wanderlust;
      enableIntro = false;
      enableDFHack = true;
      enableTWBT = true;
      enableTruetype = true;
    })
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "SDL_ttf-2.0.11" # wont rebuild df otherwise!
  ];
}
