{ pkgs, ... }:
{
  programs.obs-studio = {
    enable = true;
    programs.obs-studio.package = (pkgs.obs-studio.override {
        cudaSupport = true;
    });

    plugins = with pkgs.obs-studio-plugins; [
      obs-pipewire-audio-capture
      obs-vkcapture
    ];
  };
}
