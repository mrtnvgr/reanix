{ lib, ... }:
let
  mkEnabledOption = x: lib.mkEnableOption x // { default = true; };

  # TODO: mkBitfield -> binToInt?
  mkBitfield = list:
    builtins.foldl' (acc: x:
      acc * 2 + (if x then 1 else 0)
    ) 0 (lib.reverseList list);

  mk = x: import x {
    inherit mkEnabledOption mkBitfield;
  };

in {
  imports = map (x: mk x) [
    ./viewadvance.nix
    ./labelitems2.nix
    ./itemicons.nix
    ./showpeaks.nix
  ] ++ [
    ./defvzoom.nix
    ./paths.nix
  ];
}
