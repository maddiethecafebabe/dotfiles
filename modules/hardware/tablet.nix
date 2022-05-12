{ lib, pkgs, config, modules, ... }: 
with lib;
let
    cfg = config.modules.desktop;
in {
    # if there is no desktop support we dont need a graphics tablet driver
    config = mkIf cfg.enable {
        hardware.opentabletdriver.enable = true;
    
        services.udev.extraRules = ''
            # XP-Pen Artist 15.6
            SUBSYSTEM=="hidraw", ATTRS{idVendor}=="28bd", ATTRS{idProduct}=="091a", MODE="0666"
            SUBSYSTEM=="usb", ATTRS{idVendor}=="28bd", ATTRS{idProduct}=="091a", MODE="0666"
            SUBSYSTEM=="input", ATTRS{idVendor}=="28bd", ATTRS{idProduct}=="091a", ENV{LIBINPUT_IGNORE_DEVICE}="1"
        '';
            
    };
}
