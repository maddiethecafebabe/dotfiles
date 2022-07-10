{
  lib,
  config,
  modules,
  pkgs,
  grab-bag,
  ...
}:
with lib; let
  cfg = config.modules.desktop;
in {
  imports = [
    ./art
    ./media
    ./gaming
    ./pipewire.nix
    ./flatpak.nix
    ./virtualisation.nix
    ./discord.nix
    ./rofi.nix
    ./wm
    ./gtk.nix
  ];

  options = {
    modules.desktop.enable = mkOption {
      type = types.bool;
      default = true;
      description = ''
        enables various things youll probably want from a desktop
      '';
    };
  };

  config = mkIf cfg.enable {
    modules.desktop = {
      wm.enable = mkDefault true;
      flatpak.enable = mkDefault true;
      pipewire.enable = mkDefault true;
      gaming.enable = mkDefault true;
      rofi.enable = mkDefault true;
      discord.enable = mkDefault true;
      art.enable = mkDefault true;
      media.enable = mkDefault true;
    };

    services.mullvad-vpn.enable = true;

    # xdg-open will behave weird (read: open websites in gnome text editor)
    # if no browser is installed so lets just do it here
    user.packages = with pkgs; [
      firefox
      pavucontrol
      mullvad-vpn
      deluge
      wineWowPackages.stable
      obs-studio
      bitwarden
      gnome3.nautilus
      libreoffice
    ];

    environment.variables = {
      BROWSER = "firefox";
    };
  };
}
