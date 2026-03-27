{ boolToInt, mkNullyOption, ... }:
{ config, lib, ... }: let
  cfg = config.programs.reanix;
  mex = cfg.config.media_explorer;

  # option2ini "reaper_sexplorer" "docked" mex.dock;
  # option2ini = group: option: cfg: lib.optionalString (cfg != null) ''
  #   [${group}]
  #   ${option}=
  # '';

  # mkColumnReaperOption = desc: cfg: col_num: lib.optionalString (cfg != null) ''
  #   ; "${desc}" search column
  #   [reaper_sexplorer]
  #   col${toString col_num}=${boolToInt cfg}
  # '';
  #
  # options = map (x: mkColumnReaperOption x) [
  #   ["File size"         mex.columns.file_size.enable       1]
  #   ["Title"             mex.columns.title.enable           4]
  #   ["Artist"            mex.columns.artist.enable          5]
  #   ["Album"             mex.columns.album.enable           6]
  #   ["Modification date" mex.columns.mod_date.enable        7]
  #   ["Genre"             mex.columns.genre.enable           8]
  #   ["Comment"           mex.columns.comment.enable         9]
  #   ["Description"       mex.columns.description.enable    10]
  #   ["BPM"               mex.columns.bpm.enable            11]
  #   ["Key"               mex.columns.key.enable            12]
  #   ["Custom tags"       mex.columns.custom_tags.enable    13]
  #   ["Favourite"         mex.columns.favourite.enable      14]
  #   ["Temporary mark"    mex.columns.temporary_mark.enable 15]
  #   ["Sample rate"       mex.columns.sample_rate.enable    16]
  #   ["Channels"          mex.columns.channels.enable       17]
  #   ["Start offset"      mex.columns.start_offset.enable   18]
  #   ["Length"            mex.columns.length.enable         19]
  #   ["Bitrate"           mex.columns.bitrate.enable        20]
  #   ["Peak volume"       mex.columns.peak_volume.enable    21]
  #   ["Loudness"          mex.columns.loudness.enable       23]
  #   ["Image"             mex.columns.image.enable          24]
  # ];
in {
  options.programs.reanix.config.media_explorer = {
    dock       = mkNullyOption { type = lib.types.bool; };
    media.loop = mkNullyOption { type = lib.types.bool; };

    # columns = {
    #   file_size.enable      = mkNullyOption { type = lib.types.bool; };
    #   title.enable          = mkNullyOption { type = lib.types.bool; };
    #   artist.enable         = mkNullyOption { type = lib.types.bool; };
    #   album.enable          = mkNullyOption { type = lib.types.bool; };
    #   mod_date.enable       = mkNullyOption { type = lib.types.bool; };
    #   genre.enable          = mkNullyOption { type = lib.types.bool; };
    #   comment.enable        = mkNullyOption { type = lib.types.bool; };
    #   description.enable    = mkNullyOption { type = lib.types.bool; };
    #   bpm.enable            = mkNullyOption { type = lib.types.bool; };
    #   key.enable            = mkNullyOption { type = lib.types.bool; };
    #   custom_tags.enable    = mkNullyOption { type = lib.types.bool; };
    #   favourite.enable      = mkNullyOption { type = lib.types.bool; };
    #   temporary_mark.enable = mkNullyOption { type = lib.types.bool; };
    #   sample_rate.enable    = mkNullyOption { type = lib.types.bool; };
    #   channels.enable       = mkNullyOption { type = lib.types.bool; };
    #   start_offset.enable   = mkNullyOption { type = lib.types.bool; };
    #   length.enable         = mkNullyOption { type = lib.types.bool; };
    #   bitrate.enable        = mkNullyOption { type = lib.types.bool; };
    #   peak_volume.enable    = mkNullyOption { type = lib.types.bool; };
    #   loudness.enable       = mkNullyOption { type = lib.types.bool; };
    #   image.enable          = mkNullyOption { type = lib.types.bool; };
    # };
  };

  config = lib.mkIf cfg.enable {
    programs.reanix.extraConfig."reaper.ini" = {
      reaper_sexplorer.docked = boolToInt mex.dock;
      reaper_sexplorer.repeat = boolToInt mex.media.loop;
    };
  };
}
