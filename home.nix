# file : home.nix
# managed by : home manager
{ config, pkgs, lib,  ... }:

{
  home.username = "zie";
  home.homeDirectory = "/home/zie";

  home.stateVersion = "24.05";

  imports = [ ./colors.nix ./i3wm.nix ];

  # --- packages --- #
  home.packages = (with pkgs;[ 
    vesktop                 # vencord discord client
    pavucontrol             # volume control for puse audio
    obsidian                # note taking app
    syncthing syncthingtray # file syncing
    nil                     # nix lsp
    feh                     # image viewer and background settter
    wine protonup-ng        # windows compatibility things
    gst_all_1.gstreamer
    fastfetch cowsay blahaj # neccercary for the system to run correctly
    maim xclip              # things for screenshots
    nix-output-monitor      # pretty nix building
    ripgrep                 # grep but rust
    xmousepasteblock        # blocks mmb paste
    bottom                  # top
    dust                    # disk usage things
    xorg.xev                # for checking keycodes mostly
    gamemode                # makes games run better
    catppuccin-cursors.mochaLavender
    lxappearance
    dconf
    unzip
    tree
    git lazygit gh
    prismlauncher
    obs-studio
    kitty
    ranger
    rust-analyzer
    vscode
    onlyoffice-bin_latest
    krita
    playerctl
    siril
    dxvk
    mangohud
    python3
    protontricks
    nushell
    starship
  ]);
    
  catppuccin = {
    enable = true;
    accent = "lavender";
    flavor = "mocha";
  };

  # --- programs config --- #
  programs = {
    git = {
      enable = true;
      userName = "zie";
      userEmail = "zac@sturges.com.au";
      extraConfig.init.defaultBranch = "main";
    };
  
    rofi = {
      enable = true;
    };

    # helix #
    helix = {
      enable = true;
      defaultEditor = true;

      settings = {
        editor.line-number = "relative";
        editor.indent-guides.render = true;
        editor.indent-guides.character = "│";
      };
    
      languages = {
        nix = [{
          name = "nix";
        }];
        rust = [{
          name = "rust";
        }];
      };
    };

    # kitty #
    kitty = {
      enable = true;
      font = {
        name = "JetBrainsMonoNL NF";
        package = pkgs.nerdfonts;
        size = 11;
      };
      settings = {
        window_padding_width = "1";
        confirm_os_window_close = "0";
      };
    };

    # make bash run nushell on start
    bash.bashrcExtra = "nu";

    nushell = {
      enable = true;

      shellAliases = {
        collect-garbage = "sh ~/.dotfiles/scripts/collect-garbage.sh";
        update-flake = "sh ~/.dotfiles/scripts/update-flake.sh";
        update-home  = "sh ~/.dotfiles/scripts/update-home.sh";
        update-nixos = "sh ~/.dotfiles/scripts/update-nixos.sh";
      };

      extraConfig = ''
        $env.config.show_banner = false;

        cat `~/obsidian/99 Meta/reminders.md`
      '';

      extraEnv = ''
        mkdir ~/.cache/starship
        starship init nu | save -f ~/.cache/starship/init.nu
      '';
    };
  };

  programs.starship = {
    enable = true;
  };

  # --- picom settings --- #
  services.picom = {
    enable = true;
    fade = false;
    inactiveOpacity = 1;
    settings = {
      corner-radius = 0;
      round-borders = 0;     
    };
  };

  home.file = {};

  home.sessionVariables = {};

  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
}
