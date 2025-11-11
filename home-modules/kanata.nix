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
      \ (tap-hold-release $tt $ht \ (layer-switch doublestruck))

      caps (tap-hold-release $tt $ht esc XX)
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
    )

    (deflayermap (arrow)
      h left
      j down
      k up
      l right
    )

    (deflayermap (doublestruck)
      a (tap-hold-release $tt $ht (cmd wtype 𝕒) XX)
      b (tap-hold-release $tt $ht (cmd wtype 𝕓) XX)
      c (tap-hold-release $tt $ht (cmd wtype 𝕔) XX)
      d (tap-hold-release $tt $ht (cmd wtype 𝕕) XX)
      e (tap-hold-release $tt $ht (cmd wtype 𝕖) XX)
      f (tap-hold-release $tt $ht (cmd wtype 𝕗) (layer-while-held doublestruck-upper))
      g (tap-hold-release $tt $ht (cmd wtype 𝕘) XX)
      h (tap-hold-release $tt $ht (cmd wtype 𝕙) (layer-while-held doublestruck-upper))
      i (tap-hold-release $tt $ht (cmd wtype 𝕚) XX)
      j (tap-hold-release $tt $ht (cmd wtype 𝕛) XX)
      k (tap-hold-release $tt $ht (cmd wtype 𝕜) XX)
      l (tap-hold-release $tt $ht (cmd wtype 𝕝) XX)
      m (tap-hold-release $tt $ht (cmd wtype 𝕞) XX)
      n (tap-hold-release $tt $ht (cmd wtype 𝕟) XX)
      o (tap-hold-release $tt $ht (cmd wtype 𝕠) XX)
      p (tap-hold-release $tt $ht (cmd wtype 𝕡) XX)
      q (tap-hold-release $tt $ht (cmd wtype 𝕢) XX)
      r (tap-hold-release $tt $ht (cmd wtype 𝕣) XX)
      s (tap-hold-release $tt $ht (cmd wtype 𝕤) XX)
      t (tap-hold-release $tt $ht (cmd wtype 𝕥) XX)
      u (tap-hold-release $tt $ht (cmd wtype 𝕦) XX)
      v (tap-hold-release $tt $ht (cmd wtype 𝕧) XX)
      w (tap-hold-release $tt $ht (cmd wtype 𝕨) XX)
      x (tap-hold-release $tt $ht (cmd wtype 𝕩) XX)
      y (tap-hold-release $tt $ht (cmd wtype 𝕪) XX)
      z (tap-hold-release $tt $ht (cmd wtype 𝕫) XX)
      caps (layer-switch default)
    )

    (deflayermap (doublestruck-upper)
      a (tap-hold-release $tt $ht (cmd wtype 𝔸) XX)
      b (tap-hold-release $tt $ht (cmd wtype 𝔹) XX)
      c (tap-hold-release $tt $ht (cmd wtype ℂ) XX)
      d (tap-hold-release $tt $ht (cmd wtype 𝔻) XX)
      e (tap-hold-release $tt $ht (cmd wtype 𝔼) XX)
      f (tap-hold-release $tt $ht (cmd wtype 𝔽) XX)
      g (tap-hold-release $tt $ht (cmd wtype 𝔾) XX)
      h (tap-hold-release $tt $ht (cmd wtype ℍ) XX)
      i (tap-hold-release $tt $ht (cmd wtype 𝕀) XX)
      j (tap-hold-release $tt $ht (cmd wtype 𝕁) XX)
      k (tap-hold-release $tt $ht (cmd wtype 𝕂) XX)
      l (tap-hold-release $tt $ht (cmd wtype 𝕃) XX)
      m (tap-hold-release $tt $ht (cmd wtype 𝕄) XX)
      n (tap-hold-release $tt $ht (cmd wtype ℕ) XX)
      o (tap-hold-release $tt $ht (cmd wtype 𝕆) XX)
      p (tap-hold-release $tt $ht (cmd wtype ℙ) XX)
      q (tap-hold-release $tt $ht (cmd wtype ℚ) XX)
      r (tap-hold-release $tt $ht (cmd wtype ℝ) XX)
      s (tap-hold-release $tt $ht (cmd wtype 𝕊) XX)
      t (tap-hold-release $tt $ht (cmd wtype 𝕋) XX)
      u (tap-hold-release $tt $ht (cmd wtype 𝕌) XX)
      v (tap-hold-release $tt $ht (cmd wtype 𝕍) XX)
      w (tap-hold-release $tt $ht (cmd wtype 𝕎) XX)
      x (tap-hold-release $tt $ht (cmd wtype 𝕏) XX)
      y (tap-hold-release $tt $ht (cmd wtype 𝕐) XX)
      z (tap-hold-release $tt $ht (cmd wtype ℤ) XX)
    )
    
  '';

  validatedConfig = pkgs.runCommand "validatd-kanata-config.kbd" {} ''
    ${lib.getExe kanata} --cfg ${config} --check
    cp ${config} $out
  '';
in {

  home.packages = [ pkgs.wtype ];
  
  systemd.user.services."kanata" = {
    Unit.description = "kanata service -- keyboard remapper";
    Install.WantedBy = [ "default.target" ];

    Service = {
      Type = "simple";
      ExecStart = "${lib.getExe kanata} --cfg ${validatedConfig}";
    };
  };
}
