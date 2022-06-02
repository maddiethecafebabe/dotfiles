{ lib, pkgs, config, ... }:
with lib;
let
    cfg = config.modules.desktop.discord;
    settingsText = ''{
        "DANGEROUS_ENABLE_DEVTOOLS_ONLY_ENABLE_IF_YOU_KNOW_WHAT_YOURE_DOING": true,
        "SKIP_HOST_UPDATE": true
    }'';
in {
    options.modules.desktop.discord = {
        enable = mkOption {
            type = types.bool;
            default = false;
        };

        applyTweaks = mkOption {
            type = types.bool;
            default = true;
        };
    };

    config = mkIf cfg.enable {
        user.packages = with pkgs; [
            discord discord-canary
        ];

        # enable devtools and allow me to use the apps when the host is outdated
        # the latter happens quite often with nix on the canary package
        user.home.file = optionalAttrs cfg.applyTweaks {
            ".config/discord/settings.json".text = settingsText;
            ".config/discordcanary/settings.json".text = settingsText;
        };
    };
}
