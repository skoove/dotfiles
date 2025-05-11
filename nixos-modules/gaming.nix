{ pkgs , ... }:
{
  programs.gamescope.enable = true;
  programs.gamemode.enable = true;
  
  environment.systemPackages = with pkgs; [
    mangohud
    bottles
    wine
    protontricks
    protonup-qt
  ];

  programs.steam = {
    enable = true;
  };
}
