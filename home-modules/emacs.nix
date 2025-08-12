{ pkgs , ... }:
{
  stylix.targets.emacs.enable = false;

  programs.emacs = {
    enable = true;
    package = pkgs.emacs;
  };

  services.emacs = {
    enable = true;
    package = pkgs.emacs-gtk;
  };
}
