
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    unzip
    unrar
    curl
    wget
    psmisc
    psutils
    pulsemixer
    alsa-utils
    efibootmgr
  ];
}
