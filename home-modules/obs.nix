{ pkgs, osConfig , ... }:
{
  programs.obs-studio = {
    enable = true;
  } // (if osConfig.networking.hostName == "nixos-desktop" then {
    package = (pkgs.obs-studio.override {
        cudaSupport = true;
    });
  } else {});
}
