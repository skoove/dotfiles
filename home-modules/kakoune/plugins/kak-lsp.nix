{ pkgs ? import <nixpkgs> {} }: let
  version = "18.2.0";
in pkgs.stdenv.mkDerivation rec {
  name = "kak-lsp";
  inherit version;

  src = pkgs.fetchFromGitHub {
    owner = "kakoune-lsp";
    repo = "kakoune-lsp";
    tag = "v${version}";
    hash = "sha256-71XnCHAXOcrXu0xizwdwJPkhnmfEjmVP++6mxmTcnM4=";
  };

  buildInputs = [ pkgs.kakoune-lsp ];

  dontBuild = true;
  dontCheck = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/kak/autoload/kak-lsp/
    cp ./rc/* $out/share/kak/autoload/kak-lsp/

    mkdir -p $out/bin
    ln -s ${pkgs.kakoune-lsp}/bin/kak-lsp $out/bin/kak-lsp

    runHook postInstall
  '';
}
  
