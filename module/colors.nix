{ inputs, pkgs, lib, config, ... }:
let
  mrtnvgr-lib = inputs.mrtnvgr.lib { inherit pkgs; };
  cfg = config.programs.reanix;

  # TODO: add a throw if colors > 16
  colors = mrtnvgr-lib.lists.crampPad 16 "#000000" cfg.colors;

  bgrColors = map mrtnvgr-lib.colors.hex.flip colors;
  pureColors = map (x: lib.removePrefix "#" x) bgrColors;
  custColors = (lib.concatStrings (map (x: "${x}00") pureColors)) + "FF";

in {
  options.programs.reanix = {
    # TODO: may be broken on darwin
    colors = lib.mkOption {
      type = with lib.types; listOf singleLineStr;
      default = [];
    };
  };

  config = lib.mkIf (cfg.enable && cfg.colors != []) {
    programs.reanix.extraConfig."reaper.ini" = {
      reaper.custcolors = custColors;
    };
  };
}
