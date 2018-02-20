with import <nixpkgs> {};
stdenv.mkDerivation {
  name = "nix-cage-shell";
  buildInputs = [
    gocode
    glide
    godef
    python36
    gnumake
  ];
  shellHook = ''
    export GOPATH=~/projects
  '';
}
