{ lib, pkgs, config, ... }:
with lib;
let 
    cfg = config.modules.desktop.gayming.steam;
in {
    options = {
        modules.desktop.gayming.steam.enable = mkOption {
            type = types.bool;
            default = false;
        };
    };

    config = mkIf cfg.enable {
        nixpkgs.config.allowUnfree = true;
        
        programs.steam.enable = true;
    };
}
