{ lib, config, ... }: 
with lib;
let
    cfg = config.modules.desktop.pipewire;
in {
    options = {
        modules.desktop.pipewire.enable = mkOption {
            type = types.bool;
            default = false;
        };
    };

    config = mkIf cfg.enable {
        services.pipewire = {
            enable = true;
            alsa.enable = true;
            alsa.support32Bit = true;
            pulse.enable = true;
        };

        hardware.pulseaudio.enable = false;
        security.rtkit.enable = true;
    };
}
