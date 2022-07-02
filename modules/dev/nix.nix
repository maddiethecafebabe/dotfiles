{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfg = config.modules.dev;
in {
  config = mkIf cfg.enable {
    user.packages = [pkgs.alejandra];
  };
}
