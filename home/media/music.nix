{ home, pkgs, ... }:

{
    home.packages = with pkgs; [ 
        deadbeef
        lmms # gamedev
    ];
}
