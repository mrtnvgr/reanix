{ lib, config, pkgs, ... }:
let
  cfg = config.programs.reanix;
  exts = cfg.extensions;

  pkg = pkgs.callPackage (pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/mrtnvgr/nixpkgs-fork/0f51bce94e3c13473e9958afbb0b16d32790412b/pkgs/by-name/re/reaper-realearn-extension/package.nix";
    hash = "sha256-fqeE1tosx7v3+GGjXPGqIagU8C2owM3ve2oD/c1LM9E=";
  }) {};

  plugin = pkgs.stdenvNoCC.mkDerivation {
    name = "helgobox-plugin";

    dontUnpack = true;
    dontBuild = true;

    installPhase = ''
      mkdir -p $out/lib/vst3
      cp ${pkg}/lib/libhelgobox.so $out/lib/vst3
    '';
  };
in {
  options.programs.reanix = {
    extensions = {
      realearn.enable = lib.mkEnableOption "REAPER ReaLearn extension";
      playtime.enable = lib.mkEnableOption "REAPER Playtime extension";
    };
  };

  config = lib.mkIf (exts.realearn.enable || exts.playtime.enable) {
    home.packages = [ plugin ];
    home.file.".config/REAPER/UserPlugins/reaper_helgobox.so".source = "${pkg}/lib/libreaper_helgobox.so";

    programs.reanix.extraConfig."Helgoboss/ReaLearn/realearn.ini" = ''
      [main]
      showed_welcome_screen=1
      notify_about_updates=0
    '';
  };
}
