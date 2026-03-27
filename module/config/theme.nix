{ mkNullyOption, ... }:
{ inputs, config, pkgs, lib, ... }: let
  mrtnvgr-lib = inputs.mrtnvgr.lib { inherit pkgs; };
  inherit (mrtnvgr-lib.strings) unalias;

  cfg = config.programs.reanix;

  mkTheme = x: "/home/${config.home.username}/.config/REAPER/ColorThemes/${x}.ReaperThemeZip";

  aliases = {
    "<reapertips>" = mkTheme "Reapertips";
  };

  theme = unalias aliases cfg.config.theme.path;
in {
  options.programs.reanix.config = {
    theme.path = mkNullyOption {
      type = with lib.types; either (enum (lib.attrNames aliases)) path;
    };
  };

  config = lib.mkIf cfg.enable {
    programs.reanix.extraConfig."reaper.ini" = {
      reaper.lastthemefn5 = theme;
    };
  };
}
