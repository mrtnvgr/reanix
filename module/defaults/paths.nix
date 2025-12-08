{ config, lib, ... }: let
  home = config.home.homeDirectory;

  media_path = "${home}/.cache/REAPER/Media";
  peaks_path = "${home}/.cache/REAPER/Peaks";

  cfg = config.programs.reanix;
in {
  config = lib.mkIf cfg.defaults {
    systemd.user.tmpfiles.rules = [
      "d ${media_path}"
      "d ${peaks_path}"
    ];

    programs.reanix.config."reaper.ini" = /* dosini */ ''
      ; Save reapeaks in a cache directory
      [reaper]
      altpeaks=5
      altpeakspath=${peaks_path}

      ; Default media directory for unsaved projects
      [reaper]
      defrecpath=${media_path}
    '';
  };
}
