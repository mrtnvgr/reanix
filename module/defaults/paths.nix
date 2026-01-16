{ config, lib, ... }: let
  cfg = config.programs.reanix;
  home = config.home.homeDirectory;
in {
  config = lib.mkIf cfg.defaults {
    programs.reanix.paths = {
      projects = "${home}/.local/REAPER/Projects";
      media = "${home}/.cache/REAPER/Media";
      peaks = "${home}/.cache/REAPER/Peaks";
    };
  };
}
