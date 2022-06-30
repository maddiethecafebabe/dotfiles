{ lib, pkgs, config, ... }:
with lib;
let
    serverCfg = config.modules.server;
    cfg = config.modules.server.paperless;
    port = 28981;
    mkVhost = import ./mkSimpleNginxVhost.nix;
in {
    options.modules.server.paperless = {
        enable = mkEnableOption "paperless";

        domain = mkOption {
            type = types.str;
            default = config.modules.server.domain;
        };

        subDomain = mkOption {
            type = types.str;
            default = "documents";
        };
    };

    config = mkIf cfg.enable (recursiveUpdate {
            services.paperless = {
                enable = true;
                port = port;
                passwordFile = mkDefault "/secrets/paperless-superuser-password";
                extraConfig = {
                    PAPERLESS_OCR_LANGUAGE = "deu+eng";
                    PAPERLESS_FILENAME_FORMAT = "{created_year}/{correspondent}/{created_month}/{title}";
                };
            };
            }
        (mkVhost { inherit lib cfg serverCfg; port = toString port; })
    );
}
