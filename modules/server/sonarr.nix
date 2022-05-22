{ lib, pkgs, config, ... }:
with lib;
let
    cfg = config.modules.server.sonarr;
in {
    options.modules.server.sonarr = {
        enable = mkOption {
            type = types.bool;
            default = false;
        };
    };

    config = mkIf cfg.enable {
        services = {
            sonarr = {
                enable = true;
                openFirewall = true;

                # give it access to my mounts
                group = "users";
            };
            nginx = {
                enable = true;
                recommendedGzipSettings = true;
                recommendedOptimisation = true;
                recommendedProxySettings = true;
                recommendedTlsSettings = true;

                virtualHosts."sonarr.seifuku.local" = {
                    addSSL = true;
                    enableACME = true;
                    locations."/" = {
                        proxyPass = "http://localhost:8989";
                    };
                };
            };
        };

        #security.acme.certs."sonarr.seifuku.local".email = "maddie@cafebabe.date";
    };
}
