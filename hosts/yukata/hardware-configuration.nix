# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/d1755698-a79b-4f32-83e0-a3be7ef3eeb0";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/98AD-ADE6";
      fsType = "vfat";
    };

  fileSystems."/mnt/Windows" =
    { device = "/dev/disk/by-uuid/44B04501B044FB46";
      fsType = "ntfs";
    };

    fileSystems."/mnt/Besenkammer" = {
    device = "//192.168.0.100/Besenkammer";
    fsType = "cifs";
    options = let
      # this line prevents hanging on network split
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";

      in [
        "${automount_opts}"
        "nofail"
        "credentials=/etc/samba/credentials-besenkammer"
        "uid=${user.name}"
        "gid=users"
      ];
  };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/a10ed67a-61fe-4942-85b4-4c256e2c0552"; }
    ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
