{ lib, config, modules, ... }:
with lib;
let 
    cfg = config.modules.desktop;
in {
    imports = [
        ./gnome.nix
    ];

    options = {
        modules.desktop.enable = mkOption {
            type = types.bool;
            default = true;
        };
    };

    config = mkIf cfg.enable {
        modules.desktop.gnome.enable = true;
    };
}
