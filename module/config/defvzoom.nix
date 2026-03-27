{ mkNullyOption, ... }:
{ inputs, config, pkgs, lib, ... }: let
  mrtnvgr-lib = inputs.mrtnvgr.lib { inherit pkgs; };
  inherit (mrtnvgr-lib.strings) unalias;

  cfg = config.programs.reanix;

  aliases = {
    "small" = 2;
    "medium" = 6;
    "large" = 16;
  };

  defvzoom = unalias aliases cfg.config.default_track_height;
in {
  options.programs.reanix.config = {
    default_track_height = mkNullyOption {
      type = with lib.types; either (enum (lib.attrNames aliases)) int;
    };
  };

  config = lib.mkIf cfg.enable {
    programs.reanix.extraConfig."reaper.ini" = {
      reaper.defvzoom = defvzoom;
    };
  };
}
