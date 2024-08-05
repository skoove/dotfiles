# file : home.nix
# managed by : home manager
{ config, pkgs, lib, ... }:

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
    libreoffice             # office apps
    nil                     # nix lsp
    feh                     # image viewer and background settter
    wine protonup-ng        # windows compatibility things
    gst_all_1.gstreamer
    fastfetch cowsay blahaj # neccercary for the system to run correctly
    maim xclip              # things for screenshots
    zsh                     # shell
    nix-output-monitor      # pretty nix building
    ripgrep                 # grep but rust
    xmousepasteblock        # blocks mmb paste
    bottom                  # top
    dust                    # disk usage things
    xorg.xev                # for checking keycodes mostly
    gamemode                # makes games run better (?)
    catppuccin-cursors.mochaLavender
    lxappearance
    dconf
    unzip
    tree
    git lazygit gh
    prismlauncher
    xpointerbarrier        # i only use this to play warthunder
    r2mod_cli
    obs-studio
    vscode                 # vs code :shocked:
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

    # alacritty #
    alacritty = {
      enable = true;
      
      settings = {
        shell.program = "${pkgs.zsh}/bin/zsh";
        window.padding = {x = 10; y = 10;};
        font.normal = {family = "JetBrainsMonoNL Nerd Font";};
      };
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
        language = [{
          name = "nix";
        }];
      };
    };

    # zsh #
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      oh-my-zsh = {
        enable = true;
        theme = "xiong-chiamiov";
      };

      initExtra = "fastfetch";

      # zsh alias #
      shellAliases = {
        edit-config = "hx ~/.dotfiles";

        mon-2-off = "xrandr --output DVI-I-1 --off";
        mon-2-on = "xrandr --output HDMI-0 --primary --mode 1920x1080 --rate 100 --output DVI-I-1 --auto --right-of HDMI-0";

        # updating things #
        upd-flake = ''
          nix flake update ~/.dotfiles
          echo "flake updated!" |& blahaj -i
        '';

        upd-home = ''
          nix flake update ~/.dotfiles
          echo "flake updated!" |& blahaj -i
          home-manager switch --flake ~/.dotfiles |& nom
          echo "home managed" | blahaj -i
        '';

        upd-nixos = ''
          sudo echo ""
          nix flake update ~/.dotfiles
          echo "flake updated!" |& blahaj -i
          sudo nixos-rebuild switch --flake ~/.dotfiles --impure |& nom
          echo "nixos rebuilt!" | blahaj -i
        '';
      };
    };
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
