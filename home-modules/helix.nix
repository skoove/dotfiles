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
        end-of-line-diagnostics = "hint";
        inline-diagnostics.cursor-line = "warning";
        indent-guides.render = true;
        auto-save.after-delay.enable = true;
        gutters.layout = [ "line-numbers" "spacer" "diff" ];
      };
    };
  };
}
