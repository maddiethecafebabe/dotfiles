{ home, pkgs, user, ... }:

{
    home.packages = with pkgs; [
        rustup
    ];

    home.sessionPath = [
        "${user.home}/.cargo/bin"
    ];
}
