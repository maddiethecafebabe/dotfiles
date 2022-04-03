{ home, pkgs, user, ... }:

{
    home.packages = with pkgs; [
        libresprite
        krita
        wineWowPackages.stable
        winetricks
    ];

    # i use sai2 too but i cant really bundle it as a package (commercial + needs device unique license file next to it)
    # so this will just expect ~/.local/Tools/Art/sai2/sai2.exe to be present
    home.file = {
        ".local/share/applications/sai2.desktop".text = ''
[Desktop Entry]
Name=sai2
Exec=/usr/bin/env wine ${user.home}/.local/Tools/Art/sai2/sai2.exe
Type=Application
StartupNotify=true
Icon=sai2
StartupWMClass=sai2.exe
        '';
        ".local/share/icons/sai2.png".source = ./sai2.png;
    };


}
