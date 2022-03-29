{ ... }: 
{
  imports = [
    ./users.nix
    ./hardware
    ./desktop
    ./nix.nix
  ];
}
