{
  lib,
  config,
  pkgs,
  user,
  grab-bag,
  ...
}:
with lib; let
  cfg = config.modules.desktop.art;
in {
  imports = [
    ./xcolor.nix
  ];

  options.modules.desktop.art = {
    enable = mkEnableOption "art module";
  };

  config = mkIf cfg.enable {
    modules.desktop.art = {
      xcolor.enable = true;
    };

    user.packages = with pkgs; [
      libresprite
      krita
      grab-bag.MagicaVoxel
      (grab-bag.sai2.override {executable = "${config.user.homeDir}/.local/Tools/Art/sai2/sai2.exe";})
    ];
  };
}
