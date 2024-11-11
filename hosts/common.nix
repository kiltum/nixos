# Common settings for all my hosts
{ config, pkgs, ... }:
{
  networking.networkmanager.enable = true;
  time.timeZone = "Europe/Moscow";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    curl
    mc
    nixfmt-rfc-style
    treefmt
    traceroute
    mtr
    alsa-utils # for fix sound troubles
    alsa-tools
    procps
    restic
  ];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.config.allowUnfree = true;
  services.openssh.enable = true;
  security.sudo.wheelNeedsPassword = false;
  security.pam.sshAgentAuth.enable = true;
  # look like in should be anable by other packages
  #services.pipewire.enable = true;
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 10d";
  };
}
