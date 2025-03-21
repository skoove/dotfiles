{ ... }:
{
  programs.zellij = {
    enable = true;

    settings = {
      on_force_close = "quit";
      show_startup_tips = false;
    };
  };
}
