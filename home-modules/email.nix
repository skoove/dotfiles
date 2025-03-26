{ config , ... }:
{
  programs.thunderbird = {
    enable = true;

    profiles.zie = {
      isDefault = true;
    };
  };

  programs.aerc = {
    enable = true;
    extraConfig.general.unsafe-accounts-conf = true;
  };

  accounts.email.accounts.zie = {
    name = "Zie";
    realName = "Zie Sturges";
    address = "zie@sturges.com.au";
    userName = "zie@sturges.com.au";
    flavor = "gmail.com";
    passwordCommand = "cat '${config.sops.secrets.google-password.path}'";
    primary = true;

    aerc = {
      enable = true;
      imapAuth = "xoauth2";

      imapOauth2Params = {
        client_id = "406964657835-aq8lmia8j95dhl1a2bvharmfk3t1hgqj.apps.googleusercontent.com";
        client_secret = "kSmqreRr0qwBWJgbf5Y-PjSU";
        scope = "https://accounts.google.com";
        token_endpoint = "https://www.googleapis.com/oauth2/v3/token";
      };
    };

    imap = {
      host = "imap.gmail.com";
      port = 993;
      tls.enable = true;
    };
  };
}
