# i use sai2 too but i cant really bundle it as a package (commercial + needs device unique license file next to it)
# so this will just expect ~/.local/Tools/Art/sai2/sai2.exe to be present

{ home, pkgs, user, ... }:

let
    wine = pkgs.wineWowPackages.stable;

    sai2 = pkgs.makeDesktopItem {
        name = "sai2";
        desktopName = "Paint Tool Sai 2";
        exec = "${wine}/bin/wine ${user.home}/.local/Tools/Art/sai2/sai2.exe";
        categories = [ "Art" "Graphics" ];
        icon = "sai2";
    };
in {
    home.packages = with pkgs; [
        libresprite
        krita
        wine
        winetricks
        sai2
    ];

    # TODO: thats a hack but idk how to best bundle icons
    home.file.".local/share/icons/sai2.png".source = ./sai2.png;
}
