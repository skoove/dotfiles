{ pkgs , ... }:
{
  imports = [
    ./starship.nix
  ];
  
  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };
  
  programs.nushell = {
    enable = true;

    settings = {
      buffer_editor = "${pkgs.helix}";
      
    };

    shellAliases = {
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

      lv = "loago view -m";
      ld = "loago do";
      lrm = "loago remove";
    };
  };
}
