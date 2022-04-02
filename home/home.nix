{ config, user, pkgs, ... }:

{
  home.username = user.name;
  home.homeDirectory = user.home;

  home.packages = with pkgs; [
    discord discord-canary
  ];

  home.stateVersion = "22.05";

  programs.home-manager.enable = true;
}
