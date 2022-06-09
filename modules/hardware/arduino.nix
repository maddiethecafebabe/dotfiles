{ lib, config, grab-bag, ... }:
with lib;
let
    cfg = config.modules.hardware.arduino;
in {
    options.modules.hardware.arduino = {
        enable = mkOption { type = types.bool; default = true; };
    };

    config = mkIf cfg.enable {
        # user.packages = [ grab-bag.fusee-nano ];
    
        services.udev.extraRules = ''
            # nodemcu esp8266
            SUBSYSTEM=="tty", GROUP="plugdev", MODE="0666"
            ACTION=="add", SUBSYSTEMS=="usb", ATTRS{idVendor}=="10c4", ATTRS{idProduct}=="ea60", SYMLINK+="nodemcu"
        '';
    };    
}
