{ lib, pkgs, pkgs-unstable, config, ... }:
with lib;
let
    cfg = config.modules.desktop.gaming;
in {
    options.modules.desktop.gaming = {
        enable = mkOption {
            type = types.bool;
            default = false;
        };
    };

    config = mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
            lutris
        ];

    };
}
