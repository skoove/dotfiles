{ pkgs , ... }:
{
  programs.gamescope.enable = true;
  programs.gamemode.enable = true;
  
  environment.systemPackages = with pkgs; [
    mangohud
    bottles
    wine
    protontricks
    r2modman
  ];

  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };
}
