{ ... }:
{
  programs.git = {
    enable = true;
    userName = "Zie Sturges";
    userEmail = "53106860+skoove@users.noreply.github.com";
    extraConfig.init.defaultBranch = "main";
    delta.enable = true;
  };
}
