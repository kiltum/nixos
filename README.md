# nixos
My NixOS repo

## To install

Boot from NixOS minimal installer. Copy-n-paste this

```
FLAKE="github:kiltum/nixos#kiltum"
DISK_DEVICE=/dev/nvme0n1
sudo nix \
    --extra-experimental-features 'flakes nix-command' \
    run github:nix-community/disko#disko-install -- \
    --flake "$FLAKE" \
    --write-efi-boot-entries \
    --disk main "$DISK_DEVICE"
```

You will get installed machine with my credentials :)

## After first boot.

Clone this repo and run next commands inside repo

```
sudo rm /etc/nixos
sudo sudo ln -s `pwd` /etc/nixos
sudo nixos-rebuild switch
```

##

Try to save AL sensetive info  in keepassxc

```
keepassxc-cli attachment-export ~/Nextcloud/keepassxc.kdbx SSH\ ключи/GPG gnupg.tar.gz 11
```