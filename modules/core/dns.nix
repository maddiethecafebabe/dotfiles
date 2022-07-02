{ lib, ...}:
with lib;
{
    networking.extraHosts = ''
      192.168.0.100   media.seifuku.local radarr.seifuku.local sonarr.seifuku.local documents.seifuku.local
      127.0.0.1   sonarr.kimono.local
      ::1         sonarr.kimono.local
    '';

    networking.nameservers = [
        # my raspi
        "192.168.0.100"

        # quad9 as fallback
        "9.9.9.10"
        "149.112.112.10"
        "2620:fe::10"
        "2620:fe::fe:10"
    ];

    services.resolved = {
        enable = mkDefault true;

        # fallback is used when no other nameservers are provided *not if the provided ones are unreachable*
        # resolved uses a compiled in list of google and cloudflare and while the above case never 
        # is supposed to hit because i have nameservers defined right above
        # (which wont stop people complaining about it) id rather have it fail
        # completely than to silently use something else
        fallbackDns = [ "0.0.0.0" ];
    };
}
