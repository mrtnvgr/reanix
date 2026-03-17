{ mkBitfield, mkEnabledOption, ... }:
{ inputs, config, pkgs, lib, ... }: let
  mrtnvgr-lib = inputs.mrtnvgr.lib { inherit pkgs; };
  inherit (mrtnvgr-lib.strings) unalias;

  cfg = config.programs.reanix;

  collapseAliases = {
    "Normal, small, collapsed" = [ false false ];
    "Normal, small, hidden"    = [ true  false ];
    "Normal, collapsed"        = [ false true  ];
    "Normal, hidden"           = [ true  true  ];
  };

  laneModesAliases = {
    "Big/small lanes" = false;
    "One/many lanes"  = true;
  };

  tcpalign = mkBitfield ([
    cfg.config.tcp.icon.keep_space
    false # TODO: ???
    false # TODO: ???
    false # TODO: ???
    false # TODO: ???
    false # TODO: ???
    false # TODO: ???
    false # TODO: ???
  ] ++ (unalias collapseAliases cfg.config.tcp.collapse_cycle) ++ [
    (unalias laneModesAliases cfg.config.tcp.lane_modes)
  ]);
in {
  options.programs.reanix.config = {
    tcp.icon.keep_space =     mkEnabledOption "Align TCP controls when track icons are used";

    tcp.collapse_cycle  = lib.mkOption {
      type = lib.types.enum (lib.attrNames collapseAliases);
      default = "Normal, small, collapsed";
      description = "Folder collapse button cycles track heights";
    };

    tcp.lane_modes      = lib.mkOption {
      type = lib.types.enum (lib.attrNames laneModesAliases);
      default = "One/many lanes";
      description = "Fixed lane collapse button changes display";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.reanix.extraConfig."reaper.ini" = /* dosini */ ''
      [reaper]
      tcpalign=${toString tcpalign}
    '';
  };
}
