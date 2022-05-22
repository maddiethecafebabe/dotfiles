{ lib, pkgs, config, ... }:
with lib;
let
    serverCfg = config.modules.server;
    cfg = config.modules.server.jellyfin;
in {
    options.modules.server.jellyfin = {
        enable = mkOption {
            type = types.bool;
            default = false;
        };

        domain = mkOption {
            type = types.str;
            default = config.modules.server.domain;
        };

        subDomain = mkOption {
            type = types.str;
            default = "media";
        };

        port = mkOption {
            type = types.str;
            default = "8096";
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

                virtualHosts = {
                    "${cfg.domain}" = {
                        addSSL = cfg.enableSsl;
                        enableACME = cfg.enableSsl;
                        locations = {
                            "= /${cfg.subDomain}" = {
                                return = "302 /${cfg.subDomain}/";
                            };
                            "/${cfg.subDomain}/" = {
                                proxyPass = "http://localhost:${cfg.port}/";
                            };
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
            "${cfg.domain}".email = cfg.acmeEmail;
            "${cfg.subDomain}.${cfg.domain}".email = cfg.acmeEmail;
        };
    };
}
