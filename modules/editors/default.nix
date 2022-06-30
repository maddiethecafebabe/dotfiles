{ config, lib, pkgs, ... }:
with lib;
let
    cfg = config.modules.editors;
in {
    imports = [
        ./emacs.nix
        ./vim.nix
        ./vscode.nix
    ];

    options.modules.editors = {
        enable-all = mkEnableOption "all editors";
    };

    config = {
        modules.editors = {
            vim.enable = mkDefault cfg.enable-all;
            emacs.enable = mkDefault cfg.enable-all;
            vscode.enable = mkDefault cfg.enable-all;
        };
    };
}
