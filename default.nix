with import <nixpkgs> {};
stdenv.mkDerivation rec {

  name = "go-makefile";

  buildInputs = [ bash python36 ];
  nativeBuildInputs = [ makeWrapper ];

  src = fetchFromGitHub {
    owner  = "corpix";
    repo   = name;
    rev    = "75fd5cf1490022307dbf79d62535095b92a7c081";
    sha256 = "101lxi0hnwxkc7racs729rcambvm13pgzlfsz59wc9k8jlw9mx1g";
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
