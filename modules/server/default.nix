{ lib, pkgs, config, ... }:
with lib;
let
    cfg = config.modules.server;
in {
    imports = [
        ./jellyfin.nix
        ./sonarr.nix
        ./radarr.nix
    ];

    options.modules.server = {
        enable = mkOption {
            type = types.bool;
            default = false;
        };

        acmeEmail = mkOption {
            type = types.str;
        };

        domain = mkOption {
            type = types.str;
        };

        enableSsl = mkOption {
            type = types.bool;
            default = false;
        };
    };

    config = mkIf cfg.enable {
        networking.firewall.allowedTCPPorts = [ 80 443 ];

        services.nginx = {
            enable = cfg.enable;
            
            virtualHosts."${cfg.domain}" = {
                default = true;
                addSSL = cfg.enableSsl;
                enableACME = cfg.enableSsl;
            };    
        };

        security.acme = mkIf cfg.enableSsl {
            acceptTerms = true;
            certs = {
                "${cfg.domain}".email = cfg.acmeEmail;
            };
        };
    };
}
