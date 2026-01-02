{ mkBitfield, mkEnabledOption }:
{ inputs, pkgs, config, lib, ... }: let
  mrtnvgr-lib = inputs.mrtnvgr.lib { inherit pkgs; };
  inherit (mrtnvgr-lib.strings) unalias;

  cfg = config.programs.reanix;

  labelitems2 = mkBitfield ([
    cfg.options.display_media_item_take_name
    cfg.options.show_labels_for_items_when_item_edges_are_not_visible
    cfg.options.display_media_item_pitch_playrate_if_set
    cfg.options.draw_labels_above_the_item.enable
    (!cfg.options.display_media_item_gain_if_set)
  ] ++ stillImageThumbnailDisplayMode ++ [
    false # ???
    true # ???
    (!cfg.options.draw_selection_indicator_on_items)
  ]);

  sitdmAliases = {
    "Center/tile image" = [ false false false ];
    "No thumbnail" = [ false true false ];
    "Full height" = [ true false false ];
    "Stretch image" = [ false false true ];
  };
  stillImageThumbnailDisplayMode = unalias sitdmAliases cfg.options.still_image_thumbnail_display_mode;

  labelHeight = cfg.options.draw_labels_above_the_item.whenHeightLessThan;
in {
  options.programs.reanix.options = {
    display_media_item_take_name = mkEnabledOption "display media item take name";
    show_labels_for_items_when_item_edges_are_not_visible = mkEnabledOption "show labels for items when item edges are not visible";
    display_media_item_pitch_playrate_if_set = mkEnabledOption "display media item pitch/playrate if set";
    draw_labels_above_the_item = {
      enable = mkEnabledOption "draw labels above the item when media item height is more than ... pixels";

      whenHeightLessThan = lib.mkOption {
        type = with lib.types; nullOr int;
        default = null;
      };
    };
    display_media_item_gain_if_set = mkEnabledOption "display media item gain if set";
    still_image_thumbnail_display_mode = lib.mkOption {
      type = lib.types.enum (lib.attrNames sitdmAliases);
      default = "Center/tile image";
    };
    draw_selection_indicator_on_items = lib.mkEnableOption "draw selection indicator on items";
  };

  config = lib.mkIf cfg.enable {
    programs.reanix.extraConfig."reaper.ini" = /* dosini */ ''
      [reaper]
      labelitems2=${toString labelitems2}
      ${lib.optionalString (labelHeight != null) ''
        itemlabel_minheight=${toString labelHeight}
      ''}
    '';
  };
}
