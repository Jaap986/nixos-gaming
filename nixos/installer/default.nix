{ pkgs, lib, inputs, ... }:

{
  imports = [
    "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  networking.networkmanager.enable = true;

  environment.systemPackages = with pkgs; [
    git
    parted
    (writeShellScriptBin "install-nixos" (builtins.readFile ./install.sh))
  ];

  environment.etc."nixos-config".source = inputs.self;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
