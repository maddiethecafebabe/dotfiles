{ home, pkgs, ... }:

{
    home.packages = with pkgs; [ 
        vlc deadbeef mpv
    ];
}
