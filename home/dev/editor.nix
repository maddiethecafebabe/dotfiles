{  home, pkgs, ... }:

{
    home.packages = with pkgs; [
        vscode
    ];

    home.sessionPath = [
        "$XDG_CONFIG_HOME/emacs/bin"
    ];
}
