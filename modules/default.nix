{ pkgs, ... }: 
{
  imports = [
    ./hardware
    ./desktop
    ./core
    ./editors
  ];

  # make sure unfree packages are allowed on the stable side
  # cause im currently not using any i think
  environment.systemPackages = with pkgs; [ hello-unfree ];
}
