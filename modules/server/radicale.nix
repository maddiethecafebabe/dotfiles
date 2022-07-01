{ lib, pkgs, config, ... }:
with lib;
let
    serverCfg = config.modules.server;
    cfg = config.modules.server.radicale;
    port = "5232";
    mkVhost = import ./mkSimpleNginxVhost.nix;
in {
    options.modules.server.radicale = {
        enable = mkEnableOption "radicale";

        domain = mkOption {
            type = types.str;
            default = serverCfg.domain;
        };

        subDomain = mkOption {
            type = types.str;
            default = "radicale";
        };
    };

    config = mkIf cfg.enable (recursiveUpdate {
            services.radicale = {
                enable = true;

                settings = {
                    auth = {
                        type = "htpasswd";
                        htpasswd_filename = "/secrets/radicale.auth";
                        htpasswd_encryption = "bcrypt";
                    };
                };
            };
        }
        (mkVhost {
            inherit lib cfg serverCfg port;
            locationsExtraConfig = ''
                proxy_set_header  X-Script-Name /;
                proxy_set_header  X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_pass_header Authorization;
            '';
        })
    );
}
