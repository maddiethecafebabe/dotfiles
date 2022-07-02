{
  lib,
  cfg,
  serverCfg,
  port,
  forceSSL ? true,
  locationsExtraConfig ? "",
}:
with lib; {
  services.nginx = {
    enable = true;

    virtualHosts = {
      "${cfg.subDomain}.${cfg.domain}" =
        {
          addSSL = serverCfg.ssl.enable && !forceSSL;
          forceSSL = serverCfg.ssl.enable && forceSSL;

          enableACME = serverCfg.ssl.acme.enable;
          locations."/" = {
            proxyPass = "http://localhost:${port}";
            extraConfig = locationsExtraConfig;
          };
        }
        // optionalAttrs (serverCfg.ssl.enable && !serverCfg.ssl.acme.enable) {
          sslCertificate = serverCfg.ssl.self.cert;
          sslCertificateKey = serverCfg.ssl.self.key;
        };
    };
  };

  security.acme.certs = mkIf serverCfg.ssl.acme.enable {
    "${cfg.subDomain}.${cfg.domain}".email = serverCfg.ssl.acme.email;
  };
}
