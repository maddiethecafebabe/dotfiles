{ lib, pkgs, config, ... }:
with lib;
let
    serverCfg = config.modules.server;
    cfg = config.modules.server.sonarr;
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

        port = mkOption {
            type = types.str;
            default = "8989";
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
                    "${cfg.domain}" = {
                        addSSL = cfg.enableSsl;
                        enableACME = cfg.enableSsl;
                        locations."/${cfg.subDomain}" = {
                            proxyPass = "http://localhost:${cfg.port}";
                        };
                    };

                    "${cfg.subDomain}.${cfg.domain}" = {
                        addSSL = cfg.enableSsl;
                        enableACME = cfg.enableSsl;
                        locations."/" = {
                            proxyPass = "http://localhost:${cfg.port}";
                        };
                    };
                };
            };
        };

        security.acme.certs = mkIf cfg.enableSsl {
            "${cfg.domain}".email = mkIf cfg.enableSsl "${acmeEmail}";
            "${cfg.subDomain}".email = mkIf cfg.enableSsl "${acmeEmail}";
        };
    };
}
