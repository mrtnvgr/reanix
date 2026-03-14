{ lib, ... }:
let
  mkEnabledOption = x: lib.mkEnableOption x // { default = true; };

  # TODO: mkBitfield -> binToInt?
  mkBitfield = list:
    builtins.foldl' (acc: x:
      acc * 2 + (if x then 1 else 0)
    ) 0 (lib.reverseList list);

  boolToInt = x: if x then "1" else "0";

  mk = x: import x {
    inherit mkEnabledOption mkBitfield boolToInt;
  };

in {
  imports = map (x: mk x) [
    ./viewadvance.nix
    ./labelitems2.nix
    ./itemicons.nix
    ./showpeaks.nix
    ./envlanes.nix
    ./defvzoom.nix
    ./paths.nix
    ./mixer.nix
    ./media_explorer.nix
  ];
}
