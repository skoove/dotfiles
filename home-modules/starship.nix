{ ... }:
{
  stylix.targets.starship.enable = true;

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    
    settings = {
      format = 
        "$username$hostname" +
        "$directory" +
        "$nix_shell" +
        "$character";

      username = {
        style_root = "bold red";
        style_user = "bold yellow";
        show_always = true;
        format = "[$user]($style)[@](blue)";
      };

      hostname = {
        ssh_only = false;
        format = "[$hostname]($style) ";
        style = "bold green";
      };

      directory = {
        fish_style_pwd_dir_length = 5;
        truncate_to_repo = true;
        style = "blue";
        read_only_style = "red";
        read_only = "";
      };

      nix_shell = {
        format = "[\\(nix-shell\\)](bold cyan) ";
      };

      character = {
        format = "$symbol ";
        success_symbol = "[>](green)";
        error_symbol = "[>](red)";
        vimcmd_symbol = "[<](green)";
        vimcmd_visual_symbol = "[<](yellow)";
      };
    };
  };
}
