inputs @ { lib, config, pkgs, ... }:
with lib;
let
    cfg = config.user;
    
    # TODO: swap this out with per host access control
    ssh_keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCtcvLuQkjb0ysly3pbisPn9EBopXhHWIxV3kY1wTeQBokOAejiGnwZu5hGdID+2OOgPSQa5gjq2M02ZAdFx6fq58N9bjW1IkKpPGXjzBs1YkugBVkKtz/gJlv78t6gHweCmaC26zTM/WH5Muo6OrbiBaUbeQWkLs0MLQkMIvsDIF/9k/qYaJb+w6XuHwoOtF8DQVto6bADJlqcNHzEbvIlrYJ7ZbhQimbnK6JD8wVUYDEmM+XWYHA448wjf4zikkgYmhQi4XFNvDdmpQNqNtEH0BOta8FEOxogcjKlS9MQOTAvVo6gaz/MziirMQvWMp8piinoeDrYXUjRNb6cJY0wHo7CA8yeP43D/q90hIsNTOvKi45x6o7G3/4gxmLADxYjLG0DNT6PDmBVGRJ87Etc0sJtsYXfJVW9XWS9UdWldOL7ZLSuUVNAKoFJJ9fh9LVkxwJOHPQsHSQJxmtE8otYOq/LCLNtJT/3lUtAfmaBpQseeLTMPKY2tp0hQ7PJT+/mUEzjSYntjkTyhZJoU2paxwBXu9hDn95NriIjBIUkuj4CeGvpG5gDkbrQPjQON8uq5nlSAJgvhKsPk6fKGpRZEnJj+KYCTvVDIeXpoSSslgVGgdgTeXb1t8vL+Sng/+SgvAP2BBfPXtjCkEyi1L19iez+s6KTp6mRhNYZBV7bkQ== maddie@kimono"
    ];
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
                openssh.authorizedKeys.keys = cfg.ssh_keys ++ ssh_keys;
                packages = cfg.packages;
            };
        };

        home-manager = mkIf cfg.home-manager.enable {
            useGlobalPkgs = mkDefault true;
            useUserPackages = mkDefault true;

            users."${cfg.name}" = {
                home = {
                    username = cfg.name;
                    homeDirectory = cfg.homeDir;
                    stateVersion = mkDefault "22.05";

                } // cfg.home;

                programs.home-manager.enable = true;
                programs.bash.enable = mkDefault true;
            } // cfg.homeRaw;
        };
    };
}
