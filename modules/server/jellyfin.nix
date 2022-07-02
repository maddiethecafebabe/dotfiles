{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  serverCfg = config.modules.server;
  cfg = config.modules.server.jellyfin;
  port = "8096";
  mkVhost = import ./mkSimpleNginxVhost.nix;
in {
  options.modules.server.jellyfin = {
    enable = mkEnableOption "jellyfin";

    domain = mkOption {
      type = types.str;
      default = config.modules.server.domain;
    };

    subDomain = mkOption {
      type = types.str;
      default = "media";
    };
  };

  config = mkIf cfg.enable (
    recursiveUpdate {
      services.jellyfin = {
        enable = true;

        # give it access to my mounts
        group = "users";
      };
    }
    (mkVhost {inherit lib cfg serverCfg port;})
  );
}
