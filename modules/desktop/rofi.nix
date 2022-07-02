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
    programs.dconf.enable = mkDefault gnomeCfg.enable;

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

        dconf.settings = optionalAttrs gnomeCfg.enable {
          "org/gnome/settings-daemon/plugins/media-keys" = {
            custom-keybindings = [
              "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
            ];
          };
          "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
            binding = cfg.gnome.binding;
            command = cfg.gnome.command;
            name = "Rofi";
          };
        };
      };
    };
  };
}
