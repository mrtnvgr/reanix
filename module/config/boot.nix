{ mkNullyOption, boolToInt, ... }:
{ config, lib, ... }: let
  cfg = config.programs.reanix;
  boot = cfg.config.boot;
in {
  options.programs.reanix.config.boot = {
    animation = mkNullyOption {
      type = lib.types.bool;
      description = "REAPER's boot animation";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.reanix.extraConfig."reaper.ini" = /* dosini */ ''
      ${lib.optionalString (boot.animation != null) ''
        ; Boot animation
        [reaper]
        splashfast=${boolToInt boot.animation}
      ''}
    '';
  };
}
