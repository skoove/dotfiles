{ ... }:
{
  xdg = {
    desktopEntries.foot = {
      name = "Open Foot in Directory";
      exec = "foot -D %U"; 
      terminal = false;
      type = "Application";
      mimeType = [ "inode/directory" ];
      noDisplay = false;
    };

    desktopEntries.vintagestory = {
        name = "Vintage Story";
        genericName = "Vintage Story";
        exec = "env mesa_glthread=true vintagestory";
        terminal = false;
        categories = [ "Application" "Game" ];
    };

    enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = {
        "inode/directory" = "foot.desktop";
        "image/png" = "imv.desktop";
        "image/jpeg" = "imv.desktop";
        "image/jpg" = "imv.desktop";
        "image/gif" = "imv.desktop";
        "image/webp" = "imv.desktop";
        "image/bmp" = "imv.desktop";
        "image/tiff" = "imv.desktop";
        "image/svg+xml" = "imv.desktop";
      };
    };
  };
}
