{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  serverCfg = config.modules.server;
  cfg = config.modules.server.adguardhome;
  port = "3000";
  mkVhost = import ./mkSimpleNginxVhost.nix;
in {
  options.modules.server.adguardhome = {
    enable = mkEnableOption "adguardhome";

    domain = mkOption {
      type = types.str;
      default = serverCfg.domain;
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

        settings = {
          
        };

        host = "localhost";
      };

      # DNS
      networking.firewall.allowedTCPPorts = [53];
      networking.firewall.allowedUDPPorts = [53];
    }
    (mkVhost {inherit lib cfg serverCfg port;})
  );
}
