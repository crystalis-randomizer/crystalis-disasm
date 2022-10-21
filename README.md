# Crystalis Disassembly

This is a repository to track the disassembly of the Crystalis game.
Because the game is proprietary, we do not store the actual bytes or
opcodes in this repository.  Instead, we clean the disassembly to only
include hand-written comments or formatting, and whether any given
locus is code or data.

## Usage

To use this repository, you must have a legally-obtained dump of the
Crystalis data, stored in a file `Crystalis.nes` at the top level
of the repository.  You must also copy/link `scripts/git-disasm`
to somewhere in your `$PATH` so that running `git-disasm` from a bare
command-line produces an error "No action given" rather than something
like "command not found".

Then run the following:

```sh
git config --local include.path ../.gitconfig
rm Crystalis.s
git checkout Crystalis.s
```

This should rehydrate the file in your local repository to include
all the proprietary data from the dump.

From this point on, you may edit `Crystalis.s` as you see fit.

## Rom Map

### Segment $00..$07 ($00000..$0ffff)

* 256 map screens' data (first 240 of every 256 bytes)
* 256 color palettes ($0xxfx interleaved in $04000..$07fff)
* 256 person data ($0xxfx interleaved in $08000..$0bfff)

### Segment $08 and $09 ($10000..$13fff)

* 12 tileset data
    * component tiles (1k per tileset, $10000..$12fff)
    * tile attributes (64b per tileset, $13000..$132ff)
    * game effects (256b * 11 tilesets, $13300..$13dff)
    * flag alternatives (32b per tileset, $13e00..$13f7f)
* Unused space
    * 128 bytes at end ($13f80..$13fff)

### Segment $0a and $0b ($14000..$17fff)

* 3 shop screens' data ($14000..$142ff)
* 256 location data ($14300..$17cf9)
* Special hardcoded dyna screen ($17e00..$17eff)
* Unused space
    * 262 bytes before dyna ($17cfa..$17dff)
    * 256 bytes at end ($17f00..$17fff)

### Segment $0c and $0d ($18000..$1bfff)

* 118 sound effect tracks ($18000..$19201)
    * NOTE: this is anomalously read from the 2nd MMC3 bank!
* 256 location spawn tables ($19201..$1aba2, $1bff0..$1bfff)
* 256 object data tables ($1ac00..$1be90)
* Unused space
    * 93 bytes between spawns and objects ($1aba3..$1abff)
    * 351 bytes after object table ($1be91..$1bfef)

### Segment $0e and $0f ($1c000..$1ffff)

* Code (with some interleaved data)
    * NPC spawn and dialog routines ($1c000..$1c0e2)
    * Trigger square checks ($1c0e3..$1c178)
    * Telepathy data ($1c179..$1c26e)
    * Item acquisition ($1c26f..$1c31d)
    * Item use ($1c31e..$1c5df)
    * Boss behavior ($1e400..$1f95c)
    * Generals escape ($1fa98..$1fbae)
    * Title screen ($1fc40..$1ff96)
* 208 NPCs' spawn conditions ($1c5e0..$1c95c)
* 196 NPCs' dialog data ($1c95d..$1d8f3)
* Telepathy data ($1d8f4..1daff)
* Item tables ($1db00..$1e179)
* Trigger data ($1e17a..1e3bf)
* Boss data ($1f95d..$1fa97)
* Unused space
    * 64 bytes after item tables ($1e3c0..$1e3ff)
    * 145 bytes after general escape data ($1fbaf..$1fc3f)
    * 105 bytes at end ($1ff97..$1ffff)

### Segment $10 ($20000..$21fff)

* Code (with some interleaved data)
    * Inventory/shops ($20000..$20b1e)
    * Inventory/shops ($21500..$21aed)
    * Save menu ($21aee..$21bb9)
    * Save/load ($21bba..$21da3)
* Menu data ($20b1f..$21470)
    * Includes messages, sprites, item graphics/names/metadata
* Shop data ($21da4..$21f99)
* Unused space
    * 143 bytes after menu data tables ($21471..$214ff)
    * 102 bytes at end ($21f9a..$21fff)

### Segment $11 ($22000..$23fff)

* Code (with some interleaved data)
    * Credits sequence ($22000..$22b94)
* Credits tile/sprite/timing data ($22b95..$23fb3)
* Unused space
    * 76 bytes at end ($23fb4..$23fff)

### Segment $12 and $13 ($24000..$27fff)

* Code (with some interleaved data)
    * SNK logo splash screen ($24000..$240de)
    * Graphics utility routines? ($240df..$242bd)
    * Title screen and movie ($242be..$2438a)
    * Title screen and movie ($25fc2..$26355)
    * Name entry computer ($26356..$26652)
    * Title menu and movie ($26653..$27161)
    * Player death and opel statue ($27900..$27a64)
    * Status bar nametable setup ($27a65..$27ad8)
    * Game animations ($27b39..$27ff1)
        * Includes magic, sword raising, thrusting Crystalis
* Title screen and movie data ($2438b..$25fc1)
* Title movie and name computer data ($27162..$2788c)
* Status bar initialization data ($27ad9..$27b38)
* Unused space
    * 115 bytes after name computer data ($2788d..$278ff)
    * 14 bytes at end ($27ff2..$27fff)

### Segment $14 ($28000..$29fff)

* Code (with some interleaved data)
    * Message decoding/drawing ($28500..$28878)
    * ??, probably about messages ($29400..$29766)
