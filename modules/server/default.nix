{ lib, pkgs, config, ... }:
with lib;
let
    cfg = config.modules.server;
in {
    imports = [
        ./jellyfin.nix
        ./sonarr.nix
        ./radarr.nix
    ];

    options.modules.server = {
        acmeEmail = mkOption {
            type = types.str;
        };

        domain = mkOption {
            type = types.str;
        };

        enableSsl = mkOption {
            type = types.bool;
            default = false;
        };
    };

    config = {
          # Allowed TCP range
  networking.firewall.allowedTCPPorts = [ 80 443 37586 ];

    };
}
