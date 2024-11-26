{
  desktop = import ./common.nix {
    disk = "/dev/disk/by-id/nvme-PC_SN530_NVMe_WDC_256GB_22102N441914";
    memory = "16G";
  };
}
