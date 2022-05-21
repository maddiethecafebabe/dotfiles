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
        editors = {
            emacs.enable = true;
            vim.enable = true;
        };
    };

    boot.initrd.kernelModules = [ "amdgpu" ];
}
