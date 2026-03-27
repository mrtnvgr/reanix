{ config, lib, ... }: let
  cfg = config.programs.reanix;
in {
  config = lib.mkIf cfg.defaults {
    programs.reanix.extraConfig."reaper.ini" = {
      # Disable version checking
      reaper.verchk = lib.mkDefault 0;
      SWS."BR - StartupVersionCheck" = lib.mkDefault "0 0 0000000000";
    };
  };
}
