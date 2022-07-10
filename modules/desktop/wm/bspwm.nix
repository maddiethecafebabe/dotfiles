{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.desktop.wm.bspwm;
in {
  options.modules.desktop.wm.bspwm = {
    enable = mkEnableOption "bspwm";
  };

  config = mkIf cfg.enable {
    user = {
      keybindings = import ./bspwm-hotkeys.nix;

      packages = with pkgs; [
        kitty

        libnotify
        (polybar.override {
          pulseSupport = true;
          nlSupport = true;
        })

        maim
        xclip
      ];
    };

    user.homeRaw.services.redshift = {
      enable = mkDefault true;
      dawnTime = "05:00";
      duskTime = "17:00";
      temperature = {
        day = 5500;
        night = 4700;
      };
    };

    services = {
      picom.enable = true;
      xserver = {
        enable = true;
        displayManager = {
          defaultSession = "none+bspwm";
          lightdm = {
            enable = true;
            greeters.mini = {
              enable = true;
              user = config.user.name;
            };
          };
        };
        windowManager.bspwm = {
          enable = true;
        };
      };
    };

    # HACK
    user.home.file = {
      ".config/bspwm/bspwmrc".source = ../../../config/bspwm/bspwmrc;
      ".config/bspwm/rc.d/90-polybar".text = ''
                        #!/usr/bin/env bash

        pkill -u $UID -x polybar
        while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

        polybar main >$XDG_DATA_HOME/polybar.log 2>&1 &
        echo 'Polybar launched...'
      '';
      ".config/polybar" = {
        source = ../../../config/polybar;
        recursive = true;
      };
    };
    systemd.user.services."dunst" = {
      enable = true;
      description = "";
      wantedBy = [];
      serviceConfig = {
        Restart = "always";
        RestartSec = 2;
        ExecStart = "${pkgs.dunst}/bin/dunst";
      };
    };
  };
}
