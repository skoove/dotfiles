{ ... }:
{
  programs.git = {
    enable = true;
    userName = "Zie";
    userEmail = "zie@skoove.dev";
    delta.enable = true;

    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };
}
