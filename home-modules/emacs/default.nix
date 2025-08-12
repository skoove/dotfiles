{ pkgs , ... }:
{
  stylix.targets.emacs.enable = false;

  home.packages = [ pkgs.emacs-gtk ];

  services.emacs = {
    enable = true;
    package = with pkgs; (
        (emacsPackagesFor emacs-gtk).emacsWithPackages (
          epkgs: with epkgs; [
            vertico
          ]
        )
      );
  };
}
