{ pkgs, config, lib, ... }:
with lib;
let
    cfg = config.modules.hardware.graphics;
in {
    options.modules.hardware.graphics = {
        enable = mkEnableOption "graphics stuff";
    };

    config = mkIf (cfg.enable || config.modules.desktop.enable) {
        hardware.opengl = {
            enable = true;
            driSupport = true;
            driSupport32Bit = true;
            extraPackages = with pkgs; [
                mesa.drivers
                rocm-opencl-icd
                rocm-opencl-runtime
                clinfo
            ];
        };

        environment.systemPackages = [ pkgs.glxinfo ];
    };
}
