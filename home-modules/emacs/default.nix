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
        epkgs: with epkgs;  [
          use-package # used to config packages
          vertico # vertical buffer stuff
          orderless # alterntive matching thing
          marginalia # little things next to M-x commands
          direnv # use dev env
          treesit-auto treesit-grammars.with-all-grammars # tressitter
          markdown-mode # markdown majour mode
	        nix-mode # nix majour mode
          gruvbox-theme # theme
          meow meow-tree-sitter # meow modal editing
          dashboard # nice dashboard with recent file sand stuff
          general # nice key rebinding
          consult # nice stuff for searching around
          elcord # duiscord ritch presenfce
          visual-fill-column # soft wrapping at collumn thing
          org-node # zettle ts
          org-bullets # make org look a biut nicer
          all-the-icons nerd-icons # icons
          page-break-lines # nice lines for page breaks
        ]
      )
    );
  };
}
