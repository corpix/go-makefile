with import <nixpkgs> {};
stdenv.mkDerivation {
  name = "nix-cage-shell";
  buildInputs = [
    python36
    python36Packages.pyflakes
    gnumake
  ];
}
