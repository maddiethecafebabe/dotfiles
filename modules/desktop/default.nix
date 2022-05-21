{ lib, config, modules, pkgs, ... }:
with lib;
let 
    cfg = config.modules.desktop;
in {
    imports = [
        ./gnome.nix
        ./pipewire.nix
        ./flatpak.nix
        ./virtualisation.nix
        ./gaming
        ./activate-linux.nix
        ./emacs.nix
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
            flatpak.enable = mkDefault true;
            pipewire.enable = mkDefault true;
            activate-linux.enable = mkDefault false;
            emacs.enable = mkDefault true;
        };

        services.mullvad-vpn.enable = true;

        # xdg-open will behave weird (read: open websites in gnome text editor)
        # if no browser is installed so lets just do it here
        environment.systemPackages = with pkgs; [
            firefox
            pavucontrol
            mullvad-vpn
            deluge
        ];
    };
}
