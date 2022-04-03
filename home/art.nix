{ home, pkgs, ... }:

{
    home.packages = with pkgs; [
        libresprite
    ];

    # i use sai2 too but i cant really bundle it as a package
}