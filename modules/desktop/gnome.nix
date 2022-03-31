# i use gnome, i am sorry

{ pkgs, lib, config, ... }:
with lib;
let xcfg = config.services.xserver; in
{
    services.xserver = mkIf xcfg.enable  {
        displayManager.gdm = {
            enable = true;
            wayland = false;
        };
        desktopManager.gnome.enable = true;
    };

    environment = mkIf xcfg.enable {
        systemPackages = with pkgs; [
            gnome.gnome-tweaks
        ];

        # get rid of some of the worst bloat in gnome, reenable on demand
        gnome.excludePackages = with pkgs; [
            gnome.cheese gnome-photos gnome.gnome-music gnome.gedit epiphany 
            evince gnome.gnome-characters gnome.totem gnome.tali gnome.hitori
            gnome.iagno gnome.atomix gnome-tour gnome.geary gnome.gnome-weather
            gnome.gnome-contacts gnome.gnome-calendar gnome.gnome-maps
        ];
    };
}
