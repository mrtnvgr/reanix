{ config, lib, ... }: let
  cfg = config.programs.reanix;
in {
  options.programs.reanix.config.media_explorer = {
    dock = lib.mkOption {
      type = with lib.types; nullOr bool;
      default = null;
    };
  };

  config = lib.mkIf cfg.enable {
    programs.reanix.extraConfig."reaper.ini" = /* dosini */ ''
      ${lib.optionalString (cfg.media_explorer.dock != null) ''
        [reaper_sexplorer]
        docked=${cfg.media_explorer.dock}
      ''}
    '';
  };
}
