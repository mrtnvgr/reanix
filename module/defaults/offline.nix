{ config, lib, ... }: let
  cfg = config.programs.reanix;
in {
  config = lib.mkIf cfg.defaults {
    programs.reanix.extraConfig."reaper.ini" = {
      # Disable version checking
      reaper.verchk = 0;
      SWS."BR - StartupVersionCheck" = "0 0 0000000000";
    };
  };
}
