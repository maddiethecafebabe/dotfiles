{
  config,
  pkgs,
  pubkeys,
  grab-bag,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./fs.nix
  ];

  networking.hostName = "kimono"; # Define your hostname.

  modules = {
    core.user.authorizedKeys = pubkeys.yukata;
    desktop = {
      enable = true;
      gnome.enable = false;
      wm.enable = true;
      virtualisation.enable = true;
    };
    editors = {
      vim.enable = true;
      vscode.enable = true;
    };

    # this server block is used for testing before i push things to my pi
    server = {
      domain = "kimono.local";

      ssl = {
        enable = true;
        self = {
          key = "/secrets/kimono/priv.key";
          cert = "/secrets/kimono/cert.crt";
        };

      };
      adguardhome = {
        enable = true;
        settings = {
            users = [
                # go ahead, crack it. i believe in your habilities
                { name = "maddie"; password = "$2y$10$ggaJIptyrV6HLWN5hpHm.eb0ajLLSj6CuAaxJDClBhzzel9W82d7K"; }
            ];
        };
      };
    };
  };

  boot.initrd.kernelModules = ["amdgpu"];
}
