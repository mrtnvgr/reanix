{ lib, ... }:
let
  mkEnabledOption = x: lib.mkEnableOption x // { default = true; };

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
  ];
}
