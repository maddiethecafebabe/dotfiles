{ lib, pkgs, config, ... }:
with lib;
let
    cfg = config.modules.server.radarr;
in {
    options.modules.server.radarr = {
        enable = mkOption {
            type = types.bool;
            default = false;
        };

        domain = mkOption {
            type = types.str;
        };

        enableSsl = mkOption {
            type = types.bool;
            default = false;
        };

        acmeEmail = mkOption {
            type = types.str;
        };
    };

    config = mkIf cfg.enable {
        services = {
            radarr = {
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

                virtualHosts."${cfg.domain}" = {
                    addSSL = cfg.enableSsl;
                    enableACME = cfg.enableSsl;
                    locations."/" = {
                        proxyPass = "http://localhost:7878";
                    };
                };
            };
        };

        security.acme.certs = mkIf cfg.enableSsl {
            "${cfg.domain}".email = mkIf cfg.enableSsl "${cfg.acmeEmail}";
        };
    };
}
