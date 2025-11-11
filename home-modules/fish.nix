{ pkgs, lib, ... }:
{
  imports = [
    ./direnv.nix
    ./starship.nix
  ];

  programs.zoxide.enable = true;

  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting
    '';

    shellAbbrs = {
      gwip = "git commit -a -m 'wip'";
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

      rman = "rusty-man --viewer tui";

      errm = "${pkgs.cowsay}/bin/cowsay -f actually";
    };

    functions = {
      __fish_command_not_found_handler = {
        body = "echo \"command not found :(\"";
      };

      em = {
        body = "emacsclient -c $argv & disown";
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
        body = ''
          sudo echo sudoed
          cd ~/.dotfiles
          nix flake update --commit-lock-file
          git push & disown
          loago do update-flake
          nh os switch'';
      };

      # open or create svg
      is = {
        body = ''
          set file $argv[1]

          if test -e $file
              inkscape $file & disown
          else
              cp ${../files/inkscape/default-document.svg} $file
              chmod 744 $file
              inkscape $file & disown
          end
        '';
      };

      sys = {
        body = ''
            ${lib.getExe pkgs.systemd-manager-tui}
          '';
      };

      pomodoro = {
        body = "porsmo pomodoro custom 25m 5m 15m";
      };
    };
  };
}
