{ pkgs , config , lib , ... }:
{
  # for some reason not doing this causes build faliures, i belive because i do
  # not use the community overlay for emacs, i prefer using normal themes for
  # editors anyway
  stylix.targets.emacs.enable = false;

  home.packages = with pkgs; [
    (aspellWithDicts
      (dicts: with dicts; [ en en-computers en-science ]))
  ];
  
  # we use mkOutOfStoreSymLink here because i want hot reloading type shit
  home.file.".emacs".source = config.lib.file.mkOutOfStoreSymlink /home/zie/.dotfiles/home-modules/emacs/emacs.el;
  home.file.".emacs.d/trans-flag.png".source = ../../files/assets/trans-flag.png;
  home.file.".emacs.d/lisp/org-typst-preview.el".source = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/remimimimimi/org-typst-preview.el/refs/heads/main/org-typst-preview.el";
    hash = "sha256-VYklC4GlkTXf/e3DX7cdSmaD7EB4IQH9xXidtcj6IC8=";
  };

  # the service just inherits the package from programs.emacs.package if
  # programs.emacs.enable = true so i dont need to actually do anything but
  # enable it :D
  services.emacs.enable = true;

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
          general
          consult
          elcord
          markdown-mode
          visual-fill-column
        ]
      )
    );
  };
}