* Message index tables ($28000..$28465)
* Message graphics tables ($28879..$288a4)
* Reused words ($28900..$2922a)
* Unknown (message?) table ($29767..$29b4d)
* Ad hoc spawn table ($29c00..$29e7f)
* Unused space
    * 154 bytes after message index ($28466..$284ff)
    *  91 bytes before common words table ($288a5..$288ff)
    * 469 bytes after reused words table ($2922b..$293ff)
    * 178 bytes after unknown table ($29b4e..$29bff)
    * 384 bytes at end ($29e80..$29fff)

### Segments $15..$17 ($2a000..$2ffff)

* Dialog message tables, bank $15 ($2a000..$2bf30)
* Dialog message tables, bank $16 ($2c000..$2df8f)
* Dialog message tables, bank $17 ($2e000..$2fbd4)
* Code for checkpoints and saves ($2fc00..$2ffff)
* Unused space
    * 207 bytes at end of bank $15 ($2bf31..$2bfff)
    * 112 bytes at end of bank $16 ($2df90..$2dfff)
    *  43 bytes at end of bank $17 ($2fbd5..$2fbff)

### Segment $18 and $19 ($30000..$33fff)

* Code (with some interleaved data)
    * Audio routines, run during IRQ ($30000..$30713)
* Audio engine tables ($30714..$30c0b)
* BGM tracks ($30c0c..$33ff0)
* Unused space
    * 15 bytes at end ($33ff1..$33fff)

### Segment $1a and $1b ($34000..$37fff)

* Code (with some interleaved data)
    * Vector arithmetic ($34409..$344bb)
    * Palette handling ($34c0e..$34cbf)
    * HUD display ($34cc0..$34f6d)
    * Hitbox collisions ($34f6e..$3572c)
    * Adhoc spawns ($3472d..357d6)
    * Random numbers ($357d7..$35823)
    * Vector arithmetic ($34824..$358b8)
    * Adhoc spawns ($358b9..$358d6)
    * Movement/terrain ($358d7..$35adf)
    * MP usage ($35ae8..$35b06)
    * Boss palettes ($35b07..$35b40)
    * Player movement/sword ($35b41..$36070)
    * Magic routines ($36072..$361c0)
    * Player movement/sword ($361c9..$36249)
    * Object action scripts ($3624a..$37e3f)
* Displacement to direction table ($34000..$343ff)
* Speed tables ($344bc..$34b7e)
* Player stats and coin info tables ($34b7f..$34c0d)
* Powers of two ($35ae0..$35ae7)
* Unused space
    * 9 bytes after direction table ($34400..$34408)
    * 8 bytes after magic routines ($361c1..$361c8)
    * 480 bytes at end ($37e40..$37fff)

### Segment $1c and $1d ($38000..$3bfff)

* Code (with some interleaved data)
    * Sprite/metasprite routines ($38000..$383d7)
* Sprite flicker table ($383d8..$3845b)
* Metasprite table ($3845c..$3bf34)
* Unused space
    * 203 bytes at end ($3bf35..$3bfff)

### Fixed segments $fe and $ff

* Code
    * Equipment/status ($3c008..$3c124)
    * Audio track management ($3c125..$3c168)
    * Sprite management ($3c169..$3c221)
    * Object spawning ($3c25d..$3c40d)
    * Bank management ($3c40e..$3c435)
    * NMI/rendering management ($3c436..3c481)
    * Nametable management ($3c482..$3c7a4)
    * Location data management ($3c7a5..$3c7d5)
    * Overflow from segment $10? ($3c7d6..$3c830)
    * Screen rendering/scrolling ($3c831..$3c8bf)
    * Main loop ($3c900..$3d122)
    * Dialog ($3d124..$3d3d9)
    * Mimics, chests, items, and triggers ($3d3da..$3d88a)
    * Misc utility for items/dialog ($3d88b..$3d8c6)
    * Inventory and shops ($3d8c7..$3db27)
    * Magic/warp ($3db27..$3e0b7)
    * NPC and object spawning ($3e0b8..$3e3d8)
    * Location switching ($3e3d9..$3e844)
    * Player movement ($3e845..$3eb6c)
    * Map drawing/scrolling ($3eb6d..$3ef54)
    * Passive/status effects ($3ef55..$3f0a3)
    * Save file checksums ($3f0a4..$3f2a3)
    * Reset handler ($3f2a4..$3f3b5)
    * NMI handler ($3f3b6..$3f423)
    * IRQ handler ($3f424..$3f8ca)
    * NMI utility ($3f8cb..$3f9b9)
    * Controller polling ($3fe80..$3ff43)
    * Global versions of banked routines ($3ff80..$3ffe2)
* Powers of two ($3c000..$3c007)
* Powers of two in reverse ($3c222..$3c229)
* DMC sample ($3fa00..$3fddf)
* Vectors ($3fffa..$3ffff)
* Unused debug code
    * Something when walking into shops ($3fe00..$3fe2d)
* Unused space
    * 50 bytes ($3c22a..$3c25b)
    * 64 bytes ($3c8c0..$3c8ff)
    * 70 bytes ($3f9ba..$3f9ff)
    * 32 bytes ($3fde0..$3fdff)
    * 74 bytes ($3fe2e..$3fe77), maybe 8 following as well?
    * 60 bytes ($3ff44..$3ff7f)
    * 29 bytes ($3ffe3..$3fff9)

