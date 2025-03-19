{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "zie";
  home.homeDirectory = "/home/zie";

  imports = [ ./stylix.nix ];

  fonts.fontconfig.enable = true;
  
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

    # fonts
    corefonts
  ];

  programs.kitty.enable = true;
  programs.starship.enable = true;
  programs.zellij.enable = true;
  programs.nushell.enable = true;
  programs.bat.enable = true;
  programs.fuzzel.enable = true;
  programs.carapace.enable = true;

  services.dunst.enable = true;
  services.hyprpaper.enable = true;


  # home.sessionVariables = {
  # };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
  home.stateVersion = "24.11";
}
