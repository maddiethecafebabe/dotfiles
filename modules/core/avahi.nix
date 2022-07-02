# avahi makes my machines reachable in the local network
# as <hostname>.local, its pretty neat
{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.core.avahi;
in {
  options.modules.core.avahi = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    services.avahi = {
      enable = true;
      nssmdns = true;
      publish = {
        enable = true;
        addresses = true;
        workstation = true;
      };
    };
  };
}
