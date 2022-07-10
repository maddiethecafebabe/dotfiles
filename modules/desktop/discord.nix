# this file is a huge hacky mess
# TODO:
{
  lib,
  pkgs,
  pkgs-unstable,
  config,
  ...
}:
with lib; let
  cfg = config.modules.desktop.discord;

  settings = {
    DANGEROUS_ENABLE_DEVTOOLS_ONLY_ENABLE_IF_YOU_KNOW_WHAT_YOURE_DOING = true;
    SKIP_HOST_UPDATE = true;
    BACKGROUND_COLOR = "#202225";
    
    openasar = {
      setup = true;
      quickstart = true;
    };
  };

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

  mkDiscordDesktop = desktopName: exec: pkg: {
    name = pkg.pname;
    icon = pkg.pname;
    inherit desktopName exec;
    genericName = pkg.meta.description;
    categories = ["Network" "InstantMessaging"];
    mimeTypes = ["x-scheme-handler/discord"];
  };

  tweakInputs = pkg:
    pkg.override {
      # if this is not in sync with firefox
      # it breaks opening urls
      nss = pkgs.nss_latest;

      withOpenASAR = true;
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
    user.packages = with pkgs-unstable;
      if cfg.applyTweaks
      then [
        (overrideDesktopEntry (tweakInputs discord) (mkDiscordDesktop "Discord" "Discord --no-sandbox"))
        (overrideDesktopEntry (tweakInputs discord-canary) (mkDiscordDesktop "Discord Canary" "DiscordCanary --no-sandbox"))
      ]
      else [
        discord
        discord-canary
      ];

    # enable devtools and allow me to use the apps when the host is outdated
    # the latter happens quite often with nix on the canary package
    user.home.file = optionalAttrs cfg.applyTweaks {
      ".config/discord/settings.json".text = builtins.toJSON settings;
      ".config/discordcanary/settings.json".text = builtins.toJSON settings;
    };
  };
}
