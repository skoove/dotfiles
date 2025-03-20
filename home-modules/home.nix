{ config, pkgs, lib, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "zie";
  home.homeDirectory = "/home/zie";

  imports = [
    ../stylix.nix
    ./stylix.nix
    ./starship.nix
    ./nushell.nix
    ./nixcord.nix
    ./hyprland.nix
    ./git.nix
    ./helix.nix
    ./syncthing.nix
    ./spotify.nix
   ];

  fonts.fontconfig.enable = true;
  fonts.fontconfig.defaultFonts.monospace = [
    config.stylix.fonts.monospace.name
    "DejaVu Sans"
  ];
  
  home.packages = with pkgs; [
    # programs
    obsidian
    libreoffice-fresh
    nixd
    bemoji
    brightnessctl
    pavucontrol
    inkscape
    gimp
    hyprshot
    ksnip
    libsForQt5.qtstyleplugin-kvantum
    wl-clipboard

    # fonts
    corefonts
    dejavu_fonts
  ];

  programs.kitty.enable = true;
  programs.zellij.enable = true;
  programs.bat.enable = true;
  programs.carapace.enable = true;
  programs.fastfetch.enable = true;

  services.hyprpaper.enable = true;


  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
  home.stateVersion = "24.11";
}
