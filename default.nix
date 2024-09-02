{
  laas-beamer-theme,
  lib,
  pandoc,
  python3,
  source-code-pro,
  source-sans,
  source-serif,
  stdenvNoCC,
  texlive,
}:
stdenvNoCC.mkDerivation {
  name = "teach";

  src = lib.fileset.toSource {
    root = ./.;
    fileset = lib.fileset.unions [
      ./2023-2024
      ./2024-2025
      ./index.py
      ./Makefile
      ./media
      ./src
      ./public/src
    ];
  };

  makeFlags = [
    "PREFIX=${placeholder "out"}"
    "-j"
  ];

  nativeBuildInputs = [
    source-code-pro
    source-sans
    source-serif
  ];

  buildInputs = [
    pandoc
    python3
    (texlive.combined.scheme-full.withPackages (_: [ laas-beamer-theme ]))
  ];

  preBuild = ''
    export XDG_CACHE_HOME="$(mktemp -d)"
  '';

  meta = {
    description = "Teach";
    homepage = "https://github.com/nim65s/teach";
    license = lib.licenses.cc-by-sa-40;
    maintainers = [ lib.maintainers.nim65s ];
  };
}
