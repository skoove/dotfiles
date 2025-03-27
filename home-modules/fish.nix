{ ... }:
{
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting
      set fish_vi_key_bindings
    '';

    shellAbbrs = {
      gco = "git checkout";
      gsw = "git switch";
      gc = "git commit";
      gp = "git push";
      ga = "git add";

      nixsrc = "open \"https://mynixos.com/search?q=";
    };
  };
}
