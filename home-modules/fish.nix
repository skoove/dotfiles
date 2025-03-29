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
      g = "git";
      d = "diff";
      a = "add";
      pu = "pull";
      p = "push";
      cl = "clone";
      co = "checkout";
      sw = "switch";
      l = "log --oneline --graph";
      ll = "log";
      c = "commit";
      s = "status";
      f = "fetch";

      nr = "nix run";

      lv = "loago view -m";
      ld = "loago do";
      lrm = "loago rm";
    };

    functions = {
      __fish_command_not_found_handler = {
        body = "echo \"command not found :(\"";
      };

      mk-snippet = {
        body = builtins.readFile ../scripts/mk-snippet.fish;
      };
    };
  };
}
