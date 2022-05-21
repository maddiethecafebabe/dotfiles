{ pkgs, lib, config, ... }:
with lib;
let
    cfg = config.modules.core.ssh;
in {
    options.modules.core.ssh = {
        enable = mkOption { type = types.bool; default = true; };
    };

    config = mkIf cfg.enable {
        services.openssh.enable = true;


    };
}
