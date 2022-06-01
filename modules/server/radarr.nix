{ lib, pkgs, config, ... }:
with lib;
let
    serverCfg = config.modules.server;
    cfg = config.modules.server.radarr;
    port = "7878";
in {
    options.modules.server.radarr = {
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
            default = "radarr";
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
            radarr = {
                enable = true;
                openFirewall = true;

                # give it access to my mounts
                group = "users";
            };
            nginx = {
                enable = true;

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
