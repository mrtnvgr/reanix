{ mkBitfield, mkEnabledOption, ... }:
{ config, lib, ... }: let
  cfg = config.programs.reanix;

  showpeaks = mkBitfield [
    cfg.config.items.peaks.enable
    cfg.config.display_peaks_while_recording
    cfg.config.display_peaks_only_for_selected_tracks
    cfg.config.display_peaks_only_for_audible_items
    cfg.config.folders.faint_peaks.enable
    false
    false
    false
    false
    true
    false
    false
    false
  ];
in {
  options.programs.reanix.config = {
    items.peaks.enable                     =     mkEnabledOption "Display peaks for media items";
    display_peaks_while_recording          =     mkEnabledOption "Display peaks while recording";
    display_peaks_only_for_selected_tracks = lib.mkEnableOption  "Displau peaks only for selected tracks";
    display_peaks_only_for_audible_items   = lib.mkEnableOption  "Only display peaks for tracks and items that are soloed or not muted";
    folders.faint_peaks.enable             =     mkEnabledOption "Draw faint peaks in folder tracks";

    # TODO: peaks display mode
  };

  config = lib.mkIf cfg.enable {
    programs.reanix.extraConfig."reaper.ini" = {
      reaper.showpeaks = showpeaks;
    };
  };
}
