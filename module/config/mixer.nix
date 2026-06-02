{ boolToInt, mkNullyOption, ... }:
{ config, lib, ... }: let
  cfg = config.programs.reanix;
  mixer = cfg.config.mixer;
in {
  options.programs.reanix.config.mixer = {
    dock = mkNullyOption { type = lib.types.bool; };
  };

  config = lib.mkIf cfg.enable {
    programs.reanix.extraConfig."reaper-ini" = {
      reaper = lib.optionalAttrs (mixer.dock != null) { mixwnd_dock = boolToInt mixer.dock; };
    };
  };
}
