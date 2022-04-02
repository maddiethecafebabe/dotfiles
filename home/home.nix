{ config, user, pkgs, ... }:

{
    home.username = user.name;
    home.homeDirectory = user.home;

    imports = [
        ./dev
        ./discord.nix
        ./bitwarden.nix
        ./wallpaper.nix
    ];

    home.packages = with pkgs; [ vim ];
    home.sessionVariables = {
        "EDITOR" = "vim";
    };

    home.stateVersion = "22.05";

    programs.home-manager.enable = true;
    programs.bash = {
        enable = true;
        bashrcExtra = "source $HOME/.profile";
    };
}
