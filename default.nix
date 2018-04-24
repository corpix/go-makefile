with import <nixpkgs> {};
stdenv.mkDerivation rec {

  name = "go-makefile";

  buildInputs = [ bash python36 ];
  nativeBuildInputs = [ makeWrapper ];

  src = fetchFromGitHub {
    owner  = "corpix";
    repo   = name;
    rev    = "237d62d9df8a48beadfce9c6d8c4b0b96d1ac1fc";
    sha256 = "0kiydsdrayvfhrf6zabn9zab0w621xcy0889ljqb8v19q7hjvilm";
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
