{ ... }:
{ 
  stylix.targets.helix.enable = false;
  programs.helix = {
    enable = true;
    settings = {
      theme = "gruvbox";
      editor = {
        indent-guides.render = true;
        line-number = "relative";
      };
    };
  };
}
