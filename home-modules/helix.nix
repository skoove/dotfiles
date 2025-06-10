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

      keys.normal = {
        space.q = ":reflow";
      };
    };

    languages = {

      language-server.tinymist.config = {
        formatterMode = "typstyle";
        exportPdf = "onSave";
        outputPath = "$root/target/$dir/$name";
        preview.browsing.args = ["--data-plane-host=127.0.0.1:0" "--invert-colors=never" "--open"];
      };
      
      language-server.harper = {
        command = "${pkgs.harper}/bin/harper-ls";
        args = [ "--stdio" ];

        config.harper-ls = {
          dialect = "Australian";
        };
      };

      language-server.fish-lsp = {
        command = "${pkgs.fish-lsp}/bin/fish-lsp";
        args = [ "start" ];
        environment = { "fish_lsp_show_client_popups" = "false"; };
      };

      language = [
      {
        name = "fish";
        language-servers = [ "fish-lsp" ];
      }
      {
        name = "rust";
        language-servers = [ "rust-analyzer"];
      }
      {
        name = "nix";
        language-servers = [ "nixd"];
      }
      {
        name = "markdown";
        soft-wrap.enable = true;
        rulers = [80];
        language-servers = [ "harper" ];
      }
      {
        name = "typst";
        rulers = [80];
        auto-format = true;
        language-servers = [ "tinymist" "harper" ];
      }
      ];
    };
  };
}
