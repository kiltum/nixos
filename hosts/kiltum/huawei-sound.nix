{ lib, pkgs }:
with lib;

let
  makeScript = import ../../helpers/make-script.nix { inherit lib pkgs; };
in
{
  systemd.services.huawei = {
    serviceConfig = {
      ExecStart = makeScript ../../scripts/sound.sh;
    };
  };
}
