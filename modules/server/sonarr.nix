{ lib, pkgs, config, ... }:
with lib;
let
    serverCfg = config.modules.server;
    cfg = config.modules.server.sonarr;
    port = "8989";
    mkVhost = import ./mkSimpleNginxVhost.nix;
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
    };

    config = mkIf cfg.enable (recursiveUpdate {
            services.sonarr = {
                enable = true;
                openFirewall = true;

                # give it access to my mounts
                group = "users";
            };
        }
        (mkVhost { inherit lib cfg serverCfg port; })
    );
}
