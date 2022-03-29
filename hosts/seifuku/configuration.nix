
  { config, pkgs, lib, ... }:

  let
    hostname = "seifuku";
  in {
    imports = [
	"${fetchTarball "https://github.com/NixOS/nixos-hardware/archive/936e4649098d6a5e0762058cb7687be1b2d90550.tar.gz" }/raspberry-pi/4"
	./hardware-configuration.nix
        ./user-configuration.nix
        ./security.nix
        ./fs.nix
        ./samba.nix
    ];

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

