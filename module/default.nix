inputs:
{ pkgs, lib, config, ... }:
let
  margesimpson = inputs.margesimpson.packages.${pkgs.stdenv.targetPlatform.system}.default;

  cfg = config.programs.reanix;

  # 1st method of config applying: append lines and remove duplicates
  # why reaper-kb.ini: properties do not have a value
  # TODO: auto old script removal???
  # TODO: auto removal of duplicate keybinds

  configApplyingScript = lib.mapAttrsToList (name: value: ''
    ${margesimpson}/bin/margesimpson -t .config/REAPER/${name} ${pkgs.writeText "${name}-patches" value}
  '') (lib.removeAttrs cfg.extraConfig [ "reaper-kb.ini" ]);

  reaper-wrapped = pkgs.writeScriptBin "reaper" /* bash */ ''
    ${lib.concatStringsSep "\n" configApplyingScript}

    # TODO: remove this workaround when TODOs will be implemented
    cat ${pkgs.writeText "reaper-kb" cfg.extraConfig."reaper-kb.ini"} > ~/.config/REAPER/reaper-kb.ini

    ${cfg.hooks.preRun}

    ${cfg.package}/bin/reaper $@
  '';
in {
  options.programs.reanix = {
    enable = lib.mkEnableOption "ReaNix";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.reaper;
    };

    extraConfig = lib.mkOption {
      type = with lib.types; attrsOf lines;
      default = { };
    };

    hooks = {
      preRun = lib.mkOption {
        type = lib.types.lines;
        default = "";
      };
    };

    defaults = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  imports = [
    ./extensions
    ./scripts
    ./templates
    ./defaults
    ./colors.nix
    ./options
  ];

  config = lib.mkIf cfg.enable {
    home.packages = [ reaper-wrapped ];

    xdg.desktopEntries.reaper = {
      name = "REAPER";
      genericName = "Digital Audio Workstation";
      icon = "cockos-reaper";
      exec = "reaper %F";
      type = "Application";
      categories = ["Audio" "Video" "AudioVideo" "AudioVideoEditing" "Recorder"];
      mimeType = [
        "application/x-reaper-project"
        "application/x-reaper-project-backup"
        "application/x-reaper-theme"
      ];

      settings = {
        StartupWMClass = "REAPER";
      };
    };
  };
}
