{ config, pkgs, ... }:
{
  # Set your time zone.
  #time.timeZone = "America/New_York";
  time.timeZone = "America/Chicago";

  networking.hostName = "NixosServer"; # Define your hostname.

  environment.systemPackages = with pkgs; [
    murmur
    zfs
    gitlab
  ];

  networking.firewall.allowedTCPPorts = [22 80 443 32400 23401];

 services.gitlab = {
    enable = true;
    secrets.secret = "dzIqpjZhzXkFQafnXj4QYxiB7r9T6OIs6D8aXWrIagGKTTQFE7Ui";
    secrets.otp = "6Bgo8EUBzvPgGNohArPaLZN5pEvouMI0SOCpg4FtToqnhcBc7aS2GxhLKjukXMEb";
    secrets.db = "9KG4fl8DHpC7fgU79o1aelLbZiHHhckx7qINQ82rFAhKJgyf3tUbYTpssst1RNPu";
    databasePassword = "armbar";
    https = false;
  #  host = "192.168.1.150";
    port = 80;
    #extraConfig = { gitlab = { default_projects_features = { builds = false; }; }; };
};

#services.gitlab-runner.enable = true;



  programs.mosh.enable = true;

  services.plex.enable = true;

#  services.httpd.enable = true;
#  services.httpd.adminAddr = "zimhen7@gmail.com";

  services.nfs.server.enable = true;


  networking.hostId = "8425e349";
  boot.supportedFilesystems = ["zfs"];
  boot.postBootCommands = "zfs mount -a";

  boot.zfs.extraPools = ["primaryZpool"];


  nixpkgs.config.packageOverrides = pkgs: {plex = pkgs.callPackage /etc/nixos/customPkgs/plex.nix{}; };

}
