{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  serverCfg = config.modules.server;
  cfg = config.modules.server.adguardhome;
  port = 3000;
  mkVhost = import ./mkSimpleNginxVhost.nix;
  defaultSettings = import ./adguardconfig.nix;
in {
  options.modules.server.adguardhome = {
    enable = mkEnableOption "adguardhome";

    domain = mkOption {
      type = types.str;
      default = serverCfg.domain;
    };

    settings = mkOption {
        type = types.attrs;
        default = {};
    };

    subDomain = mkOption {
      type = types.str;
      default = "adguardhome";
    };
  };

  config = mkIf cfg.enable (
    recursiveUpdate {
      services.adguardhome = {
        enable = true;

        port = port;

        openFirewall = false;

        # were doubling down here
        mutableSettings = false;

        settings = defaultSettings cfg.settings;
      };

      # DNS
      networking.firewall.allowedTCPPorts = [53];
      networking.firewall.allowedUDPPorts = [53];
    }
    (mkVhost {inherit lib cfg serverCfg; port = toString port;})
  );
}
