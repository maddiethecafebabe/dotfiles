{ lib, config, grab-bag, ... }:
with lib;
let
    cfg = config.modules.hardware.switch;
in {
    options.modules.hardware.switch = {
        enable = mkOption { type = types.bool; default = false; };
    };

    config = mkIf cfg.enable {
        user.packages = [ grab-bag.fusee-nano ];
    };
}
