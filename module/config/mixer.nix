{ config, lib, ... }: let
  cfg = config.programs.reanix;
in {
  options.programs.reanix.config.mixer = {
    dock = lib.mkOption {
      type = with lib.types; nullOr bool;
      default = null;
    };
  };

  config = lib.mkIf cfg.enable {
    programs.reanix.extraConfig."reaper.ini" = /* dosini */ ''
      ${lib.optionalString (cfg.mixer.dock != null) ''
        [reaper]
        mixwnd_dock=${cfg.mixer.dock}
      ''}
    '';
  };
}
