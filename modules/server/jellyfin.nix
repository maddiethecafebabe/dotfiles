{ lib, pkgs, config, ... }:
with lib;
let
    cfg = config.modules.server.jellyfin;
in {
    options.modules.server.jellyfin = {
        enable = mkOption {
            type = types.bool;
            default = false;
        };
    };

    config = mkIf cfg.enable {
        services.jellyfin.enable = true;
    };
}
