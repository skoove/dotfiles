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
    starship
    zellij
    obsidian
    libreoffice-fresh
    fuzzel
    waybar
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
  };

  programs.helix = {
    enable = true;
    settings = {
      theme = "gruvbox";
      editor = {
        indent-guides.render = true;
      };
    };
  };

  programs.git = {
    enable = true;
    userName = "Zie Sturges";
    userEmail = "53106860+skoove@users.noreply.github.com";
    extraConfig.init.defaultBranch = "main";
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
