inputs @ { lib, config, pkgs, ... }:
with lib;
let
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
        
        ssh_keys = mkOption {
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

        home = mkOption {
            type = attrs;
            default = {};
        };
        
        homeRaw = mkOption {
            type = attrs;
            default = {};
        };
        
        home-manager.enable = mkOption {
            type = bool;
            default = config.modules.desktop.enable;
        };
    };

    # alias
    options.modules.core.user = mkOption { type = types.attrs; default = {}; };

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
                extraGroups = [ "wheel" ] ++ cfg.extraGroups;
                openssh.authorizedKeys.keys = cfg.ssh_keys;
                packages = cfg.packages;
            };
        };

        home-manager = mkIf cfg.home-manager.enable {
            useGlobalPkgs = mkDefault true;
            useUserPackages = mkDefault true;

            users."${cfg.name}" = recursiveUpdate {
                home = recursiveUpdate {
                    username = cfg.name;
                    homeDirectory = cfg.homeDir;
                    stateVersion = mkDefault "22.05";
                } cfg.home;

                programs.home-manager.enable = true;
                programs.bash.enable = mkDefault true;
            } cfg.homeRaw;
        };
    };
}
