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
    lutris                  # vidya games
    wine protonup-ng        # windows compatibility things
    gst_all_1.gstreamer
    fastfetch cowsay blahaj # neccercary for the system to run correctly
    nvtopPackages.full      # preforamnce monitor for ninvida cards
    maim xclip              # things for screenshots
    zsh                     # shell
    nix-output-monitor      # pretty nix building
    ripgrep                 # grep but rust
    xmousepasteblock        # blocks mmb paste
    kdePackages.okular      # document visualiser
    bottom                  # top
    dust                    # disk usage things
    xorg.xev                # for checking keycodes mostly
    gamemode                # makes games run better (?)
    dconf
    lxappearance
    catppuccin-cursors.mochaLavender
    unzip
    tree
    gamescope
    opentrack
    git lazygit
  ]);

  catppuccin = {
    enable = true;
    accent = "rosewater";
    flavor = "mocha";
  };

  # --- programs config --- #
  programs = {
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
        # hey future zie,, i know your reading this because
        # you were trying to workout why your alacritty is
        # not sexy, and its because the theme needs to be downloaded
        # just run
        # curl -LO --output-dir ~/.config/alacritty https://github.com/catppuccin/alacritty/raw/main/catppuccin-mocha.toml
        # to get your beautiful mocha back
        # not working?
        # check here!
        # https://github.com/catppuccin/alacritty
        import = [ "~/.config/alacritty/catppuccin-mocha.toml" ];      
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

      # zsh alias #
      shellAliases = {
        edit-config = "hx ~/.dotfiles";

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
          sudo nixos-rebuild switch --flake ~/.dotfiles |& nom
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

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/zie/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
}
