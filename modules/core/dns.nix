{ lib, ...}:
with lib;
{
    networking.extraHosts = ''
      192.168.0.100   media.seifuku.local radarr.seifuku.local sonarr.seifuku.local documents.seifuku.local
      127.0.0.1   sonarr.kimono.local
      ::1         sonarr.kimono.local
    '';

    networking.nameservers = [ "192.168.0.100" "9.9.9.10" ];

    services.resolved = {
        enable = mkDefault true;
        fallbackDns = [   
            # quad9
            "9.9.9.10"
            "149.112.112.10"
            "2620:fe::10"
            "2620:fe::fe:10"
        ];
    };
}
