{ config, pkgs, pubkeys, grab-bag, ... }:

{
    imports =
    [ # Include the results of the hardware scan.
        ./hardware-configuration.nix
        ./fs.nix
    ];

    networking.hostName = "kimono"; # Define your hostname.

    modules = {
        core.user.authorizedKeys = pubkeys.yukata;
        desktop = {
            enable = true;
            gnome.enable = false;
            wm.enable = true;
            virtualisation.enable = true;
        };
        editors = {
            vim.enable = true;
            vscode.enable = true;
        };
        server = {
            domain = "kimono.local";

            ssl = {
                enable = true;
                self = {
                    key = "/secrets/kimono/priv.key";
                    cert = "/secrets/kimono/cert.crt";
                };
            };
        };
    };

    boot.initrd.kernelModules = [ "amdgpu" ];
}
