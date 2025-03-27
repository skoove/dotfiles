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

    # utils
    bemoji                           # emoji picker for wofi
    brightnessctl                    # for controlling laptop backlight
    hyprshot                         # screenshotting
    pavucontrol                      # volume control
    satty                            # edit screenshots
    wl-clipboard                     # copy things to clipboard (required by bemoji)
    libsForQt5.qtstyleplugin-kvantum # themeing for qt apps
    wofi-power-menu                  # shutdown & other poweractions using wofi
    python3                          # its python 3!

    # tools
    nixd               # nix lsp
    nix-output-monitor # see builds better
    dust               # disk usage but easier read
    nh                 # replacement for rebuild commands
    tldr               # simpler man pages
    bitwarden-cli      # password manager
    sops               # secrets management
    mprocs             # run commands ez

    # not tools at all but i dont want to nix run them
    nitch # pretty, mostly useless
    
    # fonts
    corefonts    # ms fonts
    dejavu_fonts # idk if i actually like these
  ];

  programs.bat.enable = true;
  programs.firefox.enable = true;

  # Let Home Manager install and manage itself.
  # programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
  home.stateVersion = "24.11";
}
