_:
{ inputs, config, pkgs, lib, ... }: let
  mrtnvgr-lib = inputs.mrtnvgr.lib { inherit pkgs; };
  inherit (mrtnvgr-lib.strings) unalias;

  cfg = config.programs.reanix;

  aliases = {
    "small" = 2;
    "medium" = 6;
    "large" = 16;
  };

  defvzoom = unalias aliases cfg.options.default_track_height;
in {
  options.programs.reanix.options = {
    default_track_height = lib.mkOption {
      type = with lib.types; either (enum (lib.attrNames aliases)) int;
      default = "medium";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.reanix.extraConfig."reaper.ini" = /* dosini */ ''
      [reaper]
      defvzoom=${toString defvzoom}
    '';
  };
}
