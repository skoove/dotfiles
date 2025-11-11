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

    ;; tap repress time out, time out for pressing key twice and holding
    ;; causing it to hold tap action
    (defvar tt 160)
    ;; timeout until hold action start
    (defvar ht 160)
    
    (deflayermap (default)
      ` (tap-hold-release $tt $ht ` XX)
      1 (tap-hold-release $tt $ht 1 XX)
      2 (tap-hold-release $tt $ht 2 XX)
      3 (tap-hold-release $tt $ht 3 XX)
      4 (tap-hold-release $tt $ht 4 XX)
      5 (tap-hold-release $tt $ht 5 XX)
      6 (tap-hold-release $tt $ht 6 XX)
      7 (tap-hold-release $tt $ht 7 XX)
      8 (tap-hold-release $tt $ht 8 XX)
      9 (tap-hold-release $tt $ht 9 XX)
      0 (tap-hold-release $tt $ht 0 XX)
      - (tap-hold-release $tt $ht - XX)
      = (tap-hold-release $tt $ht = XX)

      q (tap-hold-release $tt $ht q XX)
      w (tap-hold-release $tt $ht w lmet)
      e (tap-hold-release $tt $ht e XX)
      r (tap-hold-release $tt $ht r XX)
      t (tap-hold-release $tt $ht t XX)
      y (tap-hold-release $tt $ht y XX)
      u (tap-hold-release $tt $ht u XX)
      i (tap-hold-release $tt $ht i XX)
      o (tap-hold-release $tt $ht o rmet)
      p (tap-hold-release $tt $ht p XX)
      [ (tap-hold-release $tt $ht [ XX)
      ] (tap-hold-release $tt $ht ] XX)
      \ (tap-hold-release $tt $ht \ XX)

      caps (tap-hold-release $tt $ht esc XX)
      a (tap-hold-release $tt $ht a (layer-while-held arrow))
      s (tap-hold-release $tt $ht s lalt)
      d (tap-hold-release $tt $ht d lctl)
      f (tap-hold-release $tt $ht f lsft)
      g (tap-hold-release $tt $ht g XX)
      h (tap-hold-release $tt $ht h XX)
      j (tap-hold-release $tt $ht j rshft)
      k (tap-hold-release $tt $ht k rctl)
      l (tap-hold-release $tt $ht l ralt)
      ; (tap-hold-release $tt $ht ; XX)
      ' (tap-hold-release $tt $ht ' XX)

      z (tap-hold-release $tt $ht z XX)
      x (tap-hold-release $tt $ht x XX)
      c (tap-hold-release $tt $ht c XX)
      v (tap-hold-release $tt $ht v XX)
      b (tap-hold-release $tt $ht b XX)
      n (tap-hold-release $tt $ht n XX)
      m (tap-hold-release $tt $ht m XX)
      , (tap-hold-release $tt $ht , XX)
      . (tap-hold-release $tt $ht . XX)
      / (tap-hold-release $tt $ht / XX)
    )

    (deflayermap (arrow)
      h left
      j down
      k up
      l right
    )
  '';

  validatedConfig = pkgs.runCommand "validatd-kanata-config.kbd" {} ''
    ${lib.getExe kanata} --cfg ${config} --check
    cp ${config} $out
  '';
in {
  systemd.user.services."kanata" = {
    Unit.description = "kanata service -- keyboard remapper";
    Install.WantedBy = [ "default.target" ];

    Service = {
      Type = "simple";
      ExecStart = "${lib.getExe kanata} --cfg ${validatedConfig}";
    };
  };
}
