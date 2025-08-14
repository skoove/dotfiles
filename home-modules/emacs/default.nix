{ pkgs , config , lib , ... }:
{
  # for some reason not doing this causes build faliures, i belive because i
  # do not use the community overlay for emacs, i prefer using normal themes for
  # editors anyway
  stylix.targets.emacs.enable = false;
  
  # we use mkOutOfStoreSymLink here because i want hot reloading type shit
  home.file.".emacs".source = config.lib.file.mkOutOfStoreSymlink /home/zie/.dotfiles/home-modules/emacs/emacs.el;
  home.file.".emacs.d/trans-flag.png".source = ../../files/assets/trans-flag.png;

  programs.emacs = {
    enable = true;
    package = with pkgs; (
      (emacsPackagesFor emacs-gtk).emacsWithPackages (
        epkgs: with epkgs; [
          use-package
          vertico
          orderless
          marginalia
          direnv
          treesit-auto treesit-grammars.with-all-grammars
	        nix-mode
          gruvbox-theme
          meow meow-tree-sitter
          dashboard

          (
            {
              trivialBuild,
              fetchFromGitHub,
            }:
            trivialBuild rec {
              pname = "org-typst-preview";
              version = "main-2025-08-14";
              src = fetchFromGitHub {
                owner = "remimimimimi";
                repo = "org-typst-preview.el";
                rev = "de334cf3daa84b23ceea2a9fc70b6787f7c6af5b";
                hash = "";
              };
              # elisp dependencies
              propagatedUserEnvPkgs = [
                # all-the-icons
              ];
              buildInputs = propagatedUserEnvPkgs;
            }
          )
        ]
      )
    );
  };
}
