{
  lib,
  pkgs,
  config,
  alejandra,
  ...
}:
with lib; let
  cfg = config.modules.dev.nix;
in {
  options.modules.dev.nix.enable = mkEnableOption "nix dev";

  config = mkIf cfg.enable {
    user.packages = [alejandra];
  };
}
