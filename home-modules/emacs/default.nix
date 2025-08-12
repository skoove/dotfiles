{ pkgs , ... }:
{
  stylix.targets.emacs.enable = false;

  home.packages = [ pkgs.emacs ];

  services.emacs = {
    enable = true;
    package = with pkgs; (
        (emacsPackagesFor emacs).emacsWithPackages (
          epkgs: with epkgs; [
            vertico
          ]
        )
      );
  };
}
