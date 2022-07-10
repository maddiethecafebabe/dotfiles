{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.desktop.rofi;
  gnomeCfg = config.modules.desktop.gnome;
in {
  options.modules.desktop.rofi = {
    enable = mkEnableOption "rofi";

    gnome = {
      binding = mkOption {
        type = types.str;
        default = "<Super>space";
      };
      command = mkOption {
        type = types.str;
        default = "rofi -show combi";
      };
    };
  };

  config = mkIf cfg.enable {
    user = {
      packages = [pkgs.papirus-icon-theme];

      homeRaw = {
        programs.rofi = {
          enable = true;

          extraConfig = {
            modi = "window,drun,ssh,combi,run";
            combi-modi = "window,drun,ssh,run";
            show-icons = true;
            icon-theme = "Papirus";
          };

          theme = "solarized";
        };
      };
    };
  };
}
