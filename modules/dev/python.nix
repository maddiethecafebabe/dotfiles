{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  python3 = pkgs.python3.withPackages (p:
    with p; [
      pandas
      numpy
      requests
      yt-dlp
    ]);
  cfg = config.modules.dev;
in {
  config = mkIf cfg.enable {
    user.home = {
      packages = [python3];

      shellAliases = {
        "python" = "python3";
      };

      sessionPath = [
        "${config.user.homeDir}/.local/bin"
      ];

      sessionVariables = {
        "PYTHONPATH" = "${python3}/${python3.sitePackages}";
      };
    };
  };
}
