{ pkgs , ... }: let
  plugin = name: (pkgs.callPackage ./plugins/${name}.nix { inherit pkgs; });
  pluginsFromList = names: map plugin names;
in {
  home.packages = [ (pkgs.kakoune.override { plugins = pluginsFromList [
    "kak-lsp"
  ]; }) ];

  home.file.".config/kak/kakrc".source = pkgs.writeText "kakrc" ''
    colorscheme gruvbox-dark

    set-option global ui_options terminal_assistant=cat
    lsp-enable
  '';
}
