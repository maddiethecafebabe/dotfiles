{ pkgs, lib, config, ... }:
with lib;
let
    cfg = config.modules.core;
in {
    options = {
        modules.core.enable = mkOption {
            type = types.bool;
            default = true;
        };
    };

        imports = [
            ./nix.nix
            ./users.nix
            ./flatpak.nix
    ];
}
