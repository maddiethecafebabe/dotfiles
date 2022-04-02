{ home, pkgs, ... }:

let
    settingsText = ''{
        "DANGEROUS_ENABLE_DEVTOOLS_ONLY_ENABLE_IF_YOU_KNOW_WHAT_YOURE_DOING": true,
        "SKIP_HOST_UPDATE": true
    }'';
in {
    home.packages = with pkgs; [
        discord discord-canary
    ];

    # enable devtools and allow me to use the apps when the host is outdated
    # the latter happens quite often with nix on the canary package
    home.file = {
        ".config/discord/settings.json".text = settingsText;
        ".config/discord-canary/settings.json".text = settingsText;
    };
}
