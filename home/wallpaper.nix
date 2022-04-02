{ home, user, pkgs, ... }:
{
    dconf.settings = {
        "org/gnome/desktop/background" = {
            "picture-uri" = "${user.home}/.config/wallpaper";
            "picture-uri-dark" = "${user.home}/.config/wallpaper";
        };
        "org/gnome/desktop/screensaver" = {
            "picture-uri" = "${user.home}/.config/wallpaper";
        };
    };

    home.file.".config/wallpaper".source = ./wallpaper.png;
}
