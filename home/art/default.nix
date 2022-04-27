{ home, pkgs, makeDesktopItem, ... }:

{
    imports = [
        ./sai2.nix
    ];

    home.packages = with pkgs; [
        libresprite
        krita
    ];
}
