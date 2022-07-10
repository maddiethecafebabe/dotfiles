{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf mkOption types;
  cfg = config.modules.desktop.wm;
  desktopCfg = config.modules.desktop;
in {
  imports = [
    ./bspwm.nix
    ./feh.nix
    ./sxhkd.nix
  ];

  options.modules.desktop.wm = {
    enable = mkOption {
      type = types.bool;
      default = desktopCfg.enable;
    };
  };

  config = mkIf cfg.enable {
    modules.desktop.wm = {
      feh.enable = true;
      bspwm.enable = true;
    };
  };
}
