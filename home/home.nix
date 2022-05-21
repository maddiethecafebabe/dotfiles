{ config, user, pkgs, ... }:

{
    imports = [
        ./dev
        ./media
        ./art
        ./rofi.nix
        ./discord.nix
        ./bitwarden.nix
        ./wallpaper.nix
    ];

    home = {
        username = user.name;
        homeDirectory = user.home;
        stateVersion = "22.05";

        packages = with pkgs; [ vim tmux mkdirenv direnv unstable.itch obs-studio ];

        sessionVariables = { "EDITOR" = "vim"; };

        shellAliases = {
            "with" = "nix-shell -p";
        };
    };

    programs.home-manager.enable = true;
    programs.bash = {
        enable = false;

        bashrcExtra = ". $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh";
    };
}
