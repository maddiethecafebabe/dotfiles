{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [acl];

  fileSystems."/mnt/Besenkammer" = {
    device = "/dev/disk/by-uuid/3d37d0bc-c7d2-4004-84fc-52dafec9c851";
    fsType = "btrfs";
    options = let
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
      performance_opts = "noatime,nodiratime";
    in [
      # "${automount_opts}"
      "${performance_opts}"
      "nofail"
      "acl"
    ];
  };
}
