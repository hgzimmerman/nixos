{ config, pkgs, ... }:

{


  boot.blacklistedKernelModules = [ "nvidia" ];

  boot.kernelModules = [
    "vfio"
    "vfio_pci"
    "vfio_iommu_type1"
    "kvm-intel"
  ];

  boot.kernelParams = [
    "intel_iommu=on" # AMD CPUs shouldn't need a line like this one
    "vfio_iommu_type1.allow_unsafe_interrupts=1"
    "kvm.allow_unsafe_assigned_interrupts=1"
    "kvm.ignore_msrs=1" # This prevents certain (BSOD) crashes in Windows guests.
    "i915.enable_hd_vgaarb=1"
  ];
  virtualisation.libvirtd.enable = true;


  environment.systemPackages = with pkgs; [
      # Vitalization and Passthrough
      qemu
      pciutils #lspci
      win-virtio
      libvirt


  ];



}


