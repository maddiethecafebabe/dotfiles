# pretty much everything in this folder is not actually meant
# for dev directly, but i just like to adhoc do some coding in 
# a folder and doing nix-shell -p ... would annoy me
{ home, pkgs, ... }:

{
    imports = [
        ./rust.nix
        ./cc.nix
        ./editor.nix
    ];

    home.packages = [ pkgs.git ];
}
