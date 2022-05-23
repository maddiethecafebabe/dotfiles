{ config, pkgs, modules, ... }:

{
    imports =
    [ # Include the results of the hardware scan.
        ./hardware-configuration.nix
        ./fs.nix
    ];

    networking.hostName = "kimono"; # Define your hostname.

    modules = {
        desktop = {
            enable = true;
            virtualisation.enable = true;
        };
        editors.enable-all = true;
        server = {
            acmeEmail = "maddie@cafebabe.date";
            domain = "kimono.local";
            enableSsl = true;

            # sonarr.enable = true;
            radarr.enable = true;
        };
    };

    boot.initrd.kernelModules = [ "amdgpu" ];
}
