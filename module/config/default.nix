{ lib, ... }:
let
  mkEnabledOption = x: lib.mkEnableOption x // { default = true; };

  # TODO: mkBitfield -> binToInt?
  mkBitfield = list:
    builtins.foldl' (acc: x:
      acc * 2 + (if x then 1 else 0)
    ) 0 (lib.reverseList list);

  boolToInt = x: if x then "1" else "0";

  mkNullyOption = x: lib.mkOption {
    type = lib.types.nullOr x.type;
    default = null;
  };

  mkModule = x: import x {
    inherit mkEnabledOption mkBitfield;
    inherit boolToInt mkNullyOption;
  };

in {
  imports = map (x: mkModule x) [
    ./viewadvance.nix
    ./labelitems2.nix
    ./itemicons.nix
    ./showpeaks.nix
    ./envlanes.nix
    ./defvzoom.nix
    ./paths.nix
    ./mixer.nix
    ./media_explorer.nix
    ./boot.nix
    ./playback.nix
    ./grid.nix
    ./fades.nix
    ./theme.nix
    ./transport.nix
    ./zoom.nix
    ./tcpalign.nix
    ./loopnewitems.nix
    ./recaddatloop.nix
  ];
}
