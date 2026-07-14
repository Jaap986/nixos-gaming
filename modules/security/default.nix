{ config, pkgs, lib, ... }:

{
  boot.kernel.sysctl."kernel.core_pattern" = "/dev/null";
}
