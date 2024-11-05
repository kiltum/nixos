# nixos
My test repo for nixos education

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

```
sudo nixos-rebuild switch
```
