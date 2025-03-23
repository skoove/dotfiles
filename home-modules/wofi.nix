{ ... }:
{
  programs.wofi = {
    enable = true;
    settings = {
      allow_images = true;
      allow_markup = true;
      insensitive = true;
    };
  };
}
