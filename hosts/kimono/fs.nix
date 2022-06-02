{ config, ... }:

{
      fileSystems."/mnt/Windows" =
    { device = "/dev/disk/by-uuid/221C7FE01C7FAE03";
      fsType = "ntfs";
      options = [
        "nofail"
      ];
    };

  fileSystems."/mnt/Shared" =
    { device = "/dev/disk/by-uuid/febbdd5d-94b6-4e64-9398-eafd2d71800f";
      fsType = "btrfs";
      options = [
        "subvol=/"
        "nofail"
        "noatime"
        "nodiratime"
        "rw"
        "exec"
      ];
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
        "uid=${config.user.name}"
        "gid=${config.user.group}"
      ];
  };
}
