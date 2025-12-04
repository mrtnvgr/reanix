{ inputs, lib, config, pkgs, ... }:
let
  pkg = inputs.mrtnvgr.legacyPackages.${pkgs.stdenv.targetPlatform.system}.js_ReaScriptAPI;
  cfg = config.programs.reanix;
in {
  options.programs.reanix = {
    extensions.js_ReaScriptAPI.enable = lib.mkEnableOption "REAPER js_ReaScriptAPI extension";
  };

  config = lib.mkIf cfg.extensions.js_ReaScriptAPI.enable {
    home.file.".config/REAPER/UserPlugins/reaper_js_ReaScriptAPI64.so".source = "${pkg}/UserPlugins/reaper_js_ReaScriptAPI64.so";
    home.file.".config/REAPER/UserPlugins/reaper_js_ReaScriptAPI64.dll".source = "${pkg}/UserPlugins/reaper_js_ReaScriptAPI64.dll";
  };
}
