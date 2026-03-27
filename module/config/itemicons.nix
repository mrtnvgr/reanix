{ mkEnabledOption, ... }:
{ config, lib, ... }: let
  cfg = config.programs.reanix;
  opts = cfg.config.item.icons;

  # itemicons = mkBitfield ([ ]);
in {
  # TODO: finish

  # defaults:
  # locked - on
  # not locked - off
  # muted - on
  # not muted - on
  # per take fx - on
  # no fx - on
  # automation envs - on
  # no active envelopes - off
  # notes - on
  # no notes - off
  # item properties - off
  # item props if resampled media - on
  # item props if phase inverted - off
  # grouped - on
  # pooled midi/ara - on
  # volume knob - on
  # item timebase - off
  # item timebase if overriden for the track or media item - off

  options.programs.reanix.config = {
    item.icons = {
      locked        =     mkEnabledOption "Locked";
      not_locked    = lib.mkEnableOption  "Not locked";

      muted         =     mkEnabledOption "Muted";
      not_muted     =     mkEnabledOption "Not muted";

      fx            =     mkEnabledOption "Per take FX";
      no_fx         =     mkEnabledOption "No FX";

      automation    =     mkEnabledOption "Automation envelopes";
      no_automation = lib.mkEnableOption  "No active automation envelopes";

      notes         =     mkEnabledOption "Notes";
      no_notes      = lib.mkEnableOption  "No notes";

      properties = {
        regular        = lib.mkEnableOption  "Item properties";
        resampled      =     mkEnabledOption "Item properties if resampled media";
        phase_inverted = lib.mkEnableOption  "Item properties if phase inverted";
      };

      grouped     = mkEnabledOption "Grouped";

      pooled      = mkEnabledOption "Pooled MIDI/ARA";

      volume_knob = mkEnabledOption "Volume knob";

      timebase = {
        normal    = lib.mkEnableOption "Item timebase";
        overriden = lib.mkEnableOption "Item timebase if overriden for the track or media item";
      };

      min_height = lib.mkOption {
        type = with lib.types; nullOr int;
        default = null;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    programs.reanix.extraConfig."reaper.ini" = {
      reaper.itemicons_minheight = opts.min_height;
    };
  };
}
