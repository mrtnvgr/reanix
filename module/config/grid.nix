{ mkNullyOption, boolToInt, ... }:
{ inputs, config, pkgs, lib, ... }: let
  mrtnvgr-lib = inputs.mrtnvgr.lib { inherit pkgs; };
  inherit (mrtnvgr-lib.strings) unalias;

  cfg = config.programs.reanix;
  inherit (cfg.config) grid;

  gridinbg2Aliases = {
    "Over items"    = "0";
    "Through items" = "1";
    "Under items"   = "2";
  };
in {
  options.programs.reanix.config.grid = {
    dotted = mkNullyOption {
      type = lib.types.bool;
      description = "Show grid lines dotted";
    };

    z-layer = mkNullyOption {
      type = lib.types.enum (lib.attrNames gridinbg2Aliases);
    };
  };

  config = lib.mkIf cfg.enable {
    programs.reanix.extraConfig."reaper.ini" = /* dosini */ ''
      ${lib.optionalString (grid.dotted != null) ''
        [reaper]
        griddot=${boolToInt grid.dotted}
      ''}

      ${lib.optionalString (grid.z-layer != null) ''
        [reaper]
        gridinbg2=${unalias gridinbg2Aliases grid.z-layer}
      ''}
    '';
  };
}
