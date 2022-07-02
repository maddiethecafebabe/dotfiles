{
  config,
  pkgs,
  lib,
  modules,
  pubkeys,
  grab-bag,
  ...
}: let
  acmeEmail = "maddie@cafebabe.date";
  hostName = "seifuku";
  domain = "wagu.cafebabe.date";
in {
  imports = [
    ./hardware-configuration.nix
    ./fs.nix
    ./samba.nix
  ];

  modules = {
    core = {
      nix-ld.enable = false;
      boot.systemd-boot.enable = false;
      user.authorizedKeys = pubkeys.workstations;
    };
    desktop.enable = false;
    dev.enable = false;
    server = {
      inherit domain;
      enable = true;

      ssl = {
        enable = true;
        self = {
          key = "/secrets/seifuku/priv.key";
          cert = "/secrets/seifuku/cert.crt";
        };
      };

      jellyfin.enable = true;
      sonarr.enable = true;
      radarr.enable = true;
      paperless.enable = true;
      radicale.enable = true;
      adguardhome = {
        enable = true;
        settings = {
            users = [
                # go ahead, crack it. i believe in your habilities
                { name = "maddie"; password = "$2y$10$ggaJIptyrV6HLWN5hpHm.eb0ajLLSj6CuAaxJDClBhzzel9W82d7K"; }
            ];
        };
      };
    };
  };

  networking = {
    inherit hostName;
    wireless = {
      enable = true;
      userControlled.enable = true;
    };
  };

  hardware.homebrew.udpih.enable = true;

  # Enable GPU acceleration
  hardware.raspberry-pi."4".fkms-3d.enable = true;
}
