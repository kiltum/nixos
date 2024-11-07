{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

with lib;

let
  makeScript = import ../../helpers/make-script.nix { inherit lib pkgs; };
in
{
  systemd.services.huawei = {
    enable = true;
    description = "Huawei soundcard headphones monitor";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = makeScript ../../scripts/sound.sh;
      Restart = "always";
    };
  };
}
