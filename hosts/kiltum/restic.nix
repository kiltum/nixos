{ pkgs, userName, ... }:
{

  services.restic.backups.global = {
    initialize = true;
    user = "kiltum"; # root is probably not needed
    #environmentFile = "/etc/nixos/hosts/kiltum/restic-environment-file";
    repositoryFile = "/etc/nixos/hosts/kiltum/restic_repository_file";
    passwordFile = "/etc/nixos/hosts/kiltum/restic_password_file";
    #pruneOpts = [
    #  "--keep-daily 7"
    #  "--keep-weekly 4"
    #  "--keep-monthly 2"
    #  "--keep-yearly 0"
    #];
    paths = [ "/home/kiltum" ];
    exclude = [
      "$HOME/**/node_modules"
      "$HOME/**/Cache"
      "$HOME/**/DawnCache/*"
      "$HOME/**/GPUCache/*"
      "$HOME/**/TransportSecurity"
      "$HOME/**/main.log"
      "$HOME/**/.cache"
      "$HOME/**/__pycache__"
      "$HOME/.local/share/gvfs-metadata"
      "$HOME/Downloads"
      "$HOME/snap"
      "$HOME/.Trash"
      "$HOME/.bundle"
      "$HOME/.cache"
      "$HOME/.dbus"
      "$HOME/.local/pipx"
      "$HOME/.local/share/Trash"
      "$HOME/.local/lib"
      "$HOME/.npm"
      "$HOME/.pyenv"
      "$HOME/.thumbnails"
      "$HOME/.virtualenvs"
      "$HOME/.vscode/extensions"
      "$HOME/joplin"
      "$HOME/.config/joplin-desktop/log.txt"
      "$HOME/Nextcloud/.sync*"
      "$HOME/.config/Nextcloud/logs"
      "$HOME/.local/share/Nextcloud/Nextcloud_sync.log"
      "$HOME/Mattermost"
      "$HOME/.config/Mattermost"
      "$HOME/.ansible/tmp"
      "$HOME/.local/share/TelegramDesktop/tdata/user_data/"
      "$HOME/.local/share/Trash/"
      "$HOME/**/*.iso"
      "$HOME/.var"

    ];
    backupPrepareCommand = "/run/current-system/sw/bin/sleep 30 && ${pkgs.restic}/bin/restic unlock"; # necessary to prevent locks from persisting indefinitely. See more:
    # https://forum.restic.net/t/restic-unlock-automation/5511
    extraBackupArgs = [
      "--exclude-caches"
      "--compression max"
      "--one-file-system"
      "--cleanup-cache"
    ];
    timerConfig = {
      OnCalendar = "daily"; # Empty string to disable the timer
      Persistent = true;
      # NB: the option Persistent=true triggers the service
      # immediately if it missed the last start time
    };
  };

}
