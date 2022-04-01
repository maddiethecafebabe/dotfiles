{ lib, config, modules, ... }:
with lib;
let 
    cfg = config.modules.desktop;
in {
    imports = [
        ./gnome.nix
        ./gayming
        ./home.nix
    ];

    options = {
        modules.desktop.enable = mkOption {
            type = types.bool;
            default = true;
            description = ''
                enables various things youll probably want from a desktop
            '';
        };
    };

    config = mkIf cfg.enable {
        modules.desktop = {
            gnome.enable = mkDefault true;
            gayming.steam.enable = mkDefault true;
            home.enable = mkDefault true;
        };
    };
}
