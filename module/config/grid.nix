{ mkNullyOption, boolToInt, ... }:
{ config, lib, ... }: let
  cfg = config.programs.reanix;
  inherit (cfg.config) grid;
in {
  options.programs.reanix.config.grid = {
    dotted = mkNullyOption {
      type = lib.types.bool;
      description = "show dotted grid lines";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.reanix.extraConfig."reaper.ini" = /* dosini */ ''
      ${lib.optionalString (grid.dotted != null) ''
        [reaper]
        griddot=${boolToInt grid.dotted}
      ''}
    '';
  };
}
