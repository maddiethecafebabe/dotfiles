# stub for now
{ config, pkgs, lib, modules, ... }:

let
hostname = "kimono";
in {
    networking.hostName = hostname;
}
