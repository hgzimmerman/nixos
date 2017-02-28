{ config, pkgs, ... }:
{

  environment.systemPackages = with pkgs; [
    plex
    murmur
  ];

  services.plex.enable = true;

}
