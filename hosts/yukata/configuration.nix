{
  config,
  pkgs,
  pubkeys,
  ...
}: let
  hostName = "yukata";
in {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./fs.nix
  ];

  modules = {
    core.user = {
      authorizedKeys = pubkeys.kimono;
      extraGroups = ["networkmanager"];
    };
    desktop.enable = true;
    editors.vscode.enable = true;
  };

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  # networking.useDHCP = false;
  # networking.interfaces.enp1s0.useDHCP = true;
  # networking.interfaces.wlp2s0.useDHCP = true;

  networking = {
    inherit hostName;

    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
      unmanaged = [
        # "*"
        # "except:type:wwan"
        # "except:type:gsm"
      ];
    };

    wireless = {
      # enable = true;
      userControlled.enable = true;
      iwd.enable = true;
    };
  };

  services.xserver.libinput = {
    enable = true;

    touchpad = {
      naturalScrolling = false;
      middleEmulation = true;
      tapping = true;
    };
  };
}
