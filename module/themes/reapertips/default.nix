{ lib, config, pkgs, ... }: let
  cfg = config.programs.reanix.themes.reapertips;
  package = pkgs.callPackage ./package.nix { };
in {
  options.programs.reanix.themes.reapertips = {
    enable = lib.mkEnableOption "REAPERTIPS theme";

    undimmed = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Remove dimming from track and item colors";
    };

    colored_track_names = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "";
    };
  };

  config = lib.mkIf cfg.enable {
    home.file.".config/REAPER/ColorThemes/Reapertips.ReaperThemeZip".source = package.override {
      inherit (cfg) undimmed colored_track_names;
    };

    home.packages = with pkgs; [ fira-sans roboto ];
  };
}
