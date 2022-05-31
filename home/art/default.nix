{ home, pkgs, user, ... }:

{
    imports = [ ];

    home.packages = with pkgs; [
        libresprite
        krita
        grab-bag.MagicaVoxel
        (grab-bag.sai2.override { executable = "${user.home}/.local/Tools/Art/sai2/sai2.exe"; })
    ];
}
