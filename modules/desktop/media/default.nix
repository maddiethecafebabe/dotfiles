{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.desktop.media;
in {
  imports = [
    ./audio
    ./video.nix
  ];

  options.modules.desktop.media = {
    enable = mkEnableOption "media stuff";
  };

  config = mkIf cfg.enable {
    modules.desktop.media = {
      video.enable = true;
      audio.enable = true;
    };
  };
}
