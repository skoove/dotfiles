{ pkgs , ...}:
{
  home.packages = [ pkgs.iamb ];

  home.file.".config/iamb/config.toml".text =
  ''
    [profiles.user]
    user_id = "@skoove:catgirl.cloud"

    [settings.image_preview]
    protocol.type = "sixel"

    [settings.notifications]
    enabled = true

    [layout]
    style = "restore"

    [dirs]
    downloads = "Downloads/iamb"
    data = ".local/share"
  '';
}
