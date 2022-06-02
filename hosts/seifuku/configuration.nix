{ config, pkgs, lib, modules, pubkeys, ... }:

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
            user.ssh_keys = pubkeys.workstations;
        };
        desktop.enable = false;
        dev.enable = false;
        server = {
            inherit domain acmeEmail;
            enable = true;
            enableSsl = false;

            jellyfin.enable = true;
            sonarr.enable = true;
            radarr.enable = true;
            paperless.enable = true;
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
