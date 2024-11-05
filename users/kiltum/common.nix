{ config, pkgs, ... }:

{
  users.users.kiltum.initialHashedPassword = "$6$e8/m1MmQORdTvNsS$IpPlxYoW9C3UU9uPUE1fO9SlX0f6c86au.NvaxBa34K8HAtoMaOZ3NXa.Jpa9LKCZL5rrz3hlBreTjxU4mfRc0";
  users.users.kiltum.isNormalUser = true;
  users.users.kiltum.extraGroups = [ "wheel" "networkmanager" ];
  users.users.kiltum.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIwTbklxgidWB5w+tpw6aRE2ZZuJdpdyOqGWX44Duu8G kiltum@kiltum.tech"
  ];
}
