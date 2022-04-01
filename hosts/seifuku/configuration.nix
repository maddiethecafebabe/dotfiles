
  { config, pkgs, lib, modules, ... }:

  let
    hostname = "seifuku";
  in {
    imports = [
	"${fetchTarball "https://github.com/NixOS/nixos-hardware/archive/936e4649098d6a5e0762058cb7687be1b2d90550.tar.gz" }/raspberry-pi/4"
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

    environment.systemPackages = with pkgs; [ vim git ];

    # Enable GPU acceleration
    hardware.raspberry-pi."4".fkms-3d.enable = true;


    hardware.pulseaudio.enable = true;
  }

