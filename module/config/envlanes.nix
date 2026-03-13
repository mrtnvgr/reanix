{ mkBitfield, mkEnabledOption }:
{ config, lib, ... }: let
  cfg = config.programs.reanix;

  envlanes = mkBitfield [
    cfg.config.show_new_envelopes_in_separate_envelope_lanes
    cfg.config.changing_envelope_in_lane
    cfg.config.draw_faint_peaks_in_automation_lanes
    cfg.config.antialiased_fades_and_envelopes
    cfg.config.filled_automation_envelopes
    cfg.config.filled_envelopes_when_drawn_over_media
    cfg.config.horizontal_grid_lines_in_automation_layers
  ];
in {
  options.programs.reanix.config = {
    show_new_envelopes_in_separate_envelope_lanes = mkEnabledOption "Show new envelopes in separate envelope lanes";
    changing_envelope_in_lane = mkEnabledOption "TODO";
    draw_faint_peaks_in_automation_lanes = mkEnabledOption "Draw faint peaks in automation envelope lanes";
    antialiased_fades_and_envelopes = mkEnabledOption "Antialiased fades and envelopes";
    filled_automation_envelopes = mkEnabledOption "Filled automation envelopes";
    filled_envelopes_when_drawn_over_media = lib.mkEnableOption "Filled envelopes when drawn over media";
    horizontal_grid_lines_in_automation_layers = mkEnabledOption "Horizontal grid lines in automation layers";
  };

  config = lib.mkIf cfg.enable {
    programs.reanix.extraConfig."reaper.ini" = /* dosini */ ''
      [reaper]
      envlanes=${toString envlanes}
    '';
  };
}
