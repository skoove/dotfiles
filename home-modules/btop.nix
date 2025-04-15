{ ... }:
{
  stylix.targets.btop.enable = false;
  
  programs.btop = {
    enable = true;

    settings = {
      color_theme = "gruvbox_dark_v2";
      update_ms = 100;
      proc_sorting = "cpu_lazy";
    };
  };
}
