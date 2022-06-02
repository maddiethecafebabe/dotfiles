# pretty much everything in this folder is not actually meant
# for dev directly, but i just like to adhoc do some coding in 
# a folder and doing nix-shell -p ... would annoy me
{ pkgs, lib, ... }:

{
    imports = [
        ./rust.nix
        ./cc.nix
        ./cs.nix
        ./python.nix
    ];

    options.modules.dev = with lib; {
        enable = mkOption { type = types.bool; default = true; };
    };
}
