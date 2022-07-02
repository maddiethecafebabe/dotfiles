{config, ...}: let
  mkBind = from: extraOptions: {
    device = from;
    fsType = "none";
    options =
      [
        "bind"
      ]
      ++ extraOptions;
  };
in {
  fileSystems = let
    mountName = "/mnt/Besenkammer";
    extraOptions = ["nofail"];
  in {
    "/mnt/Windows" = {
      device = "/dev/disk/by-uuid/221C7FE01C7FAE03";
      fsType = "ntfs";
      options = [
        "nofail"
      ];
    };

    "/mnt/Shared" = {
      device = "/dev/disk/by-uuid/febbdd5d-94b6-4e64-9398-eafd2d71800f";
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

    "/mnt/Besenkammer" = {
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

    "${config.user.homeDir}/Pictures" = mkBind "${mountName}/Pictures" extraOptions;
    "${config.user.homeDir}/Downloads" = mkBind "${mountName}/Downloads" extraOptions;
    "${config.user.homeDir}/Documents" = mkBind "${mountName}/Documents" extraOptions;
    "${config.user.homeDir}/Music" = mkBind "${mountName}/Music" extraOptions;
    "${config.user.homeDir}/Videos" = mkBind "${mountName}/Videos" extraOptions;
  };
}
