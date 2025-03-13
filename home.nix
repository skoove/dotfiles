{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "zie";
  home.homeDirectory = "/home/zie";

  imports = [ 
    ./hyprland.nix
  ];

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    obsidian
    libreoffice-fresh
    nixd
    waybar
  ];

  programs.kitty.enable = true;
  programs.starship.enable = true;
  programs.zellij.enable = true;
  programs.nushell.enable = true;
  programs.bat.enable = true;

  stylix.targets.helix.enable = false;
  programs.helix = {
    enable = true;
    settings = {
      theme = "gruvbox";
      editor = {
        indent-guides.render = true;
        line-number = "relative";
      };
    };
  };

  programs.git = {
    enable = true;
    userName = "Zie Sturges";
    userEmail = "53106860+skoove@users.noreply.github.com";
    extraConfig.init.defaultBranch = "main";
    delta.enable = true;
  };

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
