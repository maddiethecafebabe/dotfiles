{ pkgs, lib, config, ... }:
with lib;
let
    cfg = config.modules.core;
in {
    options.modules.core = {
        enable = mkOption {
            type = types.bool;
            default = true;
        };

        nix-ld.enable = mkOption {
            type = types.bool;
            default = true;
        };
    };
        
    imports = [
        ./nix.nix
        ./users.nix
        ./xdg.nix
        ./ssh.nix
        ./boot.nix
    ];

    config = mkIf cfg.enable {
        time.timeZone = "Europe/Berlin";

        environment.systemPackages = with pkgs; [
            git
            vim
            file
            wget
            tmux
            gnumake
        ];

        programs.nix-ld.enable = cfg.nix-ld.enable;

        programs.bash.shellInit = ''
            opt_source() {
                [[ -f "$1" ]] && source "$1"
            }

            opt_source "$HOME/.profile"
            opt_source "/etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh"
        '';

        networking.extraHosts =
        ''
            192.168.0.100 seifuku.local media.seifuku.local
        '';

        # This value determines the NixOS release from which the default
        # settings for stateful data, like file locations and database versions
        # on your system were taken. It‘s perfectly fine and recommended to leave
        # this value at the release version of the first install of this system.
        # Before changing this value read the documentation for this option
        # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
        system.stateVersion = "21.11"; # Did you read the comment?
    };
}
