{ ... }:
{
  programs.zellij = {
    enable = true;

    settings = {
      on_force_close = "detach";
      show_startup_tips = false;
    };
  };
}
