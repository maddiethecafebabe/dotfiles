{ config, pkgs, pubkeys, ... }:

{
    imports =
    [ # Include the results of the hardware scan.
        ./hardware-configuration.nix
        ./fs.nix
    ];

    networking.hostName = "kimono"; # Define your hostname.

    modules = {
        core.user.ssh_keys = pubkeys.yukata;
        desktop = {
            enable = true;
            virtualisation.enable = true;
        };
        editors.enable-all = true;
        server = {
            acmeEmail = "maddie@cafebabe.date";
            domain = "kimono.local";
            enableSsl = false;

            # sonarr.enable = true;
            radarr.enable = true;
            paperless.enable = true;
        };
    };

    environment.systemPackages = with pkgs; [ ];

    boot.initrd.kernelModules = [ "amdgpu" ];
}
