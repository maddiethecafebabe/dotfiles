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

    inherit ({
        imports = cfg.enable [
            ./nix.nix
            ./users.nix
        ];
    });
}
