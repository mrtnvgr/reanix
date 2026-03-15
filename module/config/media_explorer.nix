{ boolToInt, mkNullyOption, ... }:
{ config, lib, ... }: let
  cfg = config.programs.reanix;
  mex = cfg.config.media_explorer;
in {
  options.programs.reanix.config.media_explorer = {
    dock       = mkNullyOption { type = lib.types.bool; };
    media.loop = mkNullyOption { type = lib.types.bool; };
  };

  config = lib.mkIf cfg.enable {
    programs.reanix.extraConfig."reaper.ini" = /* dosini */ ''
      ${lib.optionalString (mex.dock != null) ''
        [reaper_sexplorer]
        docked=${boolToInt mex.dock}
      ''}

      ${lib.optionalString (mex.media.loop != null) ''
        [reaper_sexplorer]
        repeat=${boolToInt mex.media.loop}
      ''}
    '';
  };
}
