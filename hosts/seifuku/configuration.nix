
  { config, pkgs, lib, modules, ... }:

  let
    hostName = "seifuku";
  in {
    imports = [
	    ./hardware-configuration.nix
      ./security.nix
      ./fs.nix
      ./samba.nix
    ];

    modules = {
      core.nix-ld.enable = false;
      desktop.enable = false;
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

    hardware.pulseaudio.enable = true;
  }
