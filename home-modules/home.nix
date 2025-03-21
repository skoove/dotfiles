{ config, pkgs, lib, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "zie";
  home.homeDirectory = "/home/zie";

  imports = [
    ./dwarf-fortress.nix
    ./eza.nix
    ./git.nix
    ./helix.nix
    ./hyprland.nix
    ./nixcord.nix
    ./spotify.nix
    ./starship.nix
    ./stylix.nix
    ./syncthing.nix
    ./zellij.nix
    ./zsh.nix
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
    nix-output-monitor
    
    # fonts
    corefonts
    dejavu_fonts
  ];

  programs.kitty.enable = true;
  programs.bat.enable = true;
  programs.carapace.enable = true;
  services.hyprpaper.enable = true;

  home.sessionVariables = {
    FLAKE = "/home/zie/.dotfiles";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
  home.stateVersion = "24.11";
}
