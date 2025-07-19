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

        ExtensionSettings = {
          # jdownloader 2 thing
          "jid1-OY8Xu5BsKZQa6A@jetpack" = {
            install_url = "https://extensions.jdownloader.org/firefox.xpi";
            installation_mode = "force_installed";
          };
        };
      };
      
      extensions = {
        force = true;

        packages = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          bitwarden
          sponsorblock
          stylus
          enhancer-for-youtube
          web-clipper-obsidian
          unpaywall
          shinigami-eyes
          proton-vpn
          boring-rss
          web-archives
        ];
      };

      search = {
        force = true;
        engines = {
          google.metaData.alias = "@g";
          my-nixos = {
            name = "MyNixOs";
            urls = [{ template = "https://mynixos.com/search?q={searchTerms}"; }];
            iconMapObj."16" = "https://mynixos.com/favicon.ico";
            definedAliases = [ "@nm" ];
          };
          "Nix Packages" = {
            urls = [{template = "https://search.nixos.org/packages?type=packages&query={searchTerms}";}];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@np"];
          };
          GitHub = {
            urls = [{template = "https://github.com/search?q={searchTerms}";}];
            icon = "https://github.com/fluidicon.png";
            updateInterval = 7 * 24 * 60 * 60 * 1000;
            definedAliases = ["@gh"];
          };
        };
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
              {
                name = "router";
                url = "https://192.168.0.254/";
              }
              {
                name = "proxmox";
                url = "https://192.168.0.187:8006/";
              }
              {
                name = "jellyfin";
                url = "http://192.168.0.253:8096/web/";
              }
              {
                name = "transmission";
                url = "http://192.168.0.36:9091/transmission/web/";
              }
              {
                name = "tailscale";
                bookmarks = [
                  {
                    name = "nas";
                    url = "http://100.124.39.39:5000/";
                  }
                  {
                    name = "proxmox";
                    url = "https://100.78.85.71:8006/";
                  }
                  {
                    name = "jellyfin";
                    url = "http://100.93.218.86:8096/web/";
                  }
                  {
                    name = "transmission";
                    url = "http://100.93.99.60:9091/transmission/web/";
                  }
                ];
              }
            ];
          }
        ];
      };
    };
  };
}
