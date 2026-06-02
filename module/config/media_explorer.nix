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
    programs.reanix.extraConfig."reaper.ini".reaper_sexplorer =
      (lib.optionalAttrs (mex.dock != null) { docked = boolToInt mex.dock; })
      // (lib.optionalAttrs (mex.media.loop != null) { repeat = boolToInt mex.media.loop; })
      // (lib.optionalAttrs (mex.columns.file_size      != null) { col1  = mex.columns.file_size.enable; })
      // (lib.optionalAttrs (mex.columns.title          != null) { col4  = mex.columns.title.enable; })
      // (lib.optionalAttrs (mex.columns.artist         != null) { col5  = mex.columns.artist.enable; })
      // (lib.optionalAttrs (mex.columns.album          != null) { col6  = mex.columns.album.enable; })
      // (lib.optionalAttrs (mex.columns.mod_date       != null) { col7  = mex.columns.mod_date.enable; })
      // (lib.optionalAttrs (mex.columns.genre          != null) { col8  = mex.columns.genre.enable; })
      // (lib.optionalAttrs (mex.columns.comment        != null) { col9  = mex.columns.comment.enable; })
      // (lib.optionalAttrs (mex.columns.description    != null) { col10 = mex.columns.description.enable; })
      // (lib.optionalAttrs (mex.columns.bpm            != null) { col11 = mex.columns.bpm.enable; })
      // (lib.optionalAttrs (mex.columns.key            != null) { col12 = mex.columns.key.enable; })
      // (lib.optionalAttrs (mex.columns.custom_tags    != null) { col13 = mex.columns.custom_tags.enable; })
      // (lib.optionalAttrs (mex.columns.favourite      != null) { col14 = mex.columns.favourite.enable; })
      // (lib.optionalAttrs (mex.columns.temporary_mark != null) { col15 = mex.columns.temporary_mark.enable; })
      // (lib.optionalAttrs (mex.columns.sample_rate    != null) { col16 = mex.columns.sample_rate.enable; })
      // (lib.optionalAttrs (mex.columns.channels       != null) { col17 = mex.columns.channels.enable; })
      // (lib.optionalAttrs (mex.columns.start_offset   != null) { col18 = mex.columns.start_offset.enable; })
      // (lib.optionalAttrs (mex.columns.length         != null) { col19 = mex.columns.length.enable; })
      // (lib.optionalAttrs (mex.columns.bitrate        != null) { col20 = mex.columns.bitrate.enable; })
      // (lib.optionalAttrs (mex.columns.peak_volume    != null) { col21 = mex.columns.peak_volume.enable; })
      // (lib.optionalAttrs (mex.columns.loudness       != null) { col23 = mex.columns.loudness.enable; })
      // (lib.optionalAttrs (mex.columns.image          != null) { col24 = mex.columns.image.enable; });
  };
}
