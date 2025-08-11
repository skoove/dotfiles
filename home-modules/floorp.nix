{ pkgs , inputs , ... }:
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
        # all of these settings are in about:config
        "extensions.autoDisableScopes" = 0;
        "browser.tabs.opentabfor.middleclick" = true;
        "browser.tabs.loadInBackground" = true;

        # enable scrolling using the middle mouse button 
        "general.autoScroll" = true;

        # needed for the obsidian clipper plugin
        "extensions.openPopupWithoutUserGesture.enabled" = true;

        # its annoying
        "browser.aboutConfig.showWarning" = false;

        # 1: stacked
        "floorp.tabbar.style" = 1;

        # ask for where to download files instead of just putting them wherever
        "browser.download.useDownloadDir" = false;

        # turn off all the floorp sidebar stuff; i do not like it
        "floorp.browser.sidebar.enable" = false;
        "floorp.browser.sidebar.is.displayed" = false;
        "sidebar.revamp" = false;
        "floorp.browser.workspaces.enabled" = false;

        # this is the state of that whole top bar, just copy paste it from
        # about:config after editing it manually, maybe some day i will find a
        # more nixy way? but nixing of the sake of nix is a fools endevour
        "browser.uiCustomization.state" = ''{"placements":{"widget-overflow-fixed-list":[],"unified-extensions-area":["sponsorblocker_ajay_app-browser-action","firefoxcolor_mozilla_com-browser-action","_f209234a-76f0-4735-9920-eb62507a54cd_-browser-action","enhancerforyoutube_maximerf_addons_mozilla_org-browser-action","jid1-oy8xu5bskzqa6a_jetpack-browser-action"],"nav-bar":["back-button","forward-button","customizableui-special-spring1","urlbar-container","customizableui-special-spring2","save-to-pocket-button","downloads-button","unified-extensions-button","ublock0_raymondhill_net-browser-action","_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action","vpn_proton_ch-browser-action","_d07ccf11-c0cd-4938-a265-2a4d6ad01189_-browser-action","clipper_obsidian_md-browser-action","_7a7a4a92-a2a0-41d1-9fd7-1e92480d612d_-browser-action"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["workspaces-toolbar-button","tabbrowser-tabs","new-tab-button","alltabs-button"],"PersonalToolbar":["personal-bookmarks"],"statusBar":["screenshot-button","fullscreen-button","status-text"]},"seen":["developer-button","sidebar-reverse-position-toolbar","undo-closed-tab","profile-manager","workspaces-toolbar-button","_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action","firefoxcolor_mozilla_com-browser-action","ublock0_raymondhill_net-browser-action","_f209234a-76f0-4735-9920-eb62507a54cd_-browser-action","enhancerforyoutube_maximerf_addons_mozilla_org-browser-action","jid1-oy8xu5bskzqa6a_jetpack-browser-action","vpn_proton_ch-browser-action","_7a7a4a92-a2a0-41d1-9fd7-1e92480d612d_-browser-action","_d07ccf11-c0cd-4938-a265-2a4d6ad01189_-browser-action","clipper_obsidian_md-browser-action","sponsorblocker_ajay_app-browser-action"],"dirtyAreaCache":["nav-bar","statusBar","TabsToolbar","toolbar-menubar","PersonalToolbar","unified-extensions-area"],"currentVersion":20,"newElementCount":2}'';

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
        default = "ddg";
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

        settings = let
          ponos_local = "192.168.210";
          ponos_tailscale = "100.93.218.86";
        in [
          {
            toolbar = true;
            bookmarks = [
              { name = "px 1"; url = "https://100.78.85.71:8006/"; }
              { name = "nas"; url = "http://100.124.39.39:5000/"; }
              { name = "jellyfin"; url = "http://${ponos_tailscale}:8096/web/"; }
              { name = "audiobookshelf"; url = "http://${ponos_tailscale}:8000/"; }
              { name = "rss"; url = "http://${ponos_tailscale}:7000/"; }
              { name = "transmission"; url = "http://${ponos_tailscale}:9091/transmission/web/"; }
              {
                name = "local";
                bookmarks = [
                  { name = "nas"; url = "http://192.168.0.230:5000/"; }
                  { name = "router"; url = "https://192.168.0.254/"; }
                  { name = "px 1"; url = "https://192.168.0.230:8006/"; }
                  { name = "px 2"; url = "https://192.168.0.231:8006/"; }
                  { name = "jellyfin"; url = "http://${ponos_local}:8096/"; }
                  { name = "audiobookshelf"; url = "http://${ponos_local}:8000/"; }
                  { name = "rss"; url = "http://${ponos_local}:7000/"; }
                  { name = "transmission"; url = "http://${ponos_local}:9091/"; }
                ];
              }
            ];
          }
        ];
      };
    };
  };
}
