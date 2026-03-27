{ mkNullyOption, ... }:
{ config, lib, ... }: let
  cfg = config.programs.reanix;
  paths = cfg.config.paths;
in {
  options.programs.reanix.config = {
    paths = let
      pathOption = mkNullyOption { type = lib.types.singleLineStr; };
    in {
      projects = pathOption;
      media = pathOption;
      peaks = pathOption;
      renders = pathOption;
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.user.tmpfiles.rules = let
      mkDir = x: "d ${x}";

      # If render path is relative, it's appended
      # to the current project path.
      keepOnlyAbs = x:
        if (isNull x) || ((builtins.substring 0 1 x) != "/") then
          null else x;
    in map mkDir (lib.filter (x: x != null) [
      paths.projects
      paths.media
      paths.peaks

      (keepOnlyAbs paths.renders)
    ]);

    programs.reanix.extraConfig."reaper.ini" = {
      reaper.defsavepath = paths.projects;

      reaper.defrecpath = paths.media;

      reaper.altpeaks = 5; # TODO: why this is here?
      reaper.altpeakspath = paths.peaks;

      reaper.defrenderpath = paths.renders;
    };
  };
}
