{ lib, config, pkgs, ... }:
with lib;
let
    cfg = config.modules.desktop.media.video;
in {
    options.modules.desktop.media.video = {
        enable = mkOption {
            type = types.bool;
            default = false;
        };
    };

    config = mkIf cfg.enable {
        user.packages = with pkgs; [ 
            vlc
            mpv
            handbrake
        ];
    };
}
