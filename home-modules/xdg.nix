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

    desktopEntries.vintagestorymodinstall = {
      name = "Vintage Story Mod Install";
      exec = "vintagestory -i %u";
      type = "Application";
      noDisplay = true;
      mimeType = [ "x-scheme-handler/vintagestorymodinstall" ];
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
