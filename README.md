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
    * ?? bytes after message index ($28466..$284ff)
    * ?? bytes before common words table ($288a5..$288ff)
    * ?? bytes after reused words table ($2922b..$293ff)
    * ?? bytes after unknown table ($29b4e..$29bff)
    * ?? bytes at end ($29e80..$29fff)

### Segments $15..$17 ($2a000..$2ffff)

* Dialog message tables, bank $15 ($2a000..$2bf30)
* Dialog message tables, bank $16 ($2c000..$2df8f)
* Dialog message tables, bank $17 ($2e000..$2fbd4)
* Code for checkpoints and saves ($2fc00..$2ffff)
* Unused space
    * ?? bytes at end of bank $15 ($2bf31..$2bfff)
    * ?? bytes at end of bank $16 ($2df90..$2dfff)
    * ?? bytes at end of bank $17 ($2fbd5..$2fbff)

### Segment $18

TODO ...
