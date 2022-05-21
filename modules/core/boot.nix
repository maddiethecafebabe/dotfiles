{ config, lib, pkgs, ... }:
with lib;
let
    cfg = config.modules.core.boot;
in {
    options.modules.core.boot = {
        enable = mkOption { type = types.bool; default = true; };
        systemd.enable = mkOption { type = types.bool; default = true; };
    };

    config = mkIf cfg.enable {
        boot.loader.systemd-boot.enable = cfg.systemd.enable;

        boot.loader.efi.canTouchEfiVariables = true;
        boot.loader.grub.useOSProber = true;
    };
}
