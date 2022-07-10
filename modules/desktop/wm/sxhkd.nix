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
      (pkgs.writeText "sxhkd-bindings-config")
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
    default = {};
  };

  config = mkIf config.modules.desktop.wm.bspwm.enable {
    # dont use the configFile option because you cant apply new shortcuts without restarting
    # display-manager.service afaict
    user.home.file.".config/sxhkd/sxhkdrc".source = buildHotkeysFile (baseHotkeys // config.user.keybindings);
  };
}
