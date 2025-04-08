{ config, pkgs, inputs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  # home.username = "zie";
  # home.homeDirectory = "/home/zie";

  imports = [
    # ./dwarf-fortress.nix
    # ./hyprland.nix
    ../stylix.nix
    ./bottom.nix
    ./email.nix
    ./eza.nix
    ./fish.nix
    ./obs.nix
    ./foot.nix
    ./fuzzel.nix
    ./git.nix
    ./helix.nix
    ./niri.nix
    ./nixcord.nix
    ./rust-dev-tools.nix
    ./sops.nix
    ./spotify.nix
    ./starship.nix
    ./stylix.nix
    ./syncthing.nix
    ./zellij.nix
    # ./zsh.nix

    inputs.stylix.homeManagerModules.stylix
   ];

  fonts.fontconfig.enable = true;
  fonts.fontconfig.defaultFonts.monospace = [
    config.stylix.fonts.monospace.name
    "DejaVu Sans"
  ];
  
  home.packages = with pkgs; [
    # productive
    obsidian          # note taking
    libreoffice-fresh # office suite
    inkscape          # vector graphics
    gimp              # image editing
    aseprite          # pixel art
    nom               # rss reader

    # utils
    bemoji                                           # emoji picker for wofi
    brightnessctl                                    # for controlling laptop backlight
    pavucontrol                                      # volume control
    satty                                            # edit screenshots
    wl-clipboard                                     # copy things to clipboard (required by bemoji)
    libsForQt5.qtstyleplugin-kvantum                 # themeing for qt apps
    wofi-power-menu                                  # shutdown & other poweractions using wofi
    python3                                          # its python 3!
    wf-recorder                                      # screen recorder
    (import ../packages/loago.nix { inherit pkgs; }) # shows how long ago a task was done
    gnuplot                                          # plotting lib


    # tools
    nixd               # nix lsp
    dust               # disk usage but easier read
    nh                 # replacement for rebuild commands
    tldr               # simpler man pages
    bitwarden-cli      # password manager
    sops               # secrets management
    mprocs             # run commands ez
    ripgrep            # grepper
    whatsapp-for-linux # whats
    strawberry

    # not tools at all but i dont want to nix run them
    nitch # pretty, mostly useless
    
    # fonts
    corefonts    # ms fonts
    dejavu_fonts # idk if i actually like these
  ];

  programs.bat.enable = true;
  programs.firefox.enable = true;

  home.file.".local/share/loago/loago.json".source =
    config.lib.file.mkOutOfStoreSymlink /home/zie/obsidian/index/loago.json;

  # Let Home Manager install and manage itself.
  # programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
  home.stateVersion = "24.11";
}
