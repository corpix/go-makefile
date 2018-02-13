with import <nixpkgs> {};
stdenv.mkDerivation rec {

  name = "go-makefile";

  buildInputs = [ bash python36 ];
  nativeBuildInputs = [ makeWrapper ];

  src = fetchFromGitHub {
    owner  = "corpix";
    repo   = name;
    rev    = "103562c9f83c7733e9595f308c07d9b1d4a49f1d";
    sha256 = "1w9jsxcsl75fsrfxxbknfddxx34y9vdcvvski135mbpn2hp4d8mv";
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
