{ home, pkgs, ... }:

{
    home.packages = with pkgs; [ dotnet-sdk dotnet-runtime ];
}