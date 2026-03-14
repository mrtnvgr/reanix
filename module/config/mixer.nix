{ boolToInt, ... }:
{ config, lib, ... }: let
  cfg = config.programs.reanix;
  mixer = cfg.config.mixer;
in {
  options.programs.reanix.config.mixer = {
    dock = lib.mkOption {
      type = with lib.types; nullOr bool;
      default = null;
    };
  };

  config = lib.mkIf cfg.enable {
    programs.reanix.extraConfig."reaper.ini" = /* dosini */ ''
      ${lib.optionalString (mixer.dock != null) ''
        [reaper]
        mixwnd_dock=${boolToInt mixer.dock}
      ''}
    '';
  };
}
