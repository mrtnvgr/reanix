{ lib, config, pkgs, ... }:
let
  inherit (lib) mkIf;
  cfg = config.programs.reanix;
  pkg = pkgs.reaper-reapack-extension;
in {
  options.programs.reanix = {
    extensions.reapack.enable = lib.mkEnableOption "REAPER ReaPack extension";
    extensions.reapack.package = lib.mkOption {
      type = lib.types.package;
      default = pkg;
    };
  };

  config = mkIf cfg.extensions.reapack.enable {
    home.file.".config/REAPER/UserPlugins/reaper_reapack-x86_64.so".source = "${pkg}/UserPlugins/reaper_reapack-x86_64.so";
  };
}
