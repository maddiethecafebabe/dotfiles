{ lib, config, grab-bag, ... }:
with lib;
let
    cfg = config.modules.hardware.switch;
in {
    options.modules.hardware.switch = {
        enable = mkOption { type = types.bool; default = true; };
    };

    config = mkIf cfg.enable {
        user.packages = [ grab-bag.fusee-nano ];

        services.udev.extraRules = ''
            # Nintendo Switch
            SUBSYSTEM=="usb", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="3000", MODE="0666"

            # Nintendo Switch in ~~space~~ RCM
            SUBSYSTEM=="usb", ATTRS{idVendor}=="0955", ATTRS{idProduct}=="7321", MODE="0666"
        '';
    };
}
