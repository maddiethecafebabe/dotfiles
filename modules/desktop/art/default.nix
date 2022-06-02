{ lib, config, pkgs, user, ... }:
with lib;
let
    cfg = config.modules.desktop.art;
in {
    imports = [ ];

    options.modules.desktop.art = {
        enable = mkOption {
            type = types.bool;
            default = false;
        };
    };

    config = mkIf cfg.enable {
        user.packages = with pkgs; [
            libresprite
            krita
            grab-bag.MagicaVoxel
            (grab-bag.sai2.override { executable = "${config.user.homeDir}/.local/Tools/Art/sai2/sai2.exe"; })
        ];
    };
}
