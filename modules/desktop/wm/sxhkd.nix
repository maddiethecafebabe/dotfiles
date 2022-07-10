{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  buildHotkeysFile = bindings:
    trivial.pipe bindings [
      (mapAttrsToList (k: v: "# ${v.comment}\n${k}\n\t${v.cmd}"))
      (concatStringsSep "\n\n")
      (builtins.toFile "sxhkd-bindings-config")
    ];

  baseHotkeys = {
    "super + Escape" = {
      cmd = "pkill -USR1 -x sxhkd";
      comment = "make sxhkd reload its configuration files";
    };
  };
in {
  options.user.keybindings = mkOption {
    type = types.attrs;
    default = baseHotkeys;
  };

  config = mkIf config.modules.desktop.wm.bspwm.enable {
    services.xserver.windowManager.bspwm.sxhkd.configFile = buildHotkeysFile config.user.keybindings;
  };
}
