{ pkgs }:

pkgs.rustPlatform.buildRustPackage {
  pname = "loago";
  version = "latest";

  src = pkgs.fetchFromGitHub {
    owner = "Axlefublr";
    repo = "loago";
    rev = "eaa82799e6c1f6c3e1178cf21d75cfeb67d389b3"; 
    sha256 = "sha256-pF9+SusaaqO5n3B2oSyXtPF9pw0hglnDmhoFRIF+VRg="; 
  };
  cargoHash = "sha256-Vj2682T9I/ebG4EOFDu408lscpdjpHd0QmDch131aWo=";
}
