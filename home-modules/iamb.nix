{ pkgs , ...}:
{
  home.packages = [ pkgs.iamb ];

  home.file.".config/iamb/config.toml".text =
  ''
    [profiles.user]
    user_id = "@skoove:catgirl.cloud"
  '';
}
