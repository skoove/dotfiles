{ pkgs , ... }:
{
  stylix.targets.floorp = {
    profileNames = [ "zie" ];
    colorTheme.enable = true;
  };

  programs.floorp = {
    enable = true;

    policies = {
      DisableTelemetry = true;
      OfferToSaveLogins = false;
      DisableProfileImport = true;
    };

    profiles."zie" = {
      name = "zie";

      settings = {
        "extensions.autoDisableScopes" = 0;
      };
      
      extensions = {
        force = true;

        packages = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          bitwarden
        ];
      };
    };
  };
}
