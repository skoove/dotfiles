{ pkgs , ... }:
{
  home.packages = [ pkgs.kakoune ];

  home.file.".config/kak/kakrc".source = pkgs.writeText "kakrc" ''
    colorscheme gruvbox-dark
  '';
}
