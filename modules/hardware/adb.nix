{ pkgs, lib, user, config, ... }:
with lib;
let
    cfg = config.modules.hardware.adb;
in {
    options.modules.hardware.adb = {
        enable = mkOption { type = types.bool; default = true; };
    };

    config = mkIf cfg.enable {
        programs.adb.enable = true;
        user.extraGroups = [ "adbusers" ];
    };
}
