{ pkgs, lib, config, ... }:
with lib;
let
    cfg = config.modules.editors.vim;
in {
    options.modules.editors.vim = {
        enable = mkOption { 
            default = true;
            type = types.bool;
        };
        default = mkOption {
            default = true;
            type = types.bool;
        };
    };

    config = mkIf cfg.enable {
        environment.systemPackages = [ pkgs.vim ];
    
        environment.variables = mkIf cfg.default {
             "EDITOR" = "vim";
         };
    };
}
