# this file is a huge hacky mess
# TODO: just vendor the discord packages at this point
#       because of nix limitations it will be a lot easier
#       to just add options for the settings i need
# TODO: in the vendored package maybe make a wrapper script
#       that merges the settings and not just dumps a readonly symlink
{
  lib,
  pkgs,
  pkgs-unstable,
  config,
  ...
}:
with lib; let
  cfg = config.modules.desktop.discord;
  settingsText = ''    {
            "DANGEROUS_ENABLE_DEVTOOLS_ONLY_ENABLE_IF_YOU_KNOW_WHAT_YOURE_DOING": true,
            "SKIP_HOST_UPDATE": true
        }'';

  overrideDesktopEntry = pkg: f: let
    inherit (pkgs) symlinkJoin makeDesktopItem;
  in
    symlinkJoin {
      name = "${pkg.name}-overriden-desktop-entry";
      paths = [
        (makeDesktopItem (f pkg))
        pkg
      ];
    };

  mkDiscordDesktop = pkg: desktopName: exec: {
    name = pkg.pname;
    icon = pkg.pname;
    inherit desktopName exec;
    genericName = pkg.meta.description;
    categories = ["Network" "InstantMessaging"];
    mimeTypes = ["x-scheme-handler/discord"];
  };

  tweakInputs = pkg: pkg.override {
    # if this is not in sync with firefox
    # it breaks opening urls
    nss = pkgs.nss_latest;

    # withOpenASAR = true;
  };
in {
  options.modules.desktop.discord = {
    enable = mkEnableOption "discord";

    applyTweaks = mkOption {
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    user.packages = with pkgs;
      if cfg.applyTweaks
      then [
        (overrideDesktopEntry (tweakInputs discord) (super: mkDiscordDesktop super "Discord" "Discord --no-sandbox"))
        (overrideDesktopEntry (tweakInputs discord-canary) (super: mkDiscordDesktop super "Discord Canary" "DiscordCanary --no-sandbox"))
      ]
      else [
        discord
        discord-canary
      ];

    # enable devtools and allow me to use the apps when the host is outdated
    # the latter happens quite often with nix on the canary package
    user.home.file = optionalAttrs cfg.applyTweaks {
      ".config/discord/settings.json".text = settingsText;
      ".config/discordcanary/settings.json".text = settingsText;
    };
  };
}
