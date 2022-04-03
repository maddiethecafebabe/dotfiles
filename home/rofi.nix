{ home, pkgs, lib, ... }:
with lib;
let
    syscfg = modules.desktop.gnome;
in {
    config = {
        home.packages = [ pkgs.papirus-icon-theme ];

        programs.rofi = {
            enable = true;

            extraConfig = {
                modi = "window,drun,ssh,combi,run";
                combi-modi = "window,drun,ssh,run";
                show-icons = true;
                icon-theme = "Papirus";
            };

            theme = "solarized";
        };

        # TODO: figure out a way to access my system configuration from in here
        #       and make this only take effect when syscfg.gnome.enable
        dconf.settings = {
            "org/gnome/settings-daemon/plugins/media-keys" = {
                custom-keybindings = [
                    "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
                ];
            };
            "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
                binding = "<Super>space";
                command = "rofi -show combi";
                name = "Rofi";
            };
        };
    };
}
