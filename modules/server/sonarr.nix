{ lib, pkgs, config, ... }:
with lib;
let
    serverCfg = config.modules.server;
    cfg = config.modules.server.sonarr;
    port = "8989";
in {
    options.modules.server.sonarr = {
        enable = mkOption {
            type = types.bool;
            default = false;
        };

        domain = mkOption {
            type = types.str;
            default = serverCfg.domain;
        };

        subDomain = mkOption {
            type = types.str;
            default = "sonarr";
        };

        acmeEmail = mkOption {
            type = types.str;
            default = serverCfg.acmeEmail;
        };

        enableSsl = mkOption {
            type = types.bool;
            default = serverCfg.enableSsl;
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

                virtualHosts = {
                    "${cfg.subDomain}.${cfg.domain}" = {
                        addSSL = cfg.enableSsl;
                        enableACME = cfg.enableSsl;
                        locations."/" = {
                            proxyPass = "http://localhost:${port}";
                        };
                    };
                };
            };
        };

        security.acme.certs = mkIf cfg.enableSsl {
            "${cfg.subDomain}.${cfg.domain}".email = cfg.acmeEmail;
        };
    };
}
