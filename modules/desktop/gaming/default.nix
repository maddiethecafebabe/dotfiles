{
  lib,
  pkgs,
  pkgs-unstable,
  config,
  ...
}:
with lib; let
  cfg = config.modules.desktop.gaming;
in {
  options.modules.desktop.gaming = {
    enable = mkEnableOption "gaming module";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      lutris
      cabextract
      protontricks
      # :( pkgs-unstable.itch
    ];
  };
}
