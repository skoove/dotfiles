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
      gpu = "git pull";
      gg = "git log --oneline --graph";
      gl = "git log";
      gll = "git log --oneline";
      gc = "git commit";
      gp = "git push";
      ga = "git add";
      gs = "git status";
      gd = "git diff";
      gf = "git fetch";

      nr = "nix run";

      lv = "loago view -m";
      ld = "loago do";
      lrm = "loago remove";
    };

    functions = {
      __fish_command_not_found_handler = {
        body = "echo \"command not found :(\"";
      };

      # source: https://axlefublr.github.io/uri-list/
      pick = {
        body = "echo file://(realpath $argv[1]) | wl-copy -t text/uri-list";
      };

      mk-snippet = {
        body = builtins.readFile ../scripts/mk-snippet.fish;
      };

      search = {
        body = "find | rg -i $argv[1]";
      };

      update-flake = {
        body = "cd ~/.dotfiles; nix flake update; git commit -am 'flake.lock: update'; git push; nh os switch";
      };
    };
  };
}
