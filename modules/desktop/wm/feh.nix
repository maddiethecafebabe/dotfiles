{ lib, pkgs, config, ... }: 
with lib;
let
    cfg = config.modules.desktop.wm.feh;
in {
    options.modules.desktop.wm.feh = {
        enable = mkOption {
            type = types.bool;
            default = false;
        };

        wallpaper = mkOption {
            type = types.path;
            default = (import ../wallpapers.nix { inherit pkgs lib; }).default;
        };

        randomizeDir = mkOption {
            type = types.bool;
            default = false;
            description = "will treat wallpaper as a directory to source images from";
        };

        extraArgs = mkOption {
            type = types.str;
            default = "";
        };

        mode = mkOption { type = types.str; default = "fill"; description = "one of scale, fill, center or max"; };
    };

    config = let
        src = if cfg.randomizeDir
            then "--randomize ${cfg.wallpaper}"
            else "${cfg.wallpaper}";
        command = "${pkgs.feh}/bin/feh --no-fehbg --bg-${cfg.mode} ${src} ${cfg.extraArgs} &";
    in mkIf cfg.enable {
        services.xserver.displayManager.sessionCommands = command;
    };
}
