
{ pkgs, lib, config, ... }:
with lib;
let 
    cfg = config.modules.desktop.flatpak;
in {
    options = {
        modules.desktop.flatpak.enable = mkOption {
            type = types.bool;
            default = false;
        };
    };

    config = mkIf cfg.enable  {
        xdg.portal = {
            enable = true;
            extraPortals = [
                # pkgs.xdg-desktop-portal-gtk
            ];
        };

        services.flatpak.enable = true;
    };
}
