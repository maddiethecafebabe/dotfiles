{
  lib,
  pkgs,
  ...
}: let
  inherit (pkgs) fetchurl symlinkJoin;
  inherit (lib) listToAttrs nameValuePair recursiveUpdate attrValues;

  wallpapers = [
    {
      name = "i_use_windows_okay";
      value = fetchurl {
        url = "https://media.discordapp.net/attachments/836638993403084850/981776209341993021/wallpaper.png";
        sha256 = "sha256-3HwaEw/UcGY1SqdZXA5fn3I8CriWftmwJ+VFzQ5/PmI=";
      };
    }

    {
      name = "artist_girl_stretch";
      value = fetchurl {
        url = "https://cdn.discordapp.com/attachments/699396916877721630/984618923976712212/unknown.png";
        sha256 = "sha256-t+IZmkSeZGUBNr9yLJ5+Px26cMDDMcxAcMbL1IQBiag=";
      };
    }
  ];

  all = listToAttrs wallpapers;
in
  recursiveUpdate all {
    default = all.artist_girl_stretch;
    allDir = symlinkJoin {
      name = "all-wallpapers-dir";
      paths = attrValues all;
    };
  }
