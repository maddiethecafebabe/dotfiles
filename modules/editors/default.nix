{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.editors;
  mkEditor = import ../../lib/mkSimpleEditor.nix;
in {
  imports = [
    ./emacs.nix

    (mkEditor "vscode" {command = "code";})
    (mkEditor "vim" {
      defaultEnable = true;
      defaultDefault = true;
    })
    (mkEditor "lapce" {defaultPackage = pkgs.lapce-upstream;})
  ];

  options.modules.editors = {
    enable-all = mkEnableOption "all editors";
  };

  config = {
    modules.editors = {
      vim.enable = mkDefault true;
      emacs.enable = mkDefault cfg.enable-all;
      vscode.enable = mkDefault cfg.enable-all;
      lapce.enable = mkDefault cfg.enable-all;
    };
  };
}
