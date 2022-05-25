{ pkgs, lib, config, ... }:
with lib;
let 
    cfg = config.modules.server.deluge;
in {
    options = {};

    config = {

        services.deluge = {
            enable = true;
            declarative = true;
            authFile = "/secrets/deluge-authfile.txt";
            web = {
                enable = true;
            };
        };
    };
}
