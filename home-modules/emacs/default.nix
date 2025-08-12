{ pkgs , ... }:
{
  stylix.targets.emacs.enable = false;

  home.packages = [ pkgs.emacs ];

  # we use mkOutOfStoreSymLink here because i want hot reloading type shit
  home.file = ".emacs" = config.lib.mkOutOfStoreSymLink /home/zie/.dotfiles/home-modules/emacs/emacs.el;

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
