{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ acl ];

  fileSystems."/mnt/Besenkammer" =
    { device = "/dev/disk/by-uuid/3d37d0bc-c7d2-4004-84fc-52dafec9c851";
      fsType = "btrfs";
      options = [
        "noatime"
        "nodiratime"
        "defaults"
        "nofail"
        "acl"
      ];
    };
}
