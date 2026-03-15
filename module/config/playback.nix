{ mkNullyOption, boolToInt, ... }:
{ config, lib, ... }: let
  cfg = config.programs.reanix;
  inherit (cfg.config) playback;
in {
  options.programs.reanix.config.playback = {
    loop = mkNullyOption {
      type = lib.types.bool;
      description = "repeat playback at end of project";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.reanix.extraConfig."reaper.ini" = /* dosini */ ''
      ${lib.optionalString (playback.loop != null) ''
        ; Repeat playback at end of project
        [reaper]
        stopprojlen=${boolToInt playback.loop}
      ''}
    '';
  };
}
