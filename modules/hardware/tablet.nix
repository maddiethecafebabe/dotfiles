{ lib, pkgs, config, modules, ... }: 
with lib;
let
    cfg = config.modules.desktop;
in {
    # if there is no desktop support we dont need a graphics tablet driver
    config = mkIf cfg.enable {
        hardware.opentabletdriver.enable = true;
    };
}
