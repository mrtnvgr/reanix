{ mkBitfield, ... }:
{ inputs, config, pkgs, lib, ... }: let
  mrtnvgr-lib = inputs.mrtnvgr.lib { inherit pkgs; };
  inherit (mrtnvgr-lib.strings) unalias;

  cfg = config.programs.reanix;

  mediaAddWhenAliases = {
    "On stop" = false;
    "At each loop" = true;
  };

  # TODO: incomplete
  recaddatloop = mkBitfield [
    (unalias mediaAddWhenAliases cfg.config.recording.looped.media.add_when)
    cfg.config.recording.looped.takes.new_file
    cfg.config.recording.looped.takes.incomplete.discard
  ];
in {
  options.programs.reanix.config = {
    recording.looped.media.add_when = lib.mkOption {
      type = lib.types.enum (lib.attrNames mediaAddWhenAliases);
      default = "On stop";
      description = "Add recorded media to project <> when recording and looped";
    };

    recording.looped.takes.new_file = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Create new files on loop when recording and looped";
    };

    recording.looped.takes.incomplete.discard = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "In loop recording, discard incomplete first or last takes if at least one full loop was recorded";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.reanix.extraConfig."reaper.ini" = /* dosini */ ''
      [reaper]
      recaddatloop=${toString recaddatloop}
    '';
  };
}
