{ home, pkgs, ... }:

{
    imports = [
        ./deadbeef.nix
    ];

    home.packages = with pkgs; [ 
        lmms # gamedev
    ];
}
