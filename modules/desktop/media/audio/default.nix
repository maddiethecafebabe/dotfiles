{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.desktop.media.audio;
in {
  imports = [
    ./deadbeef.nix
  ];

  options.modules.desktop.media.audio = {
    enable = mkEnableOption "audio module";
  };

  config = mkIf cfg.enable {
    modules.desktop.media.audio = {
      deadbeef.enable = true;
    };

    user.packages = [pkgs.lmms];
  };
}
