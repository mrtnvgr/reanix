{ boolToInt, mkNullyOption, ... }:
{ config, lib, ... }: let
  cfg = config.programs.reanix;
  mex = cfg.config.media_explorer;
in {
  options.programs.reanix.config.media_explorer = {
    dock       = mkNullyOption { type = lib.types.bool; };
    media.loop = mkNullyOption { type = lib.types.bool; };

    columns = {
      file_size.enable      = mkNullyOption { type = lib.types.bool; };
      title.enable          = mkNullyOption { type = lib.types.bool; };
      artist.enable         = mkNullyOption { type = lib.types.bool; };
      album.enable          = mkNullyOption { type = lib.types.bool; };
      mod_date.enable       = mkNullyOption { type = lib.types.bool; };
      genre.enable          = mkNullyOption { type = lib.types.bool; };
      comment.enable        = mkNullyOption { type = lib.types.bool; };
      description.enable    = mkNullyOption { type = lib.types.bool; };
      bpm.enable            = mkNullyOption { type = lib.types.bool; };
      key.enable            = mkNullyOption { type = lib.types.bool; };
      custom_tags.enable    = mkNullyOption { type = lib.types.bool; };
      favourite.enable      = mkNullyOption { type = lib.types.bool; };
      temporary_mark.enable = mkNullyOption { type = lib.types.bool; };
      sample_rate.enable    = mkNullyOption { type = lib.types.bool; };
      channels.enable       = mkNullyOption { type = lib.types.bool; };
      start_offset.enable   = mkNullyOption { type = lib.types.bool; };
      length.enable         = mkNullyOption { type = lib.types.bool; };
      bitrate.enable        = mkNullyOption { type = lib.types.bool; };
      peak_volume.enable    = mkNullyOption { type = lib.types.bool; };
      loudness.enable       = mkNullyOption { type = lib.types.bool; };
      image.enable          = mkNullyOption { type = lib.types.bool; };
    };
  };

  config = lib.mkIf cfg.enable {
    programs.reanix.extraConfig."reaper.ini".reaper_sexplorer = {
      docked = boolToInt mex.dock;
      repeat = boolToInt mex.media.loop;

      col1  = mex.columns.file_size.enable;
      col4  = mex.columns.title.enable;
      col5  = mex.columns.artist.enable;
      col6  = mex.columns.album.enable;
      col7  = mex.columns.mod_date.enable;
      col8  = mex.columns.genre.enable;
      col9  = mex.columns.comment.enable;
      col10 = mex.columns.description.enable;
      col11 = mex.columns.bpm.enable;
      col12 = mex.columns.key.enable;
      col13 = mex.columns.custom_tags.enable;
      col14 = mex.columns.favourite.enable;
      col15 = mex.columns.temporary_mark.enable;
      col16 = mex.columns.sample_rate.enable;
      col17 = mex.columns.channels.enable;
      col18 = mex.columns.start_offset.enable;
      col19 = mex.columns.length.enable;
      col20 = mex.columns.bitrate.enable;
      col21 = mex.columns.peak_volume.enable;
      col23 = mex.columns.loudness.enable;
      col24 = mex.columns.image.enable;
    };
  };
}
