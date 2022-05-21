{ config, lib, pkgs, ... }:
with lib;
let
    cfg = config.modules.editors;
in {
    imports = [
        ./emacs.nix
        ./vim.nix
    ];

    options = {};

    config = {};
}
