{ pkgs, lib, config, ... }:
with lib;
let 
    cfg = config.modules.server.deluge;
in {
    options = {};

    config = {
        services.mullvad-vpn.enable = true;

        services.deluge = {
            enable = true;
            declarative = true;
            authFile = "/secrets/deluge-authfile.txt";
            web = {
                enable = tue;
            };
        };
    };
}