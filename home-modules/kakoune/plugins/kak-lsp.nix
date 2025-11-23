{ pkgs ? import <nixpkgs> {} }: let
  version = "18.2.0";
in pkgs.stdenv.mkDerivation {
  name = "kak-lsp";
  inherit version;

  src = null;

  dontUnpack = true;
  dontBuild = true;
  dontCheck = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/kak/bin
    ln -s ${pkgs.kakoune-lsp}/bin/kak-lsp $out/share/kak/bin/kak-lsp

    runHook postInstall
  '';
}
  
