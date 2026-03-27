{ mkBitfield, mkEnabledOption, ... }:
{ config, lib, ... }: let
  cfg = config.programs.reanix;

  loopnewitems = mkBitfield [
      false # TODO: ???
      cfg.config.items.loop.midi
      cfg.config.items.loop.imported
      cfg.config.items.loop.recorded
      cfg.config.items.loop.punched
    (!cfg.config.items.loop.glued)
  ];
in {
  options.programs.reanix.config = {
    items.loop = {
      midi     = mkEnabledOption "Enable looping for MIDI items";
      imported = mkEnabledOption "Enable looping for imported items";
      recorded = mkEnabledOption "Enable looping for recorded items";
      glued    = mkEnabledOption "Enable looping for glued items";
      punched  = mkEnabledOption "Time selection auto-punch audio recording creates loopable section";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.reanix.extraConfig."reaper.ini" = {
      reaper.loopnewitems = loopnewitems;
    };
  };
}
