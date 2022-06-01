{ lib, pkgs, config, ... }:
with lib;
let
    serverCfg = config.modules.server;
    cfg = config.modules.server.paperless;
    port = 28981;
in {
    options.modules.server.paperless = {
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
            default = "documents";
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
        environment.etc."ImageMagick-x/policy.xml".text = "";

        services = {
            paperless = {
                enable = true;
                port = port;
                passwordFile = mkDefault "/secrets/paperless-superuser-password";
                extraConfig = {
                    PAPERLESS_OCR_LANGUAGE = "deu+eng";
                    PAPERLESS_FILENAME_FORMAT = "{created_year}/{correspondent}/{created_month}/{title}";
                };
            };
            nginx = {
                enable = true;

                virtualHosts = {
                    "${cfg.subDomain}.${cfg.domain}" = {
                        addSSL = cfg.enableSsl;
                        enableACME = cfg.enableSsl;
                        locations."/" = {
                            proxyPass = "http://localhost:${toString port}";
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
