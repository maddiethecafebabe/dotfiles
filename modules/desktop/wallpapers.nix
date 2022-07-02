{
  lib,
  pkgs,
  ...
}: let
  inherit (pkgs) fetchurl;
in rec {
  i_use_windows_okay = fetchurl {
    url = "https://media.discordapp.net/attachments/836638993403084850/981776209341993021/wallpaper.png";
    sha256 = "sha256-3HwaEw/UcGY1SqdZXA5fn3I8CriWftmwJ+VFzQ5/PmI=";
  };

  artist_girl_stretch = fetchurl {
    url = "https://cdn.discordapp.com/attachments/699396916877721630/984618923976712212/unknown.png";
    sha256 = "sha256-t+IZmkSeZGUBNr9yLJ5+Px26cMDDMcxAcMbL1IQBiag=";
  };

  default = artist_girl_stretch;
}
