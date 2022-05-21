
  { config, pkgs, lib, modules, ... }:

  let
    hostname = "seifuku";
  in {
    imports = [
	    ./hardware-configuration.nix
      ./security.nix
      ./fs.nix
      ./samba.nix
    ];

    # where we are going we wont need no graphics
    modules.desktop.enable = false;

    networking = {
      hostName = hostname;
      wireless = {
        enable = true;
        userControlled.enable = true;
      };
    };

    # Enable GPU acceleration
    hardware.raspberry-pi."4".fkms-3d.enable = true;

    hardware.pulseaudio.enable = true;
  }
