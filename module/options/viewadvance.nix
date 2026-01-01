{ mkBitfield, mkEnabledOption }:
{ config, lib, ... }: let
  cfg = config.programs.reanix;

  viewadvance = mkBitfield [
    cfg.options.autoscroll_during_playback
    cfg.options.scroll_track_view_while_recording
    cfg.options.dont_autoscroll_view_when_viewing_other_parts
    cfg.options.scroll_view_to_edit_cursor_on_stop
    cfg.options.continuous_scrolling
  ];
in {
  options.programs.reanix.options = {
    autoscroll_during_playback = lib.mkEnableOption "auto-scroll during playback";
    scroll_track_view_while_recording = mkEnabledOption "scroll track view while recording";
    dont_autoscroll_view_when_viewing_other_parts = lib.mkEnableOption "don't autoscroll view when viewing other parts";
    scroll_view_to_edit_cursor_on_stop = lib.mkEnableOption "scroll view to edit cursor on stop";
    continuous_scrolling = mkEnabledOption "continuous scrolling";
  };

  config = lib.mkIf cfg.enable {
    programs.reanix.extraConfig."reaper.ini" = /* dosini */ ''
      [reaper]
      viewadvance=${toString viewadvance}
    '';
  };
}
