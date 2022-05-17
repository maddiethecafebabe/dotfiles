{ pkgs, lib, config, ... }: 
with lib;
let
    cfg = config.modules.desktop.activate-linux;
    app = "${pkgs.activate-linux}/bin/activate-linux";
in {
    options = {
        modules.desktop.activate-linux.enable = mkOption {
            type = types.bool;
            default = false;
            description = "Displays a watermark to activate linux";
        };
    };

    config = mkIf cfg.enable {
        systemd.user.services.activate-linux = mkIf cfg.enable {
            description = "The \"Activate Windows\" watermark, now for linux";
            wantedBy = [ "graphical-session.target" ];
            partOf = [ "graphical-session.target" ];

            serviceConfig = {
                Type = "simple";
                ExecStart = "${app}";
                Restart = "on-failure";
            };
        };
    };
}
