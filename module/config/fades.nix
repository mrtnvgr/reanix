{ mkNullyOption, ... }:
{ config, lib, ... }: let
  cfg = config.programs.reanix;
  inherit (cfg.config) fades;

  intToStrMs = x: toString (x * 0.001);
in {
  options.programs.reanix.config.fades = {
    default_length = mkNullyOption {
      type = lib.types.int;
      description = "length of automatic fade-in/fade-out/xfades for new items (in ms)";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.reanix.extraConfig."reaper.ini" = /* dosini */ ''
      ${lib.optionalString (fades.default_length != null) ''
        ; Length of automatic fade-in/fade-out/xfades for new items
        [reaper]
        deffadelen=${intToStrMs fades.default_length}
        defsplitxfadelen=${intToStrMs fades.default_length}
      ''}
    '';
  };
}
