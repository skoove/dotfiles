{ pkgs , inputs , ... }:
{
  nixpkgs.overlays = [
    inputs.millennium.overlays.default
  ];

  environment.systemPackages = with pkgs; [
    mangohud
    wine
    protontricks
    r2modman
    protonup-qt
    piper # config mouse stuff
    wine64
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
}
