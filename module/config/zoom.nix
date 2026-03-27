{ mkNullyOption, ... }:
{ inputs, config, pkgs, lib, ... }: let
  mrtnvgr-lib = inputs.mrtnvgr.lib { inherit pkgs; };
  inherit (mrtnvgr-lib.strings) unalias;

  cfg = config.programs.reanix;

  aliases = {
    "Edit cursor or play cursor" = "0";
    "Edit cursor"                = "1";
    "Center of view"             = "2";
    "Mouse cursor"               = "3";
  };

  zoommode = unalias aliases cfg.config.zoom.horizontal;
in {
  options.programs.reanix.config = {
    zoom.horizontal = mkNullyOption {
      type = lib.types.enum (lib.attrNames aliases);
    };
  };

  config = lib.mkIf cfg.enable {
    programs.reanix.extraConfig."reaper.ini" = {
      reaper.zoommode = zoommode;
    };
  };
}
