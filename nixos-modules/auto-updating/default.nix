{ lib, config, ... }: {
  options.programs.auto-updating = {
    enable = lib.mkEnableOption "Enable auto updating";
    notifications.enable = lib.mkEnableOption "Enable desktop notifications on update and failure";
  };

  config = let
    opts = config.programs.auto-updating;
  in lib.mkIf opts.enable{
    
  };
}
