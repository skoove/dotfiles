{ pkgs , ... }:
{
  home.packages = [ pkgs.nixd ];
  
  stylix.targets.helix.enable = false;
  programs.helix = {
    enable = true;

    settings = {
      theme = "gruvbox";

      editor = {
        auto-save.after-delay.enable = true;
        bufferline = "always";
        completion-timeout = 5;
        cursorline = true;
        end-of-line-diagnostics = "hint";
        gutters.layout = [ "line-numbers" "spacer" "diff" ];
        indent-guides.render = true;
        inline-diagnostics.cursor-line = "error";
        line-number = "relative";
        soft-wrap.wrap-at-text-width = true;
        true-color = true;
      };

      keys.normal = {
        space.q = ":reflow";

        A-h = "jump_view_left";
        A-j = "jump_view_down";
        A-k = "jump_view_up";
        A-l = "jump_view_right";
      
        A-H = "swap_view_left";
        A-J = "swap_view_down";
        A-K = "swap_view_up";
        A-L = "swap_view_right";
      
        space.space = {
          d = ":insert-output date --iso";
          c = ":buffer-close";
        };
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
        rulers = [80];
        language-servers = [ "harper" ];
        soft-wrap.enable = true;
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
