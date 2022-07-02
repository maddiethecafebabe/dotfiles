{pkgs, ...}: {
  imports = [
    ./hardware
    ./desktop
    ./core
    ./editors
    ./server
    ./dev
  ];
}
