{ mkBitfield, mkEnabledOption }:
{ config, lib, ... }: let
  cfg = config.programs.reanix;

  showpeaks = mkBitfield [
    cfg.options.display_peaks_for_media_items
    cfg.options.display_peaks_while_recording
    cfg.options.display_peaks_only_for_selected_tracks
    cfg.options.display_peaks_only_for_audible_items
    cfg.options.draw_faint_peaks_in_folders
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
  options.programs.reanix.options = {
    display_peaks_for_media_items = mkEnabledOption "Display peaks for media items";
    display_peaks_while_recording = mkEnabledOption "Display peaks while recording";
    display_peaks_only_for_selected_tracks = lib.mkEnableOption "Displau peaks only for selected tracks";
    display_peaks_only_for_audible_items = lib.mkEnableOption "Only display peaks for tracks and items that are soloed or not muted";
    draw_faint_peaks_in_folders = mkEnabledOption "Draw faint peaks in folder tracks";

    # TODO: peaks display mode
  };

  config = lib.mkIf cfg.enable {
    programs.reanix.extraConfig."reaper.ini" = /* dosini */ ''
      [reaper]
      showpeaks=${toString showpeaks}
    '';
  };
}
