{
  lib,
  pkgs,
  config,
  ...
}:
with lib; {
  services.xserver.gdk-pixbuf.modulePackages = [pkgs.librsvg];
  programs.dconf.enable = true;
  services.dbus.packages = with pkgs; [dconf];
  fonts.fonts = [pkgs.comic-mono];
  environment.systemPackages = with pkgs; [
    dconf

    # an alternative would be to use gsettings to properly tell nemo to use a different
    # application but thats a pita..
    (linkFarm "fix-nemo-terminal-opening" [
      {
        name = "bin/gnome-terminal";
        path = "${kitty}/bin/kitty";
      }
    ])
  ];

  user.homeRaw = {
    gtk = {
      enable = true;
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };
      theme = {
        name = "amarena";
        package = pkgs.amarena-theme;
      };
    };

    qt = {
      enable = true;
      platformTheme = "gtk";
      style = {
        name = "gtk2";
        package = pkgs.qtstyleplugins;
      };
    };
  };
}
