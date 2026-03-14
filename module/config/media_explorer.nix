{ boolToInt, ... }:
{ config, lib, ... }: let
  cfg = config.programs.reanix;
  mex = cfg.config.media_explorer;
in {
  options.programs.reanix.config.media_explorer = {
    dock = lib.mkOption {
      type = with lib.types; nullOr bool;
      default = null;
    };
  };

  config = lib.mkIf cfg.enable {
    programs.reanix.extraConfig."reaper.ini" = /* dosini */ ''
      ${lib.optionalString (mex.dock != null) ''
        [reaper_sexplorer]
        docked=${boolToInt mex.dock}
      ''}
    '';
  };
}
