{ pkgs, lib, config, ... }:
with lib;
let
    cfg = config.modules.editors.vscode;
in {
    options.modules.editors.vscode = {
        enable = mkOption { 
            default = false;
            type = types.bool;
        };
        default = mkOption {
            default = false;
            type = types.bool;
        };
    };

    config = mkIf cfg.enable {
        environment.systemPackages = [ pkgs.vscode ];
    
        environment.variables = mkIf cfg.default {
             "EDITOR" = "code";
         };
    };
}
