{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "zie";
  home.homeDirectory = "/home/zie";

  imports = [ ];

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  fonts.fontconfig.enable = true;
  
  home.packages = with pkgs; [
    # programs
    obsidian
    libreoffice-fresh
    nixd
    bemoji
    brightnessctl

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

  services.syncthing = {
    enable = true;
    tray.enable = true;
  };

  # home.sessionVariables = {
  # };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
}
