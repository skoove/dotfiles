{ pkgs , ... }:
{
  home.packages = [ (pkgs.kakoune.override { plugins = [];  }) ];

  home.file.".config/kak/kakrc".source = pkgs.writeText "kakrc" ''
    colorscheme gruvbox-dark

    set-option global ui_options terminal_assistant=cat
  '';
}
