{ config, lib, ... }: let
  cfg = config.programs.reanix;
  home = config.home.homeDirectory;
in {
  config = lib.mkIf cfg.defaults {
    programs.reanix.config.paths = {
      projects = lib.mkDefault "${home}/.local/REAPER/Projects";
      media    = lib.mkDefault "${home}/.cache/REAPER/Media";
      peaks    = lib.mkDefault "${home}/.cache/REAPER/Peaks";
    };
  };
}
