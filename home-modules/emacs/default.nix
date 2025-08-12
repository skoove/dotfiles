{ pkgs , config , ... }:
{
  stylix.targets.emacs.enable = false;

  # we use mkOutOfStoreSymLink here because i want hot reloading type shit
  home.file.".emacs".source = config.lib.file.mkOutOfStoreSymlink /home/zie/.dotfiles/home-modules/emacs/emacs.el;

  programs.emacs = {
    enable = true;
    package = with pkgs; (
        (emacsPackagesFor emacs).emacsWithPackages (
          epkgs: with epkgs; [
            vertico
            markdown-mode
          ]
        )
      );
  };

  services.emacs.enable = true;
}
