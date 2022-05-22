{ lib, pkgs, config, ... }:
with lib;
let
    cfg = config.modules.server;
in {
    imports = [
        ./jellyfin.nix
    ];

    options.modules.server = {};

    config = {};
}
