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

  home.file.".bashrc.d/" = {
    source = ../../bashrc;
    recursive = true;
  };

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

    dnsutils # `dig` + `nslookup`
    nmap # A utility for network discovery and security auditing
    ipcalc # it is a calculator for the IPv4/v6 addresses

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
    telegram-desktop
    vscode
    vscode-extensions.redhat.ansible
    vscode-extensions.ms-python.python
    python3
    ansible
    ansible-lint
    pinentry-all
  ];

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "Viacheslav Kaloshin";
    userEmail = "kiltum@kiltum.tech";
    lfs.enable = true;
    # gpg --list-secret-keys --keyid-format=long | grep sec
    signing.key = "0xD9C4611813E9F51E";
    signing.signByDefault = true;
    extraConfig = {
      branch.autoSetupRebase = "always";
      checkout.defaultRemote = "origin";

      pull.rebase = true;
      pull.ff = "only";
      push.default = "current";

      init.defaultBranch = "master";
      submodule.recurse = "true";
    };
  };

  programs.gpg = {
    enable = true;
    settings = {
      keyid-format = "0xlong";
      personal-digest-preferences = builtins.concatStringsSep " " [
        "SHA512"
        "SHA384"
        "SHA256"
      ];
      personal-cipher-preferences = builtins.concatStringsSep " " [
        "AES256"
        "AES192"
        "AES"
      ];
      default-preference-list = builtins.concatStringsSep " " [
        "SHA512"
        "SHA384"
        "SHA256"
        "AES256"
        "AES192"
        "AES"
        "ZLIB"
        "BZIP2"
        "ZIP"
        "Uncompressed"
      ];
      use-agent = true;
      verify-options = "show-uid-validity";
      list-options = "show-uid-validity";
      cert-digest-algo = "SHA512";
      throw-keyids = false;
      no-emit-version = true;
    };
    scdaemonSettings.disable-ccid = true;
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    defaultCacheTtl = 86400;
    maxCacheTtl = 2592000;
    pinentryPackage = pkgs.pinentry-curses;
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    # TODO add your custom bashrc here
    #    bashrcExtra = ''
    #      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
    #    '';
    bashrcExtra = ''
            HISTTIMEFORMAT='%d/%m/%y %T '
            # User specific aliases and functions
      if [ -d ~/.bashrc.d ]; then
              for rc in ~/.bashrc.d/*; do
                      if [ -f "$rc" ]; then
                              . "$rc"
                      fi
              done
      fi

      unset rc

    '';
    #initExtra=""
    historyFileSize = -1;
    historySize = -1;
    # set some aliases, feel free to add more or remove some
    shellAliases = {
      d = "cd ~/Desktop";
      dl = "cd ~/Downloads";
      p = "cd ~/projects";
      g = "git";
      gcam = "git commit -am ";
      gp = "git push";
      gs = "git status";
      gwip = "git commit -am \"-- WIP ---\"";
      nrs = "sudo nixos-rebuild switch";
      nfu = "nix flake update";
      ls = "ls --color=auto -h --group-directories-first";
    };

  };
  home.sessionVariables = {
    EDITOR = "mcedit";
    RESTIC_REPOSITORY_FILE = "/etc/nixos/hosts/kiltum/restic_repository_file";
    RESTIC_PASSWORD_FILE = "/etc/nixos/hosts/kiltum/restic_password_file";
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

  programs.firefox = {
    enable = true;

    profiles = {
      default = {
        id = 0;
        name = "default";
        isDefault = true;
        settings = {
          # "browser.startup.homepage" = "https://duckduckgo.com";
          "browser.search.defaultenginename" = "DuckDuckGo";
          "browser.search.order.1" = "DuckDuckGo";

          "signon.rememberSignons" = false;
          "widget.use-xdg-desktop-portal.file-picker" = 1;
          "browser.aboutConfig.showWarning" = false;
          "browser.compactmode.show" = true;
          "browser.cache.disk.enable" = false; # Be kind to hard drive

          "privacy.donottrackheader.enabled" = true;
          "privacy.trackingprotection.enabled" = true;
          "privacy.trackingprotection.socialtracking.enabled" = true;
          "privacy.partition.network_state.ocsp_cache" = true;

          # Disable all sorts of telemetry
          "browser.newtabpage.activity-stream.feeds.telemetry" = false;
          "browser.newtabpage.activity-stream.telemetry" = false;
          "browser.ping-centre.telemetry" = false;
          "toolkit.telemetry.archive.enabled" = false;
          "toolkit.telemetry.bhrPing.enabled" = false;
          "toolkit.telemetry.enabled" = false;
          "toolkit.telemetry.firstShutdownPing.enabled" = false;
          "toolkit.telemetry.hybridContent.enabled" = false;
          "toolkit.telemetry.newProfilePing.enabled" = false;
          "toolkit.telemetry.reportingpolicy.firstRun" = false;
          "toolkit.telemetry.shutdownPingSender.enabled" = false;
          "toolkit.telemetry.unified" = false;
          "toolkit.telemetry.updatePing.enabled" = false;

          # As well as Firefox 'experiments'
          "experiments.activeExperiment" = false;
          "experiments.enabled" = false;
          "experiments.supported" = false;
          "network.allow-experiments" = false;

          # Disable Pocket Integration
          "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
          "extensions.pocket.enabled" = false;
          "extensions.pocket.api" = "";
          "extensions.pocket.oAuthConsumerKey" = "";
          "extensions.pocket.showHome" = false;
          "extensions.pocket.site" = "";

          "apz.gtk.kinetic_scroll.enabled" = false; # stop kinetic scrolling

          # Firefox 75+ remembers the last workspace it was opened on as part of its session management.
          # This is annoying, because I can have a blank workspace, click Firefox from the launcher, and
          # then have Firefox open on some other workspace.
          "widget.disable-workspace-management" = true;
        };
        search = {
          force = true;
          default = "DuckDuckGo";
          order = [
            "DuckDuckGo"
            "Google"
          ];
        };
      };
    };

    profiles.default.bookmarks = [

      {
        name = "My bookmarks";
        toolbar = true;
        bookmarks = [
          {
            name = "Home";
            url = "http://influxdb.iot.hlevnoe.lan:8086/orgs/adc33b18fbba5f40/dashboards/0d51d8f8ddf70000?lower=now%28%29+-+7d";
          }
          {
            name = "Phoronix";
            url = "https://www.phoronix.com/";
          }
          {
            name = "3dnews";
            url = "https://3dnews.ru/";
          }
          {
            name = "ixbt";
            url = "https://www.ixbt.com/";
          }
          {
            name = "mysku";
            url = "https://mysku.club/";
          }
          {
            name = "facebook";
            url = "https://www.facebook.com/";
          }

          {
            name = "wiki";
            tags = [
              "wiki"
              "nix"
            ];
            url = "https://wiki.nixos.org/";
          }
        ];
      }
    ];

    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DontCheckDefaultBrowser = true;
      DisablePocket = true;
      SearchBar = "unified";
      ExtensionSettings =
        with builtins;
        let
          extension = shortId: uuid: {
            name = uuid;
            value = {
              install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
              installation_mode = "normal_installed";
            };
          };
        in
        listToAttrs [
          (extension "ublock-origin" "uBlock0@raymondhill.net")
          (extension "keepassxc-browser" "keepassxc-browser@keepassxc.org")
          (extension "plasma-integration" "plasma-browser-integration@kde.org")
          (extension "clearurls" "{74145f27-f039-47ce-a470-a662b129930a}")
          (extension "facebook-container" "@contain-facebook")
        ];
      # To add additional extensions, find it on addons.mozilla.org, find
      # the short ID in the url (like https://addons.mozilla.org/en-US/firefox/addon/!SHORT_ID!/)
      # Then, download the XPI by filling it in to the install_url template, unzip it,
      # run `jq .browser_specific_settings.gecko.id manifest.json` or
      # `jq .applications.gecko.id manifest.json` to get the UUID
    };

  };

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}
