{ ... }:
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
      language = [
      {
        name = "markdown";
        soft-wrap.enable = true;
      }
      {
        name = "typst";
        rulers = [80];
      }
      ];

    };
  };
}
