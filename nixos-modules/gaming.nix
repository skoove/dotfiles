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
    prismlauncher
    glfw3-minecraft
    vintagestory
  ] else []);

  services.ratbagd.enable = true; # mouse stuff i think

  programs.gamemode.enable = true;
  
  programs.gamescope = {
    enable = true;
    package = pkgs.gamescope.overrideAttrs (_: {
      NIX_CFLAGS_COMPILE = ["-fno-fast-math"];
    });
  };

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
