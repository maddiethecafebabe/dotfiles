{ lib, pkgs, config, ... }:
with lib;
let
    cfg = config.modules.server;
in {
    imports = [
        ./jellyfin.nix
        ./sonarr.nix
    ];

    options.modules.server = {};

    config = {};
}
