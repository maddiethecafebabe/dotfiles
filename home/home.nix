{ home, config, user, pkgs, ... }:

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

        packages = with pkgs; [ mkdirenv direnv unstable.itch obs-studio wineWowPackages.stable ];

        sessionVariables = { "EDITOR" = "vim"; };

        shellAliases = {
            "with" = "nix-shell -p";
        };
    };

    programs.home-manager.enable = true;
    programs.bash.enable = true;
}
