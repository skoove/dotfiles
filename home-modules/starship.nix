{ ... }:
{
  stylix.targets.starship.enable = true;

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    
    settings = {
      add_newline = false;
      
      format = 
        "$username$hostname" +
        "$directory" +
        "$git_branch" +
        "$git_status" +
        "$nix_shell" +
        "$character";

      username = {
        style_root = "bold red";
        style_user = "bold purple";
        show_always = true;
        format = "[$user]($style)[@](blue)";
      };

      hostname = {
        ssh_only = false;
        format = "[$hostname]($style) ";
        style = "bold green";
      };

      directory = {
        fish_style_pwd_dir_length = 1;
        truncate_to_repo = true;
        style = "blue";
        read_only_style = "red";
        read_only = "";
      };

      git_branch = {
        format = "[$branch ]($style)";
        style = "bold purple";
      };

      git_status = {
        format = "([\\[$all_status$ahead_behind\\] ]($style))";
        style = "bold red";
        conflicted = "=";
        ahead = ">";
        behind = "<";
        diverged = "<>";
        up_to_date = "";
        untracked = "?";
        stashed = "s";
        modified = "!";
        staged = "+";
        renamed = ">>";
        deleted = "x";
        typechanged = "";
      };

      nix_shell = {
        format = "[\\(nix-shell\\)](bold cyan) ";
      };

      character = {
        format = "$symbol ";
        success_symbol = "[>](bold green)";
        error_symbol = "[>](bold red)";
        vimcmd_symbol = "[<](bold green)";
        vimcmd_visual_symbol = "[<](bold yellow)";
      };
    };
  };
}
