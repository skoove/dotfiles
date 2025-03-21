{ ... }:
{
  programs.git = {
    enable = true;
    userName = "Zie Sturges";
    userEmail = "zie@sturges.com.au";
    extraConfig.init.defaultBranch = "main";
    delta.enable = true;
  };
}
