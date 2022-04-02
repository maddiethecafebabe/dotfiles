{ config, user, pkgs, ... }:

{
    imports = [
      ./discord.nix
    ];

    home.username = user.name;
    home.homeDirectory = user.home;

    home.stateVersion = "22.05";

    programs.home-manager.enable = true;
}
