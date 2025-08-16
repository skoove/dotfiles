{ pkgs, osConfig , ... }:
{
  programs.obs-studio = {
    enable = true;
    plugins = [ pkgs.obs-studio-plugins.obs-pipewire-audio-capture ];
  } // (if osConfig.networking.hostName == "nixos-desktop" then {
    package = (pkgs.obs-studio.override {
        cudaSupport = true;
    });
  } else {});
}
