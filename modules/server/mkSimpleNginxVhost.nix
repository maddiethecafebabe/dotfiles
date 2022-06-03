{ lib, cfg, serverCfg, port }:
with lib;
{
    services.nginx = {
        enable = true;

        virtualHosts = {
            "${cfg.subDomain}.${cfg.domain}" = {
                addSSL = serverCfg.ssl.enable;
                enableACME = serverCfg.ssl.acme.enable;
                locations."/" = {
                    proxyPass = "http://localhost:${port}";
                };
            }  // optionalAttrs (serverCfg.ssl.enable && !serverCfg.ssl.acme.enable) {
                sslCertificate = serverCfg.ssl.self.cert;
                sslCertificateKey = serverCfg.ssl.self.key;
            };
        };
    };

    security.acme.certs = mkIf serverCfg.ssl.acme.enable {
        "${cfg.subDomain}.${cfg.domain}".email = serverCfg.ssl.acme.email;
    };
}
