{ pkgs , ... }:
{
  programs.gamemode.enable = true;
  
  environment.systemPackages = with pkgs; [
    mangohud
    wine
    protontricks
    r2modman
    protonup-qt
    lutris
    piper # config mouse stuff
    wine64
  ];

  services.ratbagd.enable = true; # mouse stuff i think

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    gamescopeSession.enable = true;
  };
}
