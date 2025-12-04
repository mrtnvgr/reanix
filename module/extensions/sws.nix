{ lib, config, pkgs, ... }:
let
  cfg = config.programs.reanix;
in {
  options.programs.reanix = {
    extensions.sws.enable = lib.mkEnableOption "REAPER SWS extension";
  };

  config = lib.mkIf cfg.extensions.sws.enable {
    home.file.".config/REAPER/UserPlugins/reaper_sws-x86_64.so".source = "${pkgs.reaper-sws-extension}/UserPlugins/reaper_sws-x86_64.so";

    home.file.".config/REAPER/Scripts/sws_python64.py".source = "${pkgs.reaper-sws-extension}/Scripts/sws_python64.py";
    home.file.".config/REAPER/Scripts/sws_python.py".source = "${pkgs.reaper-sws-extension}/Scripts/sws_python.py";
  };
}
