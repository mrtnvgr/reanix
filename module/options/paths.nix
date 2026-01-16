{ config, lib, ... }: let
  cfg = config.programs.reanix;
  paths = cfg.options.paths;
in {
  options.programs.reanix.options = {
    paths = let
      pathOption = lib.mkOption {
        type = with lib.types; nullOr singleLineStr;
        default = null;
      };
    in {
      projects = pathOption;
      media = pathOption;
      peaks = pathOption;
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.user.tmpfiles.rules = let
      mkDir = x: "d ${x}";
    in map mkDir (lib.filter (x: x != null) [
      paths.projects
      paths.media
      paths.peaks
    ]);

    programs.reanix.extraConfig."reaper.ini" = /* dosini */ ''
      ${lib.optionalString (paths.projects != null) ''
        ; Default project save directory
        [reaper]
        defsavepath=${paths.projects}
      ''}

      ${lib.optionalString (paths.media != null) ''
        ; Default media directory for unsaved projects
        [reaper]
        defrecpath=${paths.media}
      ''}

      ${lib.optionalString (paths.peaks != null) ''
        [reaper]
        altpeaks=5
        altpeakspath=${paths.peaks}
      ''}
    '';
  };
}
