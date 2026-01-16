{ config, lib, ... }: let
  cfg = config.programs.reanix;
  paths = cfg.default_path;
in {
  options.programs.reanix.options = {
    default_path = {
      projects = lib.mkOption {
        type = with lib.types; nullOr singleLineStr;
        default = null;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.user.tmpfiles.rules = [
      "d ${paths.projects}"
    ];

    programs.reanix.extraConfig."reaper.ini" = /* dosini */ ''
      ; Default project save directory
      [reaper]
      defsavepath=${paths.projects}
    '';
  };
}
