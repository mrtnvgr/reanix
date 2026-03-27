{ inputs, config, lib, pkgs, ... }: let
  mrtnvgr-lib = inputs.mrtnvgr.lib { inherit pkgs; };

  user = config.home.username;

  mkPluginsPaths = format:
    lib.replaceString ":" ";" (mrtnvgr-lib.mkAudioPluginsPaths user format);

  vst_path = (mkPluginsPaths "vst3") + (mkPluginsPaths "vst2");
  clap_path = mkPluginsPaths "clap";
  lv2_path = mkPluginsPaths "lv2";

  cfg = config.programs.reanix;
in {
  config = lib.mkIf cfg.defaults {
    # TODO: convert to config
    programs.reanix.extraConfig."reaper.ini" = {
      reaper.vstpath = vst_path;
      reaper.clap_path_linux-x86_64 = clap_path;
      reaper.lv2path_linux = lv2_path;
    };
  };
}
