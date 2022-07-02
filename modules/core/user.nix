inputs @ {
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.user;
in {
  options.user = with types; {
    name = mkOption {
      type = str;
      default = "maddie";
    };

    full_name = mkOption {
      type = str;
      default = "Madeline";
    };

    homeDir = mkOption {
      type = str;
      default = "/home/mads";
    };

    group = mkOption {
      type = str;
      default = "users";
    };

    uid = mkOption {
      type = int;
      default = 1001;
    };

    initial_password = mkOption {
      type = str;
      default = "smashthestate";
    };

    authorizedKeys = mkOption {
      type = listOf str;
      default = [];
    };

    extraGroups = mkOption {
      type = listOf str;
      default = [];
    };

    packages = mkOption {
      type = listOf package;
      default = [];
    };

    home = {
      packages = mkOption {
        type = listOf package;
        default = [];
      };
      file = mkOption {
        type = attrs;
        default = {};
      };

      # TODO: home.configFile -> home.file."$XDG_CONFIG_DIR/${path}"

      # TODO: move those out of hm
      sessionPath = mkOption {
        type = listOf str;
        default = {};
      };
      sessionVariables = mkOption {
        type = attrs;
        default = {};
      };
      shellAliases = mkOption {
        type = attrs;
        default = {};
      };
    };

    # TODO: get rid of this
    homeRaw = mkOption {
      type = attrs;
      default = {};
    };

    shortcuts = mkOption {
      type = listOf attrs;
      default = [];
    };

    home-manager.enable = mkOption {
      type = bool;
      default = config.modules.desktop.enable;
    };
  };

  # alias
  options.modules.core.user = mkOption {
    type = types.attrs;
    default = {};
  };

  config = {
    # alias
    user = config.modules.core.user;

    users = {
      mutableUsers = true;
      users."${cfg.name}" = {
        uid = cfg.uid;
        group = cfg.group;
        description = cfg.full_name;
        home = cfg.homeDir;
        isNormalUser = true;
        initialPassword = cfg.initial_password;
        extraGroups = ["wheel"] ++ cfg.extraGroups;
        openssh.authorizedKeys.keys = cfg.authorizedKeys;
        packages = cfg.packages;
      };
    };

    home-manager = mkIf cfg.home-manager.enable {
      useGlobalPkgs = mkDefault true;
      useUserPackages = mkDefault true;

      users."${cfg.name}" =
        recursiveUpdate {
          home = with cfg.home; {
            inherit file packages sessionPath shellAliases sessionVariables;

            stateVersion = mkDefault "21.11";
            homeDirectory = cfg.homeDir;
          };

          # dconf = ((import ../../lib/mkGnomeShortcut.nix) { inherit lib; } cfg.shortcuts).dconf;

          programs.home-manager.enable = true;
          programs.bash.enable = mkDefault true;
        }
        cfg.homeRaw;
    };
  };
}
