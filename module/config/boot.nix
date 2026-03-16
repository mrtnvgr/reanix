{ mkNullyOption, boolToInt, ... }:
{ inputs, config, pkgs, lib, ... }: let
  mrtnvgr-lib = inputs.mrtnvgr.lib { inherit pkgs; };
  inherit (mrtnvgr-lib.strings) unalias;

  cfg = config.programs.reanix;
  boot = cfg.config.boot;

  projectAliases = {
    "Last active project" = "16";
    "Last project tabs" = "17";
    "New project (ignore default template)" = "18";
    "New project" = "19";
    "Prompt" = "20";
  };
in {
  options.programs.reanix.config.boot = {
    animation = mkNullyOption {
      type = lib.types.bool;
      description = "REAPER's boot animation";
    };

    project = mkNullyOption {
      type = lib.types.enum (lib.attrNames projectAliases);
      description = "What to open at REAPER startup";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.reanix.extraConfig."reaper.ini" = /* dosini */ ''
      ${lib.optionalString (boot.animation != null) ''
        ; Boot animation
        [reaper]
        splashfast=${boolToInt boot.animation}
      ''}

      ${lib.optionalString (boot.project != null) ''
        ; Open project at startup: ${boot.project}
        [reaper]
        loadlastproj=${unalias projectAliases boot.project}
      ''}
    '';
  };
}
