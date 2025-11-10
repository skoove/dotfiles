{ pkgs , lib , ... }:
let
  kanata = pkgs.kanata-with-cmd;

  
  config = pkgs.writeText "config.kbd" ''
    (defsrc)

     (defcfg
      concurrent-tap-hold yes
      danger-enable-cmd yes
      log-layer-changes no
      process-unmapped-keys yes
      rapid-event-delay 0
    )
    
    (deflayermap (default)
      a (tap-hold-release 150 150 a b)
    )
  '';
in {
  systemd.user.services."kanata" = {
    Unit.description = "kanata service -- keyboard remapper";
    Install.WantedBy = [ "default.target" ];

    Service = {
      Type = "simple";
      ExecStart = "${lib.getExe kanata} --cfg ${config}";
    };
  };
}
