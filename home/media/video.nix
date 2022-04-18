{ home, pkgs, ... }:

{
    home.packages = with pkgs; [ 
        vlc
        mpv
    ];
}
