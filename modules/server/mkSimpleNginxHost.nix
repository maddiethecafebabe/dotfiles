# this can perfectly create my jellyfin/radarr/sonarr configs but 
# i ended up deciding against it because i feel like it hurts readability
# a lot, especially when youre not comfortable with nix

args @ { lib, pkgs, config, ... }:
args' @ { name, port, installExpr ? null }:
with lib;
let
    serverCfg = config.modules.server;
    cfg = config.modules.server."${name}";
    installExpr' = if installExpr != null 
                    then installExpr
                    else args: {
        services = {
            "${name}" = {
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
in {
    options.modules.server."${name}" = {
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
            default = name;
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

    config = mkIf cfg.enable ( installExpr' ({ inherit cfg serverCfg; } // args // args') );
}
