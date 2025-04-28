{ pkgs , ... }:
{
  stylix.targets.helix.enable = false;
  programs.helix = {
    enable = true;

    settings = {
      theme = "gruvbox";

      editor = {
        line-number = "relative";
        true-color = true;
        bufferline = "multiple";
        cursorline = true;
        completion-timeout = 5;
        soft-wrap.wrap-at-text-width = true;
        end-of-line-diagnostics = "hint";
        inline-diagnostics.cursor-line = "warning";
        indent-guides.render = true;
        auto-save.after-delay.enable = true;
        gutters.layout = [ "line-numbers" "spacer" "diff" ];
      };
    };

    languages = {

      language-server.tinymist.config.formatterMode = "typstyle";
      
      language-server.typos = {
        command = "${pkgs.typos-lsp}/bin/typos-lsp";
      };

      language-server.ltex-ls = {
        command = "${pkgs.ltex-ls-plus}/bin/ltex-ls-plus";

        config = {
          ltex.language = "en-AU";
          ltex.enabled = "typst";
          ltex.disabledRules = { 
            "en-AU" = [
              "ARROWS"
              "EN_UNPAIRED_BRACKETS"
              "MORFOLOGIK_RULE_EN_AU"
            ];
          };
        };
      };

      language = [
      {
        name = "rust";
        language-servers = [ "rust-analyzer" "typos" ];
      }
      {
        name = "nix";
        language-servers = [ "nixd" "typos" ];
      }
      {
        name = "markdown";
        soft-wrap.enable = true;
        language-servers = [ "typos" ];
      }
      {
        name = "typst";
        rulers = [80];
        auto-format = true;
        language-servers = [ "tinymist" "typos" "ltex-ls"];
      }
      ];
    };
  };
}
