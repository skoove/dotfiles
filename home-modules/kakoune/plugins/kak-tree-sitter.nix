{ pkgs ? import <nixpkgs> {} }: let
  version = "2.0.0";
  name = "kak-tree-sitter";
  src = pkgs.fetchFromSourcehut {
    owner = "~hadronized";
    repo = name;
    tag = "kak-tree-sitter-v${version}";
    hash = "sha256-vFhNxixXsezK3Qm9d5hEiIttSjcuqHfgCHYrEOeKWvs=";
  };

  rustPacakge = pkgs.rustPlatform.buildRustPackage {
    inherit src;
    inherit name;
    inherit version;
    cargoLock.lockFile = "${src}/Cargo.lock";
  };
in pkgs.stdenv.mkDerivation {
  inherit src;
  inherit name;
  inherit version;

  dontBuild = true;
  dontCheck = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/kak/autoload/kak-tree-sitter/
    cp kak-tree-sitter/rc/* $out/share/kak/autoload/kak-tree-sitter/

    mkdir -p $out/bin
    ln -s ${rustPacakge}/bin/kak-tree-sitter $out/bin/kak-tree-sitter

    runHook postInstall
  '';
}
