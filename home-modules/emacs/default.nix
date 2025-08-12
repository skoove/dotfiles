{ pkgs , config , ... }:
{
  # for some reason not doing this causes build faliures, i belive because i
  # do not use the community overlay for emacs, i prefer using normal themes for
  # editors anyway
  stylix.targets.emacs.enable = false;
  
  # we use mkOutOfStoreSymLink here because i want hot reloading type shit
  home.file.".emacs".source = config.lib.file.mkOutOfStoreSymlink /home/zie/.dotfiles/home-modules/emacs/emacs.el;

  programs.emacs = {
    enable = true;
    package = with pkgs; (
      (emacsPackagesFor emacs).emacsWithPackages (
        epkgs: with epkgs; [
          use-package
          vertico
          orderless
          marginalia
          direnv
          treesit-auto treesit-grammars.with-all-grammars
          nix-ts-mode
	  gruvbox-theme
        ]
      )
    );
  };
}
