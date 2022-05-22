{ lib, pkgs, config, ... }:
with lib;
let
    cfg = config.modules.server.jellyfin;
in {
    options.modules.server.jellyfin = {
        enable = mkOption {
            type = types.bool;
            default = false;
        };
    };

    config = mkIf cfg.enable {
        services = {
            jellyfin = {
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

                virtualHosts."media.seifuku.local" = {
                    addSSL = true;
                    enableACME = true;
                    locations."/" = {
                        proxyPass = "http://localhost:8096";
                    };
                };
            };
        };

        security.acme = {
            acceptTerms = true;
            certs = {
                "media.seifuku.local".email = "maddie@cafebabe.date";
            };
        };
    };
}
