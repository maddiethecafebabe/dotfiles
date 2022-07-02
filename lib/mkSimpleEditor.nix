name:
{ defaultPackage ? null, command ? name, defaultEnable ? false }:
{ pkgs, lib, config, ... }:
with lib;
let
    cfg = config.modules.editors."${name}";
    defaultPackage' = if defaultPackage == null 
                        then pkgs."${name}"
                        else defaultPackage;
in {
    options.modules.editors."${name}" = {
        enable = mkOption {
            type = types.bool;
            default = defaultEnable;  
            description = name;
        };

        package = mkOption {
            type = types.package;
            default = defaultPackage';
        };

        default = mkEnableOption "${name} as the default editor";
    };

    config = mkIf cfg.enable {
        environment.systemPackages = [ cfg.package ];
    
        environment.variables = mkIf cfg.default {
             "EDITOR" = "${command}";
         };
    };
}
