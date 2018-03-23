with import <nixpkgs> {};
stdenv.mkDerivation rec {

  name = "go-makefile";

  buildInputs = [ bash python36 ];
  nativeBuildInputs = [ makeWrapper ];

  src = fetchFromGitHub {
    owner  = "corpix";
    repo   = name;
    rev    = "e6f91a9ef291387a373517e433b6cde4ed851bce";
    sha256 = "0nwdxvb3an3awlvls610qvdj4hvmfz5xryws49ja9j5yrjv298k0";
  };

  buildPhase = ''
    patchShebangs .
  '';

  checkTarget = "test";

  installPhase = ''
    source $stdenv/setup
    set -e

    mkdir -p $out/bin
    cp       $src/${name}    $out/bin
    chmod +x $out/bin/${name}
  '';

  meta = {
    homepage = https://github.com/corpix/go-makefile;
    description = "Makefile generator for Go projects";

    license = stdenv.lib.licenses.mit;
    platforms = stdenv.lib.platforms.all;
  };
}
