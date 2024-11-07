{ lib, pkgs }:
with lib;
with builtins;
(
  path:
  let
    shellEscape = s: (replaceStrings [ "\\" ] [ "\\\\" ] s);
    scriptName =
      replaceStrings
        [
          "\\"
          "@"
        ]
        [
          "-"
          "_"
        ]
        (shellEscape (baseNameOf path));
    out = pkgs.writeTextFile {
      name = "script-${scriptName}";
      executable = true;
      destination = "/bin/${scriptName}";
      text = readFile path;
    };
  in
  "${out}/bin/${scriptName}"
)
