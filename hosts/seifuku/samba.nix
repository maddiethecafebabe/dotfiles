{ options, lib, ... }:

{
  services.samba = {
    enable = true;
    openFirewall = true;
    
    shares = lib.warn "samba: make sure to create the user accounts" {
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
