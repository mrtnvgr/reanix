{ mkBitfield, mkEnabledOption, mkNullyOption, ... }:
{ inputs, config, pkgs, lib, ... }: let
  mrtnvgr-lib = inputs.mrtnvgr.lib { inherit pkgs; };
  inherit (mrtnvgr-lib.strings) unalias;

  cfg = config.programs.reanix;

  transflags = mkBitfield [
    (!cfg.config.transport.playrate.show)
    (!cfg.config.transport.play_state.show)
    (!cfg.config.transport.time_signature.show)
      cfg.config.transport.controls.center
    false # TODO: "Use transport home/end for markers, transport home/end-context-menu"
    false # TODO: "Mousewheel moves transport time selection by beats(alt toggles)"
    false # TODO: "Flash transport yellow on possible audio device underrun"
  ];

  positions = {
    "Below arrange" = "0";
    "Above ruler" = "1";
    "Bottom of main window" = "2";
    "Top of main window" = "3";
  };
in {
  options.programs.reanix.config.transport = {
    playrate.show       =     mkEnabledOption "Show playrate control in transport";
    play_state.show     =     mkEnabledOption "Show play state as text in transport";
    time_signature.show =     mkEnabledOption "Show time signature in transport";
    controls.center     = lib.mkEnableOption  "Center transport controls";

    position = mkNullyOption {
      type = lib.types.enum (lib.attrNames positions);
      description = "Transport position";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.reanix.extraConfig."reaper.ini" = /* dosini */ ''
      [reaper]
      transflags=${toString transflags}

      ${lib.optionalString (cfg.config.transport.position != null) ''
        [reaper]
        transport_dock_pos=${unalias positions cfg.config.transport.position}
      ''}
    '';
  };
}
