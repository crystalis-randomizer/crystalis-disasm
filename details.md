This is the start of a more detailed rom map, since the one in
[README.md](README.md) is more of a summary.

## Rom Map

### Segment $00..$07 ($00000..$0ffff)

Map screen data is stored in the first 240 of every 256 bytes
(i.e. $0??00 to $0??ef).  Each screen is a 15x16 block of 16x16-pixel
metatile IDs.  The specific meaning of each metatile ID is determined
by the location's tileset.  This accounts for (almost) all the
possible map screens in the game, 256 in all (though a couple are
unused).  The only screens missing here are the shops, which are in
segment $0a.

The last 16 bytes of each block (i.e. the 16th row) have different
usages for each pair of segments:
  * Segments $00 and $01 ($00000..$03fff) store unknown data that
    seems to relate to the data table at $fe:cf47.
  * Segments $02 and $03 ($04000..$07fff) store palettes: each row
    fits four 4-byte palettes, for a total of 256 palettes.
  * Segments $04 and $05 ($08000..$0bfff) store person data in 4-byte
    chunks indexed by NPC ID.  This includes two bytes that get spawn
    in $680,x and $6a0,x (respectively) and are used typically for
    item grants, followed by a byte that indicates behavior (whether
    it's a statue, or else walking patterns), and the last byte is
    the metasprite ID (stored in $300,x and $6c0,x).
    
