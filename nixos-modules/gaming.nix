{ pkgs , inputs , config , lib , ... }:
{
  imports = [
  ];

  environment.systemPackages = with pkgs; [
    mangohud
    protontricks
    protonup-qt
    piper # config mouse stuff
    heroic
    openttd-jgrpp
  ] ++ (if config.networking.hostName == "nixos-desktop" then [
    pkgs.arma3-unix-launcher
    r2modman
    bottles-unwrapped
    prismlauncher
    glfw-wayland-minecraft
    vintagestory
  ] else []);

  services.ratbagd.enable = true; # mouse stuff i think

  programs.gamescope.enable = true;
  programs.gamemode.enable = true;
  
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      freetype
      libunwind
      libglvnd
    ];
  };
}
