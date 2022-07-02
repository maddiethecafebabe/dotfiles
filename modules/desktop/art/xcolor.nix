{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.desktop.art.xcolor;
  gnomeCfg = config.modules.desktop.gnome;
in {
  options.modules.desktop.art.xcolor = {
    enable = mkEnableOption "xcolor";

    shortcut = {
      binding = mkOption {
        type = types.str;
        default = "<Super>x";
      };
      command = mkOption {
        type = types.str;
        default = "xcolor -P 333 -S 16 --selection clipboard";
      };
    };
  };

  config = mkIf cfg.enable {
    # programs.dconf.enable = gnomeCfg.enable;

    user = {
      packages = [pkgs.xcolor];

      # shortcuts = [ { binding = cfg.gnome.binding; command = cfg.gnome.command; name = "xcolor"; } ];
    };
  };
}
