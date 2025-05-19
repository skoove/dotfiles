{ ... }:
{
  programs.git = {
    enable = true;
    userName = "Zie Sturges";
    userEmail = "zie@sturges.com.au";
    delta.enable = true;

    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };
}
