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
      virtualisation.enable = true;
    };
    editors = {
      vim.enable = true;
      vscode.enable = true;
      lapce.enable = true;
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
    };
  };

  user.homeRaw.gtk.gtk3.bookmarks = [
    "file:///mnt/Executeable Executeable"
    "file:///etc/dotfiles dotfiles"
    "file:///mnt/Windows Windows"
    "file:///mnt/Shared Shared"
    "file:///mnt/Besenkammer Besenkammer"
  ];

  boot.initrd.kernelModules = ["amdgpu"];
}
