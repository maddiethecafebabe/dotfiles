{ options, lib, ... }:

{
  services.samba = {
    enable = true;
    openFirewall = true;
    
    shares = {
      "Besenkammer" = {
        path = "/mnt/Besenkammer";
        browsable = "no";
        "read only" = "no";
        "hide unreadable" = "yes";
        "valid users" = "maddie livia tinma";
      };
    };
  };
}
