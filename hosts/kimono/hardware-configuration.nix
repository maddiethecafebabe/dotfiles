# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  user,
  users,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci" "usbhid" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-amd"];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/f60ae98c-2c8f-4993-bea6-fb93b0981ad4";
    fsType = "ext4";
    options = ["noatime" "nodiratime"];
  };

  fileSystems."/nix/store" = {
    device = "/nix/store";
    fsType = "none";
    options = ["bind"];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/9674-B323";
    fsType = "vfat";
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/bd049d1a-8b70-4cc8-a4b5-541f44323ad5";}
  ];

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = lib.mkDefault false;
  networking.interfaces.enp37s0.useDHCP = lib.mkDefault true;

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
