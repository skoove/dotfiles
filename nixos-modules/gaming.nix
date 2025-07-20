{ pkgs , inputs , config , lib , ... }:
{
  nixpkgs.overlays = [
    inputs.millennium.overlays.default
  ];

  imports = [
    inputs.arma3helper.nixosModules.default
  ];

  environment.systemPackages = with pkgs; [
    mangohud
    wine
    protontricks
    r2modman
    protonup-qt
    piper # config mouse stuff
    wine64
    arma3-unix-launcher
  ];

  services.ratbagd.enable = true; # mouse stuff i think

  programs.gamescope.enable = true;
  programs.gamemode.enable = true;
  
  programs.steam = {
    enable = true;
    package = pkgs.steam-millennium;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  programs.arma3helper = {
    enable = lib.mkIf (config.networking.hostName == "nixos-desktop") true;
    proton_offical_version = "Proton Experimental";
    steam_library_path = "/home/zie/ssd_games/SteamLibrary";
    compat_data_path = "/home/zie/ssd_games/SteamLibrary/steamapps/compatdata/107410";
  };
}
