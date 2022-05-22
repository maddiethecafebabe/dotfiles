{ config, pkgs, lib, modules, ... }:

let
    acmeEmail = "maddie@cafebabe.date";
    hostName = "seifuku";
    domain = "${hostName}.local";
in {
    imports = [
        ./hardware-configuration.nix
        ./security.nix
        ./fs.nix
        ./samba.nix
    ];

    modules = {
        core = {
            nix-ld.enable = false;
            boot.systemd-boot.enable = false;
        };
        desktop.enable = false;
        server = {
            inherit domain acmeEmail;
            enableSsl = true;

            jellyfin.enable = true;
            sonarr.enable = true;
            radarr.enable = true;
        };
    };

    networking = {
        inherit hostName;
        wireless = {
            enable = true;
            userControlled.enable = true;
        };
    };

    # Enable GPU acceleration
    hardware.raspberry-pi."4".fkms-3d.enable = true;
}
