{ lib, config, modules, pkgs, ... }:
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
            gayming.steam.enable = mkDefault false;
            home.enable = mkDefault true;
        };

        # xdg-open will behave weird (read: open websites in gnome text editor)
        # if no browser is installed so lets just do it here
        environment.systemPackages = with pkgs; [
            firefox
        ];
    };
}
