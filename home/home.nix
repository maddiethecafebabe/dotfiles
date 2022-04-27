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

        packages = with pkgs; [ vim tmux ];

        sessionVariables = { "EDITOR" = "vim"; };
    };

    programs.home-manager.enable = true;
    programs.bash = {
        enable = true;

        # home-manager doesnt source this automatically
        # which means we have to do it ourselves or everything
        # shell related defined in home-manager wont get applied...
        bashrcExtra = "source $HOME/.profile";
    };
}
