{ lib, config, pkgs, ... }:
with lib;
let
    cfg = config.modules.desktop.media.video;
in {
    options.modules.desktop.media.video = {
        enable = mkEnableOption "video module";
    };

    config = mkIf cfg.enable {
        user.packages = with pkgs; [ 
            vlc
            mpv
            handbrake
        ];
    };
}
