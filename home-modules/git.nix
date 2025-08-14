{ ... }:
{
  programs.git = {
    enable = true;
    userName = "Zie";
    userEmail = "53106860+skoove@users.noreply.github.com";
    delta.enable = true;

    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      core.editor = "emacsclient -nw";
    };
  };
}
