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
        "browser.aboutConfig.showWarning" = false;
        "floorp.tabbar.style" = 1;
        "floorp.browser.sidebar.enable" = false;
        "floorp.browser.sidebar.is.displayed" = false;
        "sidebar.revamp" = false;
        "floorp.browser.workspaces.enabled" = false;
        "browser.uiCustomization.state" = ''{"placements":{"widget-overflow-fixed-list":[],"unified-extensions-area":["firefoxcolor_mozilla_com-browser-action"],"nav-bar":["back-button","forward-button","customizableui-special-spring1","urlbar-container","customizableui-special-spring2","save-to-pocket-button","downloads-button","unified-extensions-button","ublock0_raymondhill_net-browser-action","_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["workspaces-toolbar-button","tabbrowser-tabs","new-tab-button","alltabs-button"],"PersonalToolbar":["personal-bookmarks"],"statusBar":["screenshot-button","fullscreen-button","status-text"]},"seen":["developer-button","sidebar-reverse-position-toolbar","undo-closed-tab","profile-manager","workspaces-toolbar-button","_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action","firefoxcolor_mozilla_com-browser-action","ublock0_raymondhill_net-browser-action"],"dirtyAreaCache":["nav-bar","statusBar","TabsToolbar","toolbar-menubar","PersonalToolbar","unified-extensions-area"],"currentVersion":20,"newElementCount":2}'';
      };
      
      extensions = {
        force = true;

        packages = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          bitwarden
        ];
      };

      bookmarks = {
        force = true;

        settings = [
          {
            toolbar = true;
            bookmarks = [
              {
                name = "nas";
                url = "http://192.168.0.230:5000/";
              }
            ];
          }
        ];
      };
    };
  };
}
