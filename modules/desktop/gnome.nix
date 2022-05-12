# i use gnome, i am sorry

{ pkgs, lib, config, ... }:
with lib;
let 
    cfg = config.modules.desktop.gnome;
in {
    options = {
        modules.desktop.gnome.enable = mkOption {
            type = types.bool;
            default = false;
            description = ''
                GNOME time
            '';
        };
    };

    config = mkIf cfg.enable  {
        services.xserver = { 
            enable = true;
            displayManager.gdm = {
                enable = true;
                wayland = mkDefault false;
            };
            desktopManager.gnome.enable = true;
        };

        services.dbus.packages = [ pkgs.dconf ]; 

        programs.dconf.enable = true;

        environment = mkIf cfg.enable  {
            systemPackages = with pkgs; [
                gnome.gnome-tweaks
                gnome.gnome-screenshot
                gnomeExtensions.vertical-overview
                gnome3.adwaita-icon-theme
            ];

            # get rid of some of the worst bloat in gnome, reenable on demand
            gnome.excludePackages = with pkgs; [
                gnome.cheese gnome-photos gnome.gnome-music gnome.gedit epiphany 
                evince gnome.gnome-characters gnome.totem gnome.tali gnome.hitori
                gnome.iagno gnome.atomix gnome-tour gnome.geary gnome.gnome-weather
                gnome.gnome-contacts gnome.gnome-calendar gnome.gnome-maps
            ];
        };
    };
}
