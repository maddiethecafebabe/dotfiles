{ lib
, buildDotnetModule
, fetchFromGitHub
, fetchurl
, dotnetCorePackages
, gtk3
, libX11
, libXrandr
, libappindicator
, libevdev
, libnotify
, udev
, copyDesktopItems
, makeDesktopItem
, nixosTests
, wrapGAppsHook
, dpkg
}:

buildDotnetModule rec {
  pname = "Duplicate";
  version = "0.6.0.3";

  src = fetchFromGitHub {
    owner = "suchmememanyskill";
    repo = "Duplicate";
    rev = "b26f94167670a5127a1aca5203f03fc12571340d";
    sha256 = "sha256-/Tow25ycQEK8HN1IaB12ZXCXEsuKItD+aYLF/IX8Eos=";
  };

  dotnet-sdk = dotnetCorePackages.sdk_6_0;
  dotnet-runtime = dotnetCorePackages.runtime_6_0;

  dotnetInstallFlags = [ "--framework=net6.0" ];

  projectFile = [ "Duplicate.csproj" ];
  nugetDeps = ./deps.nix;

  executables = [ "Duplicate" ];

  nativeBuildInputs = [
    copyDesktopItems
    wrapGAppsHook
    dpkg
  ];

  runtimeDeps = [
    gtk3
    libX11
    libXrandr
    libappindicator
    libevdev
    libnotify
    udev
  ];

  meta = with lib; {
    description = "";
    homepage = "https://github.com/suchmememanyskill/Duplicate";
    license = licenses.lgpl3Plus;
    maintainers = with maintainers; [ ];
    platforms = platforms.linux;
    mainProgram = "Duplicate";
  };
}
