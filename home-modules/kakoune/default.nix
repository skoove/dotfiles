{ pkgs , ... }: let
  plugin = name: (pkgs.callPackage ./plugins/${name}.nix { inherit pkgs; });
  pluginsFromList = names: map plugin names;
in {
  home.packages = with pkgs; [
    (pkgs.kakoune.override { plugins = pluginsFromList [
      "kak-lsp"
      "kak-tree-sitter"
      "ashen-theme"
    ]; })

    nil # nix lsp
  ];

  home.file.".config/kak/kakrc".source = pkgs.writeText "kakrc" ''
    eval %sh{ kak-tree-sitter -dks --init $kak_session }
    colorscheme ashen # TODO: find gruvbox theme for kak-tree-sitter, or make one

    set-option global ui_options terminal_assistant=cat
    set-option global tabstop 4
    set-option global indentwidth 4
    set-option global scrolloff 1,4

    define-command -override tree-sitter-user-after-highlighter %{
      add-highlighter -override buffer/show-matching show-matching
    }

    add-highlighter global/ number-lines -hlcursor
    add-highlighter global/ show-whitespaces -spc " "

    map global user b ": delete-buffer<ret>" -docstring "close current buffer"
    map global user n ": buffer-previous<ret>" -docstring "previous buffer"
    map global user m ": buffer-next<ret>" -docstring "next buffer"

    # tab complete instead of silly complete, also makes it so tab gets entered if there are no completions
  	hook global InsertCompletionShow .* %{
    	map global insert <tab> <c-n>
    	map global insert <s-tab> <c-p>
    }
    hook global InsertCompletionHide .* %{
    	unmap global insert <tab>
    	unmap global insert <s-tab>
    }

    eval %sh{kak-lsp}
    lsp-enable
    map global user l ": enter-user-mode lsp<ret>" -docstring 'lsp mode'
    map global insert <tab> '<a-;>:try lsp-snippets-select-next-placeholders catch %{ execute-keys -with-hooks <lt>tab> }<ret>' -docstring 'Select next snippet placeholder'
  '';
}
