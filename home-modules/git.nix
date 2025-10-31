{ ... }:
{
  programs.delta.enable = true;
  programs.delta.enableGitIntegration = true;
  
  programs.git = {
    enable = true;

    settings = {
      init.defaultBranch = "main";
      pull.rebase = true;
      user.name = "skoove";
      user.email = "zie@skoove.dev";
    };
  };
}
