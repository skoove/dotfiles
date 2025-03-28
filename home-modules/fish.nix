{ ... }:
{
  imports = [ ./direnv.nix ];

  programs.zoxide.enable = true;

  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting
      set fish_vi_key_bindings
    '';

    shellAbbrs = {
      gco = "git checkout";
      gsw = "git switch";
      gcl = "git clone";
      gc = "git commit";
      gp = "git push";
      ga = "git add";
      gs = "git status";
      gd = "git diff";
      gf = "git fetch";

      nr = "nix run";

      lv = "loago view -m";
      ld = "loago do";
      lrm = "loago rm";
    };

    functions = {
      __fish_command_not_found_handler = {
        body = "echo \"TRY AGAIN STUPID: $argv\"";
      };
    };
  };
}
