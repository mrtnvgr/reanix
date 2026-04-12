{ mkBitfield, mkEnabledOption, ... }:
{ config, lib, ... }: let
  cfg = config.programs.reanix;

  envlanes = mkBitfield [
    cfg.config.automation.show_new_in_separate_lanes
    cfg.config.automation.changing_envelope_in_lane
    cfg.config.automation.faint_peaks.enable
    cfg.config.antialiasing.fades_envelopes
    cfg.config.automation.fill.in_lanes
    cfg.config.automation.fill.over_media
    cfg.config.automation.grid.horizontal.enable
  ];

  env_reduce = mkBitfield [
    cfg.config.automation.points.recording.reduce
    cfg.config.automation.points.edge.auto_on.media
    cfg.config.automation.points.edge.auto_on.ripple
    false # TODO
    false # TODO
    false # TODO
    false # TODO
    false # TODO
    cfg.config.automation.points.edge.auto_on.multiple
    cfg.config.automation.points.guard
  ];
in {
  options.programs.reanix.config = {
    automation.show_new_in_separate_lanes =    mkEnabledOption "Show new envelopes in separate envelope lanes";
    automation.changing_in_lane           =    mkEnabledOption "TODO";
    automation.faint_peaks.enable         =    mkEnabledOption "Draw faint peaks in automation envelope lanes";
    antialiasing.fades_envelopes          =    mkEnabledOption "Antialiased fades and envelopes";
    automation.fill.in_lanes              =    mkEnabledOption "Fill automation envelopes";
    automation.fill.over_media            = lib.mkEnableOption "Filled envelopes when drawn over media";
    automation.grid.horizontal.enable     =    mkEnabledOption "Horizontal grid lines in automation layers";

    automation.points.recording.reduce      =    mkEnabledOption "Reduce envelope point data when recording or drawing automation";
    automation.points.edge.auto_on.media    =    mkEnabledOption "Add edge points when moving envelope points with items";
    automation.points.edge.auto_on.ripple   =    mkEnabledOption "Add edge points when ripple editing or inserting time";
    automation.points.edge.auto_on.multiple = lib.mkEnableOption "Add edge points when moving multiple envelope points";
    automation.points.guard                 = lib.mkEnableOption "Prevent mouse edits of single envelope points from moving past other envelope points";
  };

  config = lib.mkIf cfg.enable {
    programs.reanix.extraConfig."reaper.ini".reaper = {
      envlanes = envlanes;
      env_reduce = env_reduce;
    };
  };
}
