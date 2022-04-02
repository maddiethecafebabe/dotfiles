{ config, user, pkgs, ... }:

{
    imports = [
      ./discord.nix
    ];

    home.username = user.name;
    home.homeDirectory = user.home;

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
