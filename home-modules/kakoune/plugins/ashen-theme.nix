{ pkgs ? import <nixpkgs> {}}: pkgs.stdenv.mkDerivation {
  name = "ashen-theme";
  version = "unstable";
  src = pkgs.fetchzip {
    url = "https://codeberg.org/ficd/kak-ashen/archive/7a8d2d68ac49d737b1211ee29333adef51ff75a4.tar.gz";
    hash = "sha256-w0tDBeaoJcFrJdeWuBKG25zAwelbm2kr9QwI81pI8J8=";
  };

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/share/kak/colors/
    cp colors/* $out/share/kak/colors
  '';
}
