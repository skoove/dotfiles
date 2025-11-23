{ pkgs , lib , ... }:
let
  kanata = pkgs.kanata-with-cmd;

  layer-switch-notify = layer: "(multi (layer-switch ${layer}) (cmd fish -c \"notify-send 'layer: ${layer}'\"))";

  emote-script = pkgs.writeText "emote-script" ''
    set old_clipboard (wl-paste)
    wl-copy -f $argv[1]
    wtype -M ctrl -M shift v
    wl-copy $old_clipboard
  '';

  emote = emote: ''(cmd fish ${emote-script} "${emote}")'';
   
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

      caps (tap-hold-release $tt $ht esc (layer-while-held emotes))
      a (tap-hold-release $tt $ht a (layer-while-held arrow))
      s (tap-hold-release $tt $ht s lalt)
      d (tap-hold-release $tt $ht d lctl)
      f (tap-hold-release $tt $ht f lsft)
      g (tap-hold-release $tt $ht g XX)
      h (tap-hold-release $tt $ht h rsft)
      j (tap-hold-release $tt $ht j rctl)
      k (tap-hold-release $tt $ht k ralt)
      l (tap-hold-release $tt $ht l XX)
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

      rmet (layer-while-held layer-select)
      spc (tap-hold-release $tt $ht spc (layer-while-held mouse))
    )

    (deflayermap (arrow)
      h left
      j down
      k up
      l right

      u bspc
      i del
    )

    (deflayermap (mouse)
     h mlft
     j mrgt
     k mmid

     g (cmd niri msg action screenshot)
     v (cmd niri msg action screenshot-screen)
     b (cmd niri msg action screenshot-window)
     
     ${let
       # mouse move config
       directions = [
         {dir = "up";    key = "e";}
         {dir = "left";  key = "s";}
         {dir = "down";  key = "d";}
         {dir = "right"; key = "f";}
       ];
       
       interval = "10";
       acceleration-time = "1000";
       min = "1";
       max = "50";

       mkConfigLine = {dir, key}: "${key} (movemouse-accel-${dir} ${interval} ${acceleration-time} ${min} ${max})\n";
       mouse-move-config = lib.concatMapStrings mkConfigLine directions;
     in "${mouse-move-config}"}

     ${let
       # mouse whell config
       directions = [
         {dir = "down";  key = "n";}
         {dir = "up";    key = "m";}
         {dir = "left";  key = ",";}
         {dir = "right"; key = ".";}
       ];

       interval = "5";
       distance = "20";

       mkConfigLine = {dir, key}: "${key} (mwheel-${dir} ${interval} ${distance})\n";
       mouse-wheel-config = lib.concatMapStrings mkConfigLine directions;
     in "${mouse-wheel-config}"}
    )

    ;; special entered layers (these ones are not layer-while-helds)
    
    (deflayermap (layer-select)
      e ${layer-switch-notify "empty"}
    )

    (deflayermap (empty)
      rmet ${layer-switch-notify "default"}
      caps f16
    )

    ;; special typing layers
    (deflayermap (emotes)
      u ${emote "<3"}
      i ${emote "</3"}
      h ${emote ":3"}
      j ${emote ":D"}
      k ${emote ":)"}
    )
  '';

  validatedConfig = pkgs.runCommand "validatd-kanata-config.kbd" {} ''
    ${lib.getExe kanata} --cfg ${config} --check
    cp ${config} $out
  '';
in {

  home.packages = [ pkgs.wtype pkgs.libnotify ];
  
  systemd.user.services."kanata" = {
    Unit.description = "kanata service -- keyboard remapper";
    Install.WantedBy = [ "default.target" ];

    Service = {
      Type = "simple";
      ExecStart = "${lib.getExe kanata} --cfg ${validatedConfig}";
    };
  };
}
