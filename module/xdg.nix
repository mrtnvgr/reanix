{ lib, config, ... }: {
  config = lib.mkIf config.programs.reanix.enable {
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

      settings.StartupWMClass = "REAPER";
    };
  };
}
