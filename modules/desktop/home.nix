
{ pkgs, lib, config, ... }:
with lib;
let 
    cfg = config.modules.desktop.home;
in {
    options = {
        modules.desktop.home.enable = mkOption {
            type = types.bool;
            default = false;
        };
    };

    config = mkIf cfg.enable  {
        
    };
}
