# i use gnome, i am sorry

{ pkgs, lib, config, ... }:
with lib;
let 
    cfg = config.modules.desktop.gnome;

    wallpapers = import ./wallpapers.nix { inherit lib pkgs; };
in {
    options.modules.desktop.gnome = {
        enable = mkEnableOption "GNOME";

        wallpaper = mkOption {
            type = types.str;
            default = "${wallpapers.default}";
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

        user.homeRaw.dconf.settings = {
            "org/gnome/desktop/background" = {
                "picture-uri" = "${cfg.wallpaper}";
                "picture-uri-dark" = "${cfg.wallpaper}";
            };
            "org/gnome/desktop/screensaver" = {
                "picture-uri" = "${cfg.wallpaper}";
            };
        };

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
