{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfg = config.modules.server;
in {
  imports = [
    ./jellyfin.nix
    ./sonarr.nix
    ./radarr.nix
    ./deluge.nix
    ./paperless.nix
    ./radicale.nix
  ];

  options.modules.server = with types; {
    enable = mkEnableOption "server stuff";

    domain = mkOption {
      type = types.str;
    };

    ssl = {
      enable = mkEnableOption "ssl for server vhosts";

      acme = {
        enable = mkEnableOption "acme for automatic lets encrypt certs";
        email = mkOption {type = str;};
      };

      self = {
        cert = mkOption {type = path;};
        key = mkOption {type = path;};
      };
    };
  };

  config = mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = [80] ++ optionals cfg.ssl.enable [443];

    services.nginx = {
      enable = cfg.enable;
      recommendedGzipSettings = mkDefault true;
      recommendedOptimisation = mkDefault true;
      recommendedProxySettings = mkDefault true;
      recommendedTlsSettings = mkDefault true;

      # just a landing page, nothing served there so far
      virtualHosts."${cfg.domain}" =
        {
          default = true;
          addSSL = cfg.ssl.enable;
          enableACME = cfg.ssl.enable && cfg.ssl.acme.enable;
        }
        // optionalAttrs (cfg.ssl.enable && !cfg.ssl.acme.enable) {
          sslCertificate = cfg.ssl.self.cert;
          sslCertificateKey = cfg.ssl.self.key;
        };
    };

    security.acme = mkIf cfg.ssl.acme.enable {
      acceptTerms = true;
      certs."${cfg.domain}".email = cfg.ssl.acme.email;
    };
  };
}
