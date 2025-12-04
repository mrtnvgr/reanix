{ inputs, pkgs, lib, config, ... }: let
  mrtnvgr-lib = inputs.mrtnvgr.lib { inherit pkgs; };
  inherit (mrtnvgr-lib.strings) quote;

  cfg = config.programs.reanix;

  scriptOptions = {
    source = lib.mkOption {
      type = lib.types.path;
    };

    key = lib.mkOption {
      type = with lib.types; nullOr str;
      default = null;
    };
  };
in {
  options.programs.reanix = {
    scripts = lib.mkOption {
      type = with lib.types; attrsOf (submodule {
        options = scriptOptions;
      });
      default = {};
    };
  };

  config = lib.mkIf cfg.enable {
    home.file = lib.mapAttrs' (name: value:
      lib.nameValuePair
        ".config/REAPER/Scripts/nix/${name}.lua"
        { inherit (value) source; }
    ) cfg.scripts;

    programs.reanix.config."reaper-kb.ini" = let
      toHash = x: builtins.hashString "sha1" x;

      scriptRegistry = lib.mapAttrsToList (name: value: ''
        SCR 4 0 RS${toHash name} ${quote "Script: ${name} (from nix)"} ${quote "nix/${name}.lua"}
      '') cfg.scripts;

      mappedScripts = lib.filterAttrs (name: value: value.key != null) cfg.scripts;

      mappingRegistry = lib.mapAttrsToList (name: value: ''
        KEY ${value.key} _RS${toHash name} 0
      '') mappedScripts;
    in
      lib.concatLines (scriptRegistry ++ mappingRegistry);
  };
}
