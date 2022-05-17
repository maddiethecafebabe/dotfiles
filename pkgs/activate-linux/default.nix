{ stdenv
, lib
, fetchFromGitHub
, pkg-config
, cairo
, clang
, xorg
}:

stdenv.mkDerivation rec {
  pname = "activate-linux";
  version = "0.0.1";

  src = fetchFromGitHub {
    owner = "MrGlockenspiel";
    repo = pname;
    rev = "f5a23239b926316468da4e58c236b2ee1408602a";
    sha256 = "sha256-W8QXvOkkeBmG2ayubuSs5IoXEsrEFlcTxm+XOoJYS5c=";
  };

  nativeBuildInputs = [
    pkg-config
    clang
  ];

  buildInputs = with xorg; [
    libX11
    libXi
    xorgproto
    xcbproto
    libXt
    libXinerama
  ] ++ [
    cairo
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/bin"
    export PREFIX="$out/bin"
    export BINDIR=""
    make install

    runHook postInstall
  '';

  meta = with lib; {
    description = "The \"Activate Windows\" watermark ported to Linux ";
    license = [ licenses.unfree ]; # dunno under what else the "BASED" License would fall
    homepage = "https://github.com/MrGlockenspiel/activate-linux";
    maintainers = [  ];
    platforms = platforms.linux;
  };
}
