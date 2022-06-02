inputs @ { lib, config, pkgs, ... }:
with lib;
let
    cfg = config.user;
    
    # TODO: swap this out with per host access control
    ssh_keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCtcvLuQkjb0ysly3pbisPn9EBopXhHWIxV3kY1wTeQBokOAejiGnwZu5hGdID+2OOgPSQa5gjq2M02ZAdFx6fq58N9bjW1IkKpPGXjzBs1YkugBVkKtz/gJlv78t6gHweCmaC26zTM/WH5Muo6OrbiBaUbeQWkLs0MLQkMIvsDIF/9k/qYaJb+w6XuHwoOtF8DQVto6bADJlqcNHzEbvIlrYJ7ZbhQimbnK6JD8wVUYDEmM+XWYHA448wjf4zikkgYmhQi4XFNvDdmpQNqNtEH0BOta8FEOxogcjKlS9MQOTAvVo6gaz/MziirMQvWMp8piinoeDrYXUjRNb6cJY0wHo7CA8yeP43D/q90hIsNTOvKi45x6o7G3/4gxmLADxYjLG0DNT6PDmBVGRJ87Etc0sJtsYXfJVW9XWS9UdWldOL7ZLSuUVNAKoFJJ9fh9LVkxwJOHPQsHSQJxmtE8otYOq/LCLNtJT/3lUtAfmaBpQseeLTMPKY2tp0hQ7PJT+/mUEzjSYntjkTyhZJoU2paxwBXu9hDn95NriIjBIUkuj4CeGvpG5gDkbrQPjQON8uq5nlSAJgvhKsPk6fKGpRZEnJj+KYCTvVDIeXpoSSslgVGgdgTeXb1t8vL+Sng/+SgvAP2BBfPXtjCkEyi1L19iez+s6KTp6mRhNYZBV7bkQ== maddie@kimono"
    ];
in {
    options.user = {
        name = mkOption { type = types.str; default = "maddie"; };
        full_name = mkOption { type = types.str; default = "Madeline"; };
        home_path = mkOption { type = types.str; default = "/home/mads"; };
        group = mkOption { type = types.str; default = "users"; };
        uid = mkOption { type = types.int; default = 1001; };
        initial_password = mkOption { type = types.str; default = "smashthestate"; };
        ssh_keys = mkOption { type = types.listOf types.str; default = []; };
        extraGroups = mkOption { type = types.listOf types.str; default = []; };
        packages = mkOption { type = types.listOf types.str; default = []; };

        home = mkOption { type = types.attrs; default = {}; };
        homeRaw = mkOption { type = types.attrs; default = {}; };
        home-manager.enable = mkOption { type = types.bool; default = config.modules.desktop.enable; };
    };

    config = {
        users = {
            mutableUsers = true;
            users."${cfg.name}" = {
                uid = cfg.uid;
                group = cfg.group;
                description = cfg.full_name;
                home = cfg.home_path;
                isNormalUser = true;
                initialPassword = cfg.initial_password;
                extraGroups = [ "wheel" ] ++ cfg.extraGroups;
                openssh.authorizedKeys.keys = cfg.ssh_keys ++ ssh_keys;
                packages = cfg.packages;
            };
        };

        home-manager = mkIf cfg.home-manager.enable {
            users."${cfg.name}" = {
                home = {
                    username = cfg.name;
                    homeDirectory = cfg.home_path;
                    stateVersion = mkDefault "22.05";

                } // cfg.home;
            } // cfg.homeRaw;
        };
    };
}
