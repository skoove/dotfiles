{ pkgs , inputs , config , lib , ... }:
{
  imports = [
    inputs.arma3helper.nixosModules.default
  ];

  environment.systemPackages = with pkgs; [
    mangohud
    protontricks
    protonup-qt
    piper # config mouse stuff
    wineWowPackages.stableFull
    dxvk_2
  ] ++ (if config.networking.hostName == "nixos-desktop" then [
    pkgs.arma3-unix-launcher
    r2modman
    bottles-unwrapped
    prismlauncher
    glfw-wayland-minecraft
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

  programs.arma3helper = {
    enable = lib.mkIf (config.networking.hostName == "nixos-desktop") true;
    # proton_offical_version = "8.0";
    proton_custom_version = "GE-Proton10-9";
    steam_library_path = "/home/zie/ssd_games/SteamLibrary/steamapps/";
    compat_data_path = "/home/zie/ssd_games/SteamLibrary/steamapps/compatdata/107410";
  };
}
