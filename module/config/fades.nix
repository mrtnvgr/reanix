{ mkNullyOption, ... }:
{ config, lib, ... }: let
  cfg = config.programs.reanix;
  inherit (cfg.config) fades;

  intToMs = x: x * 0.001;
in {
  options.programs.reanix.config.fades = {
    default_length = mkNullyOption {
      type = lib.types.int;
      description = "Length of automatic fade-in/fade-out/xfades for new items (in ms)";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.reanix.extraConfig."reaper.ini" = {
      reaper.deffadelen = intToMs fades.default_length;
      reaper.defsplitxfadelen = intToMs fades.default_length;
    };
  };
}
