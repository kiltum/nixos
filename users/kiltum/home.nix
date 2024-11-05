{ config, pkgs, ... }:

{
  home.username = "kiltum";
  home.homeDirectory = "/home/kiltum";

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [

    neofetch

    # archives
    zip
    xz
    unzip
    p7zip

    dnsutils  # `dig` + `nslookup`
    nmap # A utility for network discovery and security auditing
    ipcalc  # it is a calculator for the IPv4/v6 addresses

    file
    which
    gnused
    gnutar
    gawk
    zstd

    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files
    lm_sensors # for `sensors` command
    pciutils # lspci
    usbutils # lsusb
    keepassxc
  ];

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "Viacheslav Kaloshin";
    userEmail = "kiltum@kiltum.tech";
    lfs.enable = true;
  #  signing.key = "FILL";
  # signing.signByDefault = true;
  };
  services.gpg-agent.enable = true;

  programs.bash = {
    enable = true;
    enableCompletion = true;
    # TODO add your custom bashrc here
#    bashrcExtra = ''
#      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
#    '';

    # set some aliases, feel free to add more or remove some
    shellAliases = {
        d="cd ~/Desktop";
        dl="cd ~/Downloads";
        p="cd ~/projects";
        g="git";
        gcam="git commit -am ";
        gp="git push";
        gs="git status";
        gwip="git commit -am \"-- WIP ---\"";
    };
  };
  programs.ssh = {
    enable = true;
    forwardAgent = true;
    addKeysToAgent = "yes";
    compression = true;
    controlMaster = "yes";
    controlPersist = "5m";
    matchBlocks = {
        "192.168.*" = {
            user = "kiltum";
        };
        };
    };
services.ssh-agent.enable = true;

services.nextcloud-client = {
    enable = true;
    startInBackground = true;
    };

    programs.gpg = {
    enable = true;
    };

    programs.firefox = {
    enable = true;
    
};

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}
