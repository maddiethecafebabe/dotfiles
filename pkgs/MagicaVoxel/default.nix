{ stdenv
, lib
, fetchzip
, fetchurl
, makeDesktopItem
, wine ? null
, wineWowPackages
}:

let 
    pname = "MagicaVoxel";
    version = "0.99.7";
    winever = if wine == null 
                then wineWowPackages.stable
                else wine;
    src = fetchzip {
        url = "https://github.com/ephtracy/ephtracy.github.io/releases/download/${version}/MagicaVoxel-${version}.0-win64.zip";
        sha256 = "sha256-zsU/N004RswYHt0ZFKzboTu4362APRbKLHs97rNPCPM=";
    };
    icon = fetchurl {
        url = "https://ephtracy.github.io/favicon.png";
        sha256 = "sha256-WhlQSTSgZgxykOkU2z+tC71W3l2IlRdH+XoE4a2pXSk=";
    };
    magica-voxel-desktop = makeDesktopItem {
        name = "MagicaVoxel";
        desktopName = "MagicaVoxel";
        exec = "${winever}/bin/wine ${src}/MagicaVoxel.exe";
        categories = [ "Art" "Graphics" ];
        icon = "${icon}";
    };
in stdenv.mkDerivation rec {
  inherit pname src version;

  installPhase = ''
    mkdir -p $out/share/applications
    ln -s ${magica-voxel-desktop}/share/applications/* $out/share/applications
  '';

  meta = with lib; {
    description = "A free lightweight GPU-based voxel art editor and interactive path tracing renderer.";
    license = [ licenses.unfree ];
    homepage = "https://ephtracy.github.io/index.html?page=mv_main";
    maintainers = [  ];
    platforms = platforms.linux;
  };
}
