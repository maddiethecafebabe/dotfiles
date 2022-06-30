
{ pkgs, lib, config, ... }:
with lib;
let 
    cfg = config.modules.desktop.virtualisation;
in {
    options.modules.desktop.virtualisation = {
        enable = mkEnableOption "virtualisation stuff";
    };

    config = mkIf cfg.enable  {
        virtualisation.libvirtd = {
            enable = true;
            qemu = {
                swtpm.enable = true;
                ovmf = {
                    enable = true;
                    package = pkgs.OVMFFull;
                };
            };
        };

        programs.dconf.enable = true;

        systemd.services."libvirtd".path = [ pkgs.kmod ];
        
        boot.extraModprobeConfig = "options kvm_amd kvm-amd nested=1";
        boot.kernelParams = [
            "nohibernate"
            "amd_iommu=on"
            "iommu=pt"
        ];

        user.extraGroups = [ "libvirtd" ];

        environment.sessionVariables.VAGRANT_DEFAULT_PROVIDER = [ "libvirt" ];
        environment.sessionVariables.LIBVIRT_DEFAULT_URI = [ "qemu:///system" ];

        environment.systemPackages = with pkgs; [
            libguestfs
            virt-manager
            (pkgs.stdenv.mkDerivation {
            name = "virtiofsd-link";
            buildCommand = ''
                mkdir -p $out/bin
                ln -s ${pkgs.qemu}/libexec/virtiofsd $out/bin/
            '';
            })
            virtiofsd
            win-virtio
            vagrant
        ];
    };
}
